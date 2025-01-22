# From @thexyno's repo:
# https://github.com/thexyno/nixos-config/blob/1685aa3a522439c75849c5e62f44a57f72312650/lib/attrs.nix

{ lib, ... }:

with builtins;
with lib;
rec {
  # attrsToList
  attrsToList = attrs: mapAttrsToList (name: value: { inherit name value; }) attrs;

  # mapFilterAttrs ::
  #   (name -> value -> bool)
  #   (name -> value -> { name = any; value = any; })
  #   attrs
  mapFilterAttrs =
    pred: f: attrs:
    filterAttrs pred (mapAttrs' f attrs);

  # Generate an attribute set by mapping a function over a list of values.
  genAttrs' = values: f: listToAttrs (map f values);

  # anyAttrs :: (name -> value -> bool) attrs
  anyAttrs = pred: attrs: any (attr: pred attr.name attr.value) (attrsToList attrs);

  # countAttrs :: (name -> value -> bool) attrs
  countAttrs = pred: attrs: count (attr: pred attr.name attr.value) (attrsToList attrs);
}
