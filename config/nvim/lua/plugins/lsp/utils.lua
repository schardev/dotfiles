local M = {}

--- Takes a client name and generates utility mappings for that client
M.generate_ts_mappings = function(client_name)
  local organize_imports = client_name == "tsserver"
      and "<Cmd>TypescriptOrganizeImports<CR>"
    or "<Cmd>VtsExec organize_imports<CR>"

  local rename_file = client_name == "tsserver"
      and "<Cmd>TypescriptRenameFile<CR>"
    or "<Cmd>VtsExec rename_file<CR>"

  local add_missing_imports = client_name == "tsserver"
      and "<Cmd>TypescriptAddMissingImports<CR>"
    or "<Cmd>VtsExec add_missing_imports<CR>"

  local go_to_source_definition = client_name == "tsserver"
      and "<Cmd>TypescriptGoToSourceDefinition<CR>"
    or "<Cmd>VtsExec go_to_source_definition<CR>"

  local remove_unused_imports = client_name == "tsserver"
      and "<Cmd>TypescriptRemoveUnused<CR>"
    or "<Cmd>VtsExec remove_unused_imports<CR>"

  return {
    organize_imports = organize_imports,
    rename_file = rename_file,
    add_missing_imports = add_missing_imports,
    go_to_source_definition = go_to_source_definition,
    remove_unused_imports = remove_unused_imports,
  }
end

return M
