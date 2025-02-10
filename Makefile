.PHONY: check build diff switch diff-and-switch
.PHONY: update generate-hardware-configuration
.PHONY: collect-garbage collect-garbage-system collect-garbage-home
.PHONY: print-%

HOSTNAME := $(shell hostname -s)
OS := $(shell uname -s)
TARGET := $(if $(filter Darwin,$(OS)),darwinConfigurations.$(HOSTNAME).system,nixosConfigurations.$(HOSTNAME).config.system.build.toplevel)
REBUILD := $(if $(filter Darwin,$(OS)),darwin-rebuild,nixos-rebuild)

NOM := $(shell { command -v nom || command -v nix; } 2>/dev/null)

GC_MIN_AGE := 14d

check:
	nix flake check '.?submodules=1'

diff-and-switch: build
	$(MAKE) -o build diff
	@echo "Switch to new derivation? [y/N] " && read ans && [ $${ans:-N} = y ]
	$(MAKE) -o build switch

build:
	$(NOM) build --extra-experimental-features 'nix-command flakes' .?submodules=1#$(TARGET)
	@if [ -d /var/run/current-system ]; then \
		nix store diff-closures /var/run/current-system ./result; \
	else \
		echo "/var/run/current-system missing. first run?"; \
	fi

diff: build
	# nix shell 'nixpkgs#nix-diff' -c nix-diff --color=always --skip-already-compared /var/run/current-system ./result | less -R --quit-if-one-screen
	nix run 'nixpkgs#nvd' -- --color always /var/run/current-system ./result | less --raw-control-chars --quit-if-one-screen

switch: build
	result/sw/bin/$(REBUILD) switch --flake .?submodules=1#

update:
	nix flake update

collect-garbage-system:
	sudo nix-collect-garbage --delete-older-than $(GC_MIN_AGE)

collect-garbage-home:
	nix-collect-garbage --delete-older-than $(GC_MIN_AGE)

collect-garbage: collect-garbage-system collect-garbage-home

generate-hardware-configuration: hosts/$(HOSTNAME)/hardware-configuration.nix

hosts/$(HOSTNAME)/hardware-configuration.nix: | hosts/$(HOSTNAME)
	@if nixos-generate-config --show-hardware-config > $@; then \
		echo "Hardware configuration updated"; \
	else \
		echo "nixos-generate-config failed. Try running the command again with sudo"; \
		false; \
	fi

print-%:
	@echo $*=$($*)
