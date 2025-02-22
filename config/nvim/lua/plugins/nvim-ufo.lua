---@type LazySpec
return {
  "kevinhwang91/nvim-ufo",
  event = "BufReadPost",
  dependencies = "kevinhwang91/promise-async",
  config = function()
    -- vim.o.foldcolumn = "1"
    vim.o.foldlevel = 99
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true
    vim.opt.fillchars:append([[fold: ,foldopen:,foldsep: ,foldclose:]])

    local ufo = require("ufo")
    local map = require("core.utils").map

    map("n", "zR", ufo.openAllFolds, "Open all folds")
    map("n", "zM", ufo.closeAllFolds, "Close all folds")

    require("ufo").setup({
      open_fold_hl_timeout = 150,
      provider_selector = function()
        return { "treesitter", "indent" }
      end,
      fold_virt_text_handler = function(
        virt_text,
        lnum,
        end_lnum,
        width,
        truncate
      )
        local new_virt_text = {}
        local suffix = ("  %d "):format(end_lnum - lnum)
        local target_width = width - vim.fn.strdisplaywidth(suffix)
        local cur_width = 0

        for _, chunk in ipairs(virt_text) do
          local chunk_text = chunk[1]
          local chunk_width = vim.fn.strdisplaywidth(chunk_text)

          if target_width > cur_width + chunk_width then
            table.insert(new_virt_text, chunk)
          else
            local hlgroup = chunk[2]
            chunk_text = truncate(chunk_text, target_width - cur_width)
            table.insert(new_virt_text, { chunk_text, hlgroup })
            chunk_width = vim.fn.strdisplaywidth(chunk_text)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if cur_width + chunk_width < target_width then
              suffix = suffix
                .. (" "):rep(target_width - cur_width - chunk_width)
            end
            break
          end

          cur_width = cur_width + chunk_width
        end

        table.insert(new_virt_text, { suffix, "MoreMsg" })
        return new_virt_text
      end,
    })
  end,
}
