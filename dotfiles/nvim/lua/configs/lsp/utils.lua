local M = {}

-- Whether to attach the source based on the presence of its config file
-- https://github.com/jose-elias-alvarez/null-ls.nvim/issues/509
local lsp_util = require("lspconfig").util
M.check_runtime_condition = function(config_names)
    -- Cache the result to avoid checking everytime
    local bufnr_cache = {}

    return function(params)
        if bufnr_cache[params.bufnr] ~= nil then
            return bufnr_cache[params.bufnr]
        end

        local config_path = lsp_util.root_pattern(config_names)(params.bufname)
        local has_config = config_path ~= nil
        bufnr_cache[params.bufnr] = has_config

        return has_config
    end
end

-- Spawn source command with lsp resolved root_dir
-- https://github.com/jose-elias-alvarez/null-ls.nvim/issues/289
M.spawn_with_lsp_root = function(params, server)
    require("lspconfig")[server].get_root_dir(params.bufname)
end

return M
