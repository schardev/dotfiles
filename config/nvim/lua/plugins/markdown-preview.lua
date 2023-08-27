return {
  "iamcco/markdown-preview.nvim",
  build = "cd app && yarn install",
  ft = "markdown",
  cmd = "MarkdownPreview",
  config = function()
    -- Do not autoclose preview window
    vim.g.mkdp_auto_close = 0

    if not vim.env.IS_TERMUX then
      -- Default browser to open markdown files
      vim.g.mkdp_browser = "brave"
    end
  end,
}
