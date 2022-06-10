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
        use({ "wbthomason/packer.nvim", opt = true })

        -- Shows human friendly startuptime
        use({ "dstein64/vim-startuptime", cmd = "StartupTime" })

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

        -- Shows lsp status
        use({
            "j-hui/fidget.nvim",
            event = "LspAttach",
            config = function()
                require("fidget").setup({
                    text = {
                        spinner = "dots",
                    },
                })
            end,
        })

        -- Lua fork of Nerdtree
        use({
            "kyazdani42/nvim-tree.lua",
            cmd = { "NvimTreeToggle", "NvimTreeFindFileToggle" },
            ft = "startify",
            keys = { "<F1>", "<Leader><F1>" },
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

        -- The undo history visualizer
        use({ "mbbill/undotree", cmd = "UndotreeToggle" })

        -- Nice quickfix list for LSP and friends
        use({
            "folke/trouble.nvim",
            cmd = "TroubleToggle",
            requires = "kyazdani42/nvim-web-devicons",
            config = function()
                require("trouble").setup({
                    use_diagnostic_signs = true,
                })
            end,
        })

        -- Highlights todo comments
        use({
            "folke/todo-comments.nvim",
            cmd = "TodoTrouble",
            requires = "nvim-lua/plenary.nvim",
            config = function()
                require("todo-comments").setup({})
            end,
        })

        -- Awesome git wrapper
        use({
            "tpope/vim-fugitive",
            cmd = { "Git", "Gstatus", "Gblame", "Gpush", "Gpull" },
        })

        -- Surrounding stuff
        -- P.S: no vimrc is complete without some tpope goodness
        use({ "tpope/vim-surround", requires = "tpope/vim-repeat" })

        ----------------------------------
        ---       LANGUAGE TOOLS       ---
        ----------------------------------

        -- Text alignment
        use({ "godlygeek/tabular", ft = { "markdown" } })

        --  Markdown preview
        use({
            "iamcco/markdown-preview.nvim",
            run = "cd app && yarn install",
            ft = "markdown",
            cmd = "MarkdownPreview",
            config = function()
                require("configs.markdown-preview")
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

        -- Annotation generator
        use({
            "danymat/neogen",
            ft = {
                "javascript",
                "javascriptreact",
                "lua",
                "typescript",
                "typescriptreact",
            },
            config = function()
                require("configs.neogen")
            end,
            requires = "nvim-treesitter",
        })

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
            "numToStr/Sakura.nvim",
            -- {
            --     "folke/tokyonight.nvim",
            --     config = function()
            --         require("configs.colors.tokyonight")
            --     end,
            -- },
            -- {
            --     "navarasu/onedark.nvim",
            --     config = function()
            --         require("configs.colors.onedark")
            --     end,
            -- },
            {
                "catppuccin/nvim",
                as = "catppuccin",
                commit = "f079dda",
                config = function()
                    require("configs.colors.catppuccin")
                    vim.cmd("colorscheme catppuccin")
                end,
            },
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
            requires = "nvim-web-devicons",
            config = function()
                require("configs.lualine")
            end,
        })

        -----------------------------------
        ---       LSP / IDE STUFF       ---
        -----------------------------------

        -- LSP Setup
        use({
            "williamboman/nvim-lsp-installer",
            {
                "neovim/nvim-lspconfig",
                module = "lspconfig",
                config = function()
                    require("configs.lsp")
                end,
            },
            { "folke/lua-dev.nvim", requires = "nvim-lspconfig" },
            {
                "jose-elias-alvarez/null-ls.nvim",
                config = function()
                    require("configs.null-ls")
                end,
            },
        })

        -- Autocompletion
        use({
            {
                "hrsh7th/nvim-cmp",
                event = "InsertEnter",
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
            { "hrsh7th/cmp-nvim-lsp", module = "cmp_nvim_lsp" },
            { "hrsh7th/cmp-nvim-lsp-signature-help", after = "nvim-cmp" },
            { "hrsh7th/cmp-path", after = "nvim-cmp" },
            { "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" },
            {
                "hrsh7th/cmp-git",
                after = "nvim-cmp",
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
