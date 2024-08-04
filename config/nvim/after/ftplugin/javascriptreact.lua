-- Source javascript ftplugin
vim.cmd("runtime! ftplugin/javascript.lua")

-- React directives
vim.cmd.inoreabbrev("uc", '"use client";')
vim.cmd.inoreabbrev("us", '"use server";')
