-- Do not autoclose preview window
vim.g.mkdp_auto_close = 0

if not vim.env.IS_TERMUX then
    -- Default browser to open markdown files
    vim.g.mkdp_browser = "firefox"
end
