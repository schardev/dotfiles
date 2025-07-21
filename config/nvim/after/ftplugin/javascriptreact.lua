-- Source javascript ftplugin
vim.cmd("runtime! ftplugin/javascript.lua")

-- React directives
vim.cmd.inoreabbrev("ruc", '"use client";')
vim.cmd.inoreabbrev("rus", '"use server";')
