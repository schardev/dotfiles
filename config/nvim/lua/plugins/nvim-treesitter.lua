---@class QueryKeymap
---@field query string
---@field desc string

---@alias SelectKeymap table<string, QueryKeymap>

---@class SwapKeymap
---@field swap_next table<string, QueryKeymap>
---@field swap_previous table<string, QueryKeymap>

---@class MoveKeymap
---@field goto_next_start table<string, QueryKeymap>
---@field goto_previous_start table<string, QueryKeymap>

---@class TreesitterKeymapConfig
---@field select SelectKeymap
---@field swap SwapKeymap
---@field move MoveKeymap

---@type LazySpec
return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local enabled_parsers = {
        "bash",
        "css",
        "html",
        "http",
        "javascript",
        "jsdoc",
        "json",
        -- "jsonc",
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
      vim.api.nvim_create_autocmd("User", {
        pattern = "TSUpdate",
        callback = function()
          local scss_parser = require("nvim-treesitter.parsers").scss
          scss_parser.install_info.url =
            "https://github.com/schardev/tree-sitter-scss"
          scss_parser.install_info.revision = "master"
        end,
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = vim.list_extend(vim.deepcopy(enabled_parsers), {
          "typescriptreact",
          "jsonc",
        }),
        callback = function()
          vim.treesitter.start()
          vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
          vim.wo.foldmethod = "expr"
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })

      require("nvim-treesitter").install(enabled_parsers)
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    config = function()
      require("nvim-treesitter-textobjects").setup({
        select = {
          lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
        },
        move = {
          set_jumps = true, -- whether to set jumps in the jumplist
        },
      })

      ---@type TreesitterKeymapConfig
      local keymap_config = {
        select = {
          ["af"] = {
            query = "@function.outer",
            desc = "Select around function",
          },
          ["if"] = {
            query = "@function.inner",
            desc = "Select inside function",
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
        swap = {
          swap_next = {
            ["]p"] = {
              query = "@parameter.inner",
              desc = "Swap next paramater",
            },
            -- defined in after/queries/ecma/textobjects.scm
            ["]t"] = {
              query = "@user.ternary.inner",
              desc = "Swap next ternary",
            },
          },
          swap_previous = {
            ["[p"] = {
              query = "@parameter.inner",
              desc = "Swap previous parameter",
            },
            ["[t"] = {
              query = "@user.ternary.inner",
              desc = "Swap previous ternary",
            },
          },
        },
        move = {
          goto_next_start = {
            ["]f"] = {
              query = "@function.outer",
              desc = "Next function start",
            },
            ["]]"] = {
              query = "@class.outer",
              desc = "Next class start",
            },
          },
          goto_previous_start = {
            ["[f"] = {
              query = "@function.outer",
              desc = "Previous function start",
            },
            ["[["] = {
              query = "@class.outer",
              desc = "Previous class start",
            },
          },
        },
      }

      local ts_select = require("nvim-treesitter-textobjects.select")
      local ts_swap = require("nvim-treesitter-textobjects.swap")
      local ts_move = require("nvim-treesitter-textobjects.move")
      local map = require("core.utils").map

      ---@param config table<string, QueryKeymap>
      ---@param modes string[]
      ---@param handler fun(query: string)
      local function set_keymap(config, modes, handler)
        for key, value in pairs(config) do
          map(modes, key, function()
            handler(value.query)
          end, value.desc)
        end
      end

      -- select
      set_keymap(keymap_config.select, { "x", "o" }, function(q)
        ts_select.select_textobject(q, "textobjects")
      end)

      -- swap
      set_keymap(keymap_config.swap.swap_next, { "n" }, ts_swap.swap_next)
      set_keymap(
        keymap_config.swap.swap_previous,
        { "n" },
        ts_swap.swap_previous
      )

      -- move
      set_keymap(
        keymap_config.move.goto_next_start,
        { "n", "x", "o" },
        function(q)
          ts_move.goto_next_start(q, "textobjects")
        end
      )
      set_keymap(
        keymap_config.move.goto_previous_start,
        { "n", "x", "o" },
        function(q)
          ts_move.goto_previous_start(q, "textobjects")
        end
      )
    end,
  },
}
