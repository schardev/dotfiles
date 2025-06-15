return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      -- treesitter powered textobjects
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
      local enabled_parsers = {
        "bash",
        "css",
        "html",
        "http",
        "javascript",
        "jsdoc",
        "json",
        "jsonc",
        "lua",
        "markdown",
        "markdown_inline",
        "query",
        "scss",
        "sql",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
      }

      -- Use scss parser fork for improved placeholder selector support
      -- TODO: remove when upstream adds support
      ---@see https://github.com/serenadeai/tree-sitter-scss/pull/19
      local scss_parser =
        require("nvim-treesitter.parsers").get_parser_configs().scss
      scss_parser.install_info.url =
        "https://github.com/schardev/tree-sitter-scss"
      scss_parser.install_info.revision = "master"

      ---@diagnostic disable-next-line: missing-fields
      require("nvim-treesitter.configs").setup({
        -- One of "all", "maintained" (parsers with maintainers), or a list of languages
        ensure_installed = enabled_parsers,

        -- Install languages synchronously (only applied to `ensure_installed`)
        sync_install = false,

        -- List of parsers to ignore installing
        -- ignore_install = { "javascript" },

        highlight = {
          -- `false` will disable the whole extension
          enable = true,

          -- list of language that will be disabled
          -- disable = {},

          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          additional_vim_regex_highlighting = false,
        },

        -- textobjects
        textobjects = {
          select = {
            enable = true,
            lookahead = true,

            keymaps = {
              ["af"] = {
                query = "@function.outer",
                desc = "Select around funtion",
              },
              ["if"] = {
                query = "@function.inner",
                desc = "Select inside funtion",
              },
              ["ac"] = {
                query = "@class.outer",
                desc = "Select outer class",
              },
              ["ic"] = {
                query = "@class.inner",
                desc = "Select inner class",
              },
              ["aP"] = {
                query = "@parameter.outer",
                desc = "Select around parameter",
              },
              ["iP"] = {
                query = "@parameter.inner",
                desc = "Select inside parameter",
              },
              ["aC"] = {
                query = "@conditional.outer",
                desc = "Select around conditional",
              },
              ["iC"] = {
                query = "@conditional.inner",
                desc = "Select inside conditional",
              },
            },

            -- choose the select mode (default is charwise 'v')
            -- selection_modes = {
            --   ["@function.inner"] = "v",
            --   ["@function.outer"] = "V",
            -- },
          },

          swap = {
            enable = true,
            swap_next = {
              ["]p"] = "@parameter.inner",
              ["]t"] = "@user.ternary.inner", -- defined in after/queries/ecma/textobjects.scm
            },
            swap_previous = {
              ["[p"] = "@parameter.inner",
              ["[t"] = "@user.ternary.inner",
            },
          },

          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              ["]f"] = {
                query = "@function.outer",
                desc = "Next function start",
              },
              ["]]"] = { query = "@class.outer", desc = "Next class start" },
            },
            goto_previous_start = {
              ["[f"] = "@function.outer",
              ["[["] = "@class.outer",
            },
          },
        },

        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gnn",
            node_decremental = "<S-Tab>",
            node_incremental = "<Tab>",
            scope_incremental = "<CR>",
          },
        },

        playground = {
          enable = true,
          updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
        },

        query_linter = {
          enable = true,
          use_virtual_text = true,
          lint_events = { "BufWrite", "CursorHold" },
        },

        indent = {
          enable = true,
        },
      })
    end,
  },
}
