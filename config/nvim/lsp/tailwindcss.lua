vim.lsp.config("tailwindcss", {
  root_dir = function(bufnr, on_dir)
    local util = require("lspconfig.util")
    local root_files = {
      "tailwind.config.js",
      "tailwind.config.cjs",
      "tailwind.config.mjs",
      "tailwind.config.ts",
      -- 'postcss.config.js',
      -- 'postcss.config.cjs',
      -- 'postcss.config.mjs',
      -- 'postcss.config.ts',
    }
    local fname = vim.api.nvim_buf_get_name(bufnr)
    root_files = util.insert_package_json(root_files, "tailwindcss", fname)
    on_dir(
      vim.fs.dirname(
        vim.fs.find(root_files, { path = fname, upward = true })[1]
      )
    )
  end,
  settings = {
    tailwindCSS = {
      experimental = {
        classRegex = {
          -- clsx, cn
          -- https://github.com/tailwindlabs/tailwindcss-intellisense/issues/682#issuecomment-1364585313
          { [[clsx\(([^)]*)\)]], [["([^"]*)"]] },
          { [[cn\(([^)]*)\)]], [["([^"]*)"]] },
          -- Tailwind Variants
          -- https://www.tailwind-variants.org/docs/getting-started#intellisense-setup-optional
          { [[tv\(([^)]*)\)]], [==[["'`]([^"'`]*).*?["'`]]==] },
        },
      },
    },
  },
})
