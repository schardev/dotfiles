local command = vim.api.nvim_create_user_command

local packer_cmd = function(callback, args)
    return function()
        require("plugins")
        require("packer")[callback](args)
    end
end

-- Define packer commands since we're loading it on-demand
command("PackerSnapshot", function(param)
    packer_cmd("snapshot", param.args)
end, { nargs = "+" })

command("PackerSnapshotDelete", function(param)
    require("plugins")
    require("packer.snapshot").delete(param.args)
end, { nargs = "+" })

command("PackerSnapshotRollback", function(param)
    packer_cmd("rollback", param.args)
end, { nargs = "+" })

command("PackerClean", packer_cmd("clean"), {})
command("PackerCompile", packer_cmd("compile"), {})
command("PackerInstall", packer_cmd("install"), {})
command("PackerStatus", packer_cmd("status"), {})
command("PackerSync", packer_cmd("sync"), {})
command("PackerUpdate", packer_cmd("update"), {})
command("PackerProfile", packer_cmd("profile_output"), {})
