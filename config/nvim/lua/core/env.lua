return {
  NVIM_USER_USE_TS_LS = vim.env.NVIM_USER_USE_TS_LS and true or false,
  NVIM_USER_ONLY_CORE = vim.env.NVIM_USER_ONLY_CORE and true or false,
  NVIM_USER_CONFIG_DIR = vim.env.XDG_CONFIG_HOME
    or vim.env.CONFIG_DIR
    or "~/.config/nvim",
}
