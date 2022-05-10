local fn = vim.fn
local packer_path = fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"
if fn.empty(fn.glob(packer_path)) > 0 then
    fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        packer_path,
    })
end
vim.cmd("packadd packer.nvim")

local packer_group = vim.api.nvim_create_augroup("Packer", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
    group = packer_group,
    command = "source <afile> | PackerCompile",
    pattern = "plugins.lua",
})

local packer_config = {
    profile = {
        enable = true,
        threshold = 1, -- integer in milliseconds, plugins which load faster than this won't be shown in profile output
    },
    display = {
        open_fn = function()
            return require("packer.util").float({ border = "single" })
        end,
    },
}

return require("packer").startup({
    function(use)
        -------------------------
        ---       UTILS       ---
        -------------------------

        -- Improve startup time for Neovim
        use("lewis6991/impatient.nvim")

        -- Plugin manager
        use("wbthomason/packer.nvim")

        -- Shows human friendly startuptime
        use({ "dstein64/vim-startuptime", cmd = "StartupTime" })

        -- Text alignment
        use({ "godlygeek/tabular", ft = { "markdown" } })

        --  Markdown preview
        use({
            "iamcco/markdown-preview.nvim",
            run = "cd app && yarn install",
            ft = "markdown",
            cmd = "MarkdownPreview",
            config = function()
                -- Do not autoclose preview window
                vim.g.mkdp_auto_close = 0

                if not vim.env.IS_TERMUX then
                    -- Default browser to open markdown files
                    vim.g.mkdp_browser = "firefox"
                end
            end,
        })

        -- Emmet
        use({ "mattn/emmet-vim", ft = { "html", "css", "scss", "javascript" } })

        -- A plugin to ... umm ... comment stuff
        use({
            "numToStr/Comment.nvim",
            config = function()
                require("Comment").setup({})
            end,
        })

        -- For key mapping hints
        use({
            "folke/which-key.nvim",
            config = function()
                vim.defer_fn(function()
                    require("configs.which-key")
                end, 0)
            end,
        })

        -- Indent level
        use({
            "lukas-reineke/indent-blankline.nvim",
            config = function()
                require("configs.indent_blankline")
            end,
        })

        -- Lua fork of Nerdtree
        use({
            "kyazdani42/nvim-tree.lua",
            keys = { "<F1>", "<Leader><F1>" },
            cmd = { "NvimTreeToggle", "NvimTreeFindFileToggle" },
            config = function()
                require("configs.nvim-tree")
            end,
        })

        -- Fuzzy finder and more
        use({
            "nvim-telescope/telescope.nvim",
            cmd = "Telescope",
            cond = function()
                return not vim.env.IS_TERMUX
            end,
            requires = "nvim-lua/plenary.nvim",
        })

        -- Awesome git wrapper
        use({
            "tpope/vim-fugitive",
            cmd = { "Git", "Gstatus", "Gblame", "Gpush", "Gpull" },
        })

        -- Surrounding stuff
        -- P.S: no vimrc is complete without some tpope goodness
        use({ "tpope/vim-surround", requires = "tpope/vim-repeat" })

        ----------------------
        ---       UI       ---
        ----------------------

        -- File icons
        use({
            "kyazdani42/nvim-web-devicons",
            module = "nvim-web-devicons",
        })

        -- Cool start menu
        use({
            "mhinz/vim-startify",
            config = function()
                require("configs.startify")
            end,
        })

        -- Shows git signs in sign column
        use({
            "lewis6991/gitsigns.nvim",
            config = function()
                -- Don't try too hard to load gitsigns immediately
                vim.defer_fn(require("gitsigns").setup, 0)
            end,
        })

        -- Sax bufferline
        use({
            "akinsho/bufferline.nvim",
            requires = "nvim-web-devicons",
            config = function()
                require("configs.bufferline")
            end,
        })

        -- Colorschemes
        use({
            -- "folke/tokyonight.nvim",
            -- "navarasu/onedark.nvim",
            -- {
            "catppuccin/nvim",
            as = "catppuccin",
            -- },
        })

        -- Color preview
        use({
            "norcalli/nvim-colorizer.lua",
            cmd = "ColorizerAttachToBuffer",
            ft = { "css", "scss", "javascript" },
            config = function()
                require("configs.colorizer")
            end,
        })

        -- Statusline plugin
        use({
            "nvim-lualine/lualine.nvim",
            requires = {
                "nvim-web-devicons",
                -- {
                --     "nvim-lua/lsp-status.nvim",
                --     config = function()
                --         require("lsp-status").register_progress()
                --     end,
                -- },
            },
            config = function()
                require("configs.lualine")
            end,
        })

        use({
            "j-hui/fidget.nvim",
            config = function()
                require("fidget").setup({})
            end,
        })

        -- Better syntax highlighting
        use({
            {
                "nvim-treesitter/nvim-treesitter",
                run = ":TSUpdate",
                config = function()
                    require("configs.nvim-treesitter")
                end,
            },

            -- treesitter querying
            {
                "nvim-treesitter/playground",
                after = "nvim-treesitter",
                cmd = "TSHighlightCapturesUnderCursor",
            },

            -- Rainbow brackets
            {
                "p00f/nvim-ts-rainbow",
                after = "nvim-treesitter",
            },
        })

        -----------------------------------
        ---       LSP / IDE STUFF       ---
        -----------------------------------

        -- LSP Setup
        use({
            "williamboman/nvim-lsp-installer",
            {
                "neovim/nvim-lspconfig",
                config = function()
                    require("configs.lsp")
                end,
                after = "cmp-nvim-lsp", -- So to update capabilities
            },
            { "folke/lua-dev.nvim", requires = "nvim-lspconfig" },
            {
                "jose-elias-alvarez/null-ls.nvim",
                requires = "nvim-lspconfig",
                config = function()
                    require("configs.null-ls")
                end,
            },
        })

        -- Autocompletion
        use({
            {
                "hrsh7th/nvim-cmp",
                config = function()
                    require("configs.nvim-cmp")
                end,
                requires = {
                    "nvim-autopairs",
                    {
                        "L3MON4D3/LuaSnip",
                        config = function()
                            require("configs.luasnip")
                        end,
                    },
                },
            },
            { "hrsh7th/cmp-buffer", after = "nvim-cmp" },
            { "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" },
            { "hrsh7th/cmp-nvim-lsp-signature-help", after = "nvim-cmp" },
            { "hrsh7th/cmp-path", after = "nvim-cmp" },
            { "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" },
            {
                "hrsh7th/cmp-git",
                after = "nvim-cmp",
                ft = "gitcommit",
                requires = "nvim-lua/plenary.nvim",
                config = function()
                    require("cmp_git").setup()
                end,
            },
            {
                "windwp/nvim-autopairs",
                config = function()
                    require("nvim-autopairs").setup({})
                end,
            },
        })

        use({
            -- Language server (and VSCode extension runtime)
            {
                "neoclide/coc.nvim",
                disable = true,
                config = function()
                    require("configs.coc")
                end,
                branch = "release",
            },

            -- Powerful linting/formatting tool (similar to null-ls)
            {

                "dense-analysis/ale",
                disable = true,
                config = function()
                    require("configs.ale")
                end,
            },
        })
    end,
    config = packer_config,
})
