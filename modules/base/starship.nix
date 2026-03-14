{
  den.aspects.base = {
    homeManager = {
      programs.starship = {
        enable = true;
        settings = {
          right_format = "$status";
          character = {
            success_symbol = "[❯](purple)";
            error_symbol = "[❯](red)";
            vimcmd_symbol = "[❮](green)";
          };
          directory = {
            style = "blue";
            read_only = " 󰌾";
            # truncation_symbol = "…/"
            substitutions = {
              "E:/Users/adamh" = "(E:) ~";
              "F:/Users/adamh" = "(F:) ~";
              "G:/Users/adamh" = "(G:) ~";
            };
          };
          cmd_duration = {
            format = "[$duration]($style) ";
            # format = "⏱  [$duration](bold yellow)"
            style = "yellow";
          };
          c = {
            symbol = "  ";
          };
          crystal = {
            symbol = "  ";
          };
          direnv = {
            disabled = true;
          };
          docker_context = {
            symbol = "  ";
          };
          elixir = {
            symbol = "  ";
          };
          fennel = {
            symbol = "  ";
          };
          fossil_branch = {
            symbol = " ";
          };
          gcloud = {
            disabled = true;
          };
          git_branch = {
            format = "[$branch(:$remote_branch)]($style) ";
            style = "bright-black";
            symbol = " ";
          };
          git_commit = {
            tag_disabled = false;
            tag_symbol = "  ";
          };
          git_metrics = {
            disabled = true;
          };
          git_status = {
            format = "([$all_status$ahead_behind]($style) )";
            conflicted = "⚠️";
            ahead = "[⇡\${count}](green)";
            behind = "⇣\${count}";
            diverged = "[⇡\${ahead_count}⇣\${behind_count}](bold red)"; # ⇕
            up_to_date = "";
            untracked = "[?\${count}](red)";
            stashed = "≡\${count}";
            modified = "~\${count}";
            staged = "[+\${count}](green)";
            renamed = "»\${count}";
            deleted = "[-\${count}](red)";
            typechanged = "";
            style = "cyan";
            # style = "bold yellow";
            ignore_submodules = false;
          };
          golang = {
            symbol = " ";
          };
          haskell = {
            symbol = " ";
          };
          java = {
            symbol = " ";
          };
          kotlin = {
            symbol = " ";
          };
          lua = {
            symbol = " ";
          };
          meson = {
            symbol = "󰔷 ";
          };
          nix_shell = {
            symbol = " ";
          };
          nodejs = {
            symbol = " ";
          };
          package = {
            symbol = "󰏗 ";
          };
          perl = {
            symbol = " ";
          };
          php = {
            symbol = " ";
          };
          python = {
            symbol = " ";
          };
          ruby = {
            symbol = " ";
          };
          rust = {
            symbol = "󱘗 ";
          };
          status = {
            format = "[$symbol$status( $common_meaning)]($style)";
            symbol = "";
            pipestatus = true;
            disabled = false;
          };
          sudo = {
            disabled = false;
          };
        };
      };
    };
  };
}
