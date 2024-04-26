return {
  NVIM_USER_USE_TSSERVER = vim.env.NVIM_USER_USE_TSSERVER and true or false,
  NVIM_USER_ONLY_CORE = vim.env.NVIM_USER_ONLY_CORE and true or false,
  NVIM_USER_CONFIG_DIR = vim.env.XDG_CONFIG_HOME
    or vim.env.CONFIG_DIR
    or "~/.config/nvim",
}
