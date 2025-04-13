vim.lsp.config("tailwindcss", {
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
