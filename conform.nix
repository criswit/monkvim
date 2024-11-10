{pkgs, ...}: {
  binaries = [];
  lazy = with pkgs.vimPlugins; ''
    {
          dir = "${conform-nvim}",
          name = "conform",
          event = { "BufReadPre", "BufNewFile" },
          config = function ()
            local conform = require("conform")

            conform.setup({
              formatters = {
                stylua = {
                  command = vim.fn.fnamemodify("~/.nix-profile/bin/stylua", ":p")
                }
              },
              formatters_by_ft = {
                javascript = { "prettier" },
                typescript = { "prettier" },
                javascriptreact = { "prettier" },
                typescriptreact = { "prettier" },
                svelte = { "prettier" },
                css = { "prettier" },
                html = { "prettier" },
                json = { "prettier" },
                yaml = { "prettier" },
                markdown = { "prettier" },
                graphql = { "prettier" },
                liquid = { "prettier" },
                lua = { "stylua" },
                python = { "isort", "black" },
                nix = { "alejandra" }

              },
              format_on_save = {
                lsp_fallback = true,
                async = false,
                timeout_ms = 1000,
              },
            })

            vim.keymap.set({ "n", "v" }, "<leader>mp", function()
              conform.format({
                lsp_fallback = true,
                async = false,
                timeout_ms = 1000,
              })
            end, { desc = "Format file or range (in visual mode)" })
          end,
    }
  '';
}
