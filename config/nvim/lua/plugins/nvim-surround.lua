local function javascript_ft_setup()
  -- https://github.com/kylechui/nvim-surround/discussions/53#discussioncomment-16104009
  require("nvim-surround").buffer_setup({
    aliases = { ["s"] = false },
    surrounds = {
      ["s"] = {
        add = function()
          local cur = vim.treesitter.get_node()

          if not cur then
            return
          end

          local cur_type = cur:type()
          local interpolation_surround = { { "${" }, { "}" } }
          if
            cur and (cur_type == "string" or cur_type == "string_fragment")
          then
            vim.cmd.normal("csq`")
            return interpolation_surround
          elseif cur and cur_type == "template_string" then
            return interpolation_surround
          else
            return { { "`${" }, { "}`" } }
          end
        end,
        find = function()
          local node = vim.treesitter.get_node()
          while node do
            if node:type() == "template_substitution" then
              local sr, sc, er, ec = node:range()
              return {
                first_pos = { sr + 1, sc + 1 },
                last_pos = { er + 1, ec },
              }
            end
            node = node:parent()
          end
        end,
        delete = function()
          local node = vim.treesitter.get_node()
          while node do
            if node:type() == "template_substitution" then
              local sr, sc, er, ec = node:range()
              return {
                left = {
                  first_pos = { sr + 1, sc + 1 },
                  last_pos = { sr + 1, sc + 2 },
                },
                right = {
                  first_pos = { er + 1, ec },
                  last_pos = { er + 1, ec },
                },
              }
            end
            node = node:parent()
          end
        end,
      },
    },
  })
end

local function markdown_ft_setup()
  require("nvim-surround").buffer_setup({
    surrounds = {
      -- https://github.com/kylechui/nvim-surround/discussions/53
      ["l"] = {
        add = function()
          local clipboard = vim.fn.getreg("+"):gsub("\n", "")
          return {
            { "[" },
            { "](" .. clipboard .. ")" },
          }
        end,
        find = "%b[]%b()",
        delete = "^(%[)().-(%]%b())()$",
        change = {
          target = "^()()%b[]%((.-)()%)$",
          replacement = function()
            local clipboard = vim.fn.getreg("+"):gsub("\n", "")
            return {
              { "" },
              { clipboard },
            }
          end,
        },
      },
    },
  })
end

local function typescript_ft_setup()
  local config = require("nvim-surround.config")

  require("nvim-surround").buffer_setup({
    surrounds = {
      -- https://github.com/kylechui/nvim-surround/discussions/53
      ["g"] = {
        add = function()
          local result = config.get_input("Enter the generic name: ")
          if result then
            return { { result .. "<" }, { ">" } }
          end
        end,
        find = function()
          return config.get_selection({ node = "generic_type" })
        end,
        delete = "^(.-<)().-(>)()$",
        change = {
          target = "^(.-<)().-(>)()$",
          replacement = function()
            local result = config.get_input("Enter the generic name: ")
            if result then
              return { { result .. "<" }, { ">" } }
            end
          end,
        },
      },
    },
  })
end

---@type LazySpec
return {
  -- Surrounding stuff efficiently
  ---@module 'nvim-surround'
  "kylechui/nvim-surround",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    local surround = require("nvim-surround")
    surround.setup()

    -- buffer local setup
    local ts_setup = function()
      javascript_ft_setup()
      typescript_ft_setup()
    end

    local buf_config = {
      javascript = javascript_ft_setup,
      javascriptreact = javascript_ft_setup,
      typescript = ts_setup,
      typescriptreact = ts_setup,
      markdown = markdown_ft_setup,
    }

    for ft, setup in pairs(buf_config) do
      vim.api.nvim_create_autocmd("FileType", {
        pattern = ft,
        callback = setup,
      })
    end
  end,
}
