{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:

{
  programs.nvf = {
    enable = true;
    # your settings need to go into the settings attribute set
    # most settings are documented in the appendix
    settings = lib.mkForce {
      vim = {
        theme = {
          enable = false;
          name = "onedark";
          style = "cool";
          #name = "rose-pine";
          #style = "main";
          transparent = true;
        };
        extraPlugins = {
          alabaster = {
            package = pkgs.vimUtils.buildVimPlugin {
              name = "alabaster.nvim";
              src = pkgs.fetchFromGitHub {
                owner = "p00f";
                repo = "alabaster.nvim";
                rev = "master";
                sha256 = "sha256-Rp/nl5dlz55aChrYUL7ir3XtWDFFS99CHS3l3FoCI7c=";
              };
            };

            setup = ''
              vim.o.background = "dark"  -- "light" or "dark"
              vim.cmd.colorscheme("alabaster")
              vim.api.nvim_set_hl(0, "Visual", { bg = "#e6e6e6" })
              vim.api.nvim_set_hl(0, "CursorLine", { bg = "#f0f0f0" })
            '';
          };
        };
        viAlias = true;
        vimAlias = true;

        spellcheck = {
          enable = true;
        };

        options.tabstop = 2;
        options.shiftwidth = 2;

        lsp = {
          enable = true;
          formatOnSave = true;
          lspkind.enable = false;
          lightbulb.enable = true;
          lspsaga.enable = false;
          trouble.enable = true;
          lspSignature.enable = false;
          otter-nvim.enable = true;
          nvim-docs-view.enable = true;
        };

        languages = {
          enableTreesitter = true;

          nix.enable = true;
          bash.enable = true;
          clang.enable = true;
          arduino.enable = true;
          css.enable = true;
          html.enable = false; # BROKEN
          sql.enable = true;
          java.enable = true;
          #odin.enable = true; # BROKEN
          kotlin.enable = true;
          lua = {
            enable = true;
            format.enable = true;
            lsp.enable = true;
            treesitter.enable = true;
          };
          zig.enable = false; # BROKEN
          python.enable = true;
          typst.enable = true;
          rust = {
            enable = false;
            extensions.crates-nvim.enable = false;
          };
          assembly.enable = true;
          csharp.enable = false;
          nim.enable = true;
        };

        visuals = {
          nvim-scrollbar.enable = true;
          nvim-web-devicons.enable = true;
          nvim-cursorline.enable = true;
          cinnamon-nvim.enable = true;
          fidget-nvim.enable = true;

          highlight-undo.enable = true;
          indent-blankline.enable = true;

          # Fun
          cellular-automaton.enable = false;
        };

        statusline = {
          lualine = {
            enable = true;
            theme = "gruvbox";
          };
        };
        autopairs.nvim-autopairs.enable = true;

        # nvf provides various autocomplete options. The tried and tested nvim-cmp
        # is enabled in default package, because it does not trigger a build. We
        # enable blink-cmp in maximal because it needs to build its rust fuzzy
        # matcher library.
        autocomplete = {
          nvim-cmp.enable = true; # false;
          blink-cmp.enable = false; # true;
        };

        snippets.luasnip.enable = true;

        filetree = {
          neo-tree = {
            enable = true;
          };
        };

        tabline = {
          nvimBufferline.enable = true;
        };

        treesitter = {
          context.enable = true;
          textobjects.enable = true;
        };

        binds = {
          whichKey.enable = true;
          cheatsheet.enable = true;
          hardtime-nvim.enable = false;
        };

        telescope.enable = true;

        git = {
          enable = true;
          gitsigns.enable = true;
          gitsigns.codeActions.enable = false; # throws an annoying debug message
        };

        minimap = {
          minimap-vim.enable = true;
          codewindow.enable = false; # BROKEN # lighter, faster, and uses lua for configuration
        };

        dashboard = {
          dashboard-nvim.enable = false;
          alpha.enable = true;
        };

        notify = {
          nvim-notify.enable = true;
        };

        projects = {
          project-nvim.enable = true;
        };

        utility = {
          ccc.enable = false;
          vim-wakatime.enable = false;
          diffview-nvim.enable = true;
          yanky-nvim.enable = false;
          icon-picker.enable = true;
          surround.enable = true;
          leetcode-nvim.enable = true;
          multicursors.enable = true;
          smart-splits.enable = true;

          motion = {
            hop.enable = true;
            leap.enable = true;
            precognition.enable = true;
          };
          images = {
            image-nvim.enable = false;
            img-clip.enable = true;
          };
        };

        terminal = {
          toggleterm = {
            enable = true;
            lazygit.enable = true;
          };
        };

        ui = {
          borders.enable = true;
          noice.enable = true;
          colorizer.enable = true;
          modes-nvim.enable = false; # the theme looks terrible with catppuccin
          illuminate.enable = true;
          breadcrumbs = {
            enable = true;
            navbuddy.enable = true;
          };
          smartcolumn = {
            enable = true;
            setupOpts.custom_colorcolumn = {
              # this is a freeform module, it's `buftype = int;` for configuring column position
              nix = "110";
              ruby = "120";
              java = "130";
              go = [
                "90"
                "130"
              ];
            };
          };
          fastaction.enable = true;
        };

        assistant = {
          chatgpt.enable = false;
          copilot = {
            enable = false;
            cmp.enable = true;
          };
          codecompanion-nvim.enable = false;
          avante-nvim.enable = false;
        };

        session = {
          nvim-session-manager.enable = false;
        };

        gestures = {
          gesture-nvim.enable = false;
        };

        comments = {
          comment-nvim.enable = true;
        };

        presence = {
          neocord.enable = false;
        };
      };
    };
  };
}
