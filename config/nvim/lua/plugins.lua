local fn = vim.fn
local packer_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
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
        use("wbthomason/packer.nvim")

        -- Shows human friendly startuptime
        use({ "dstein64/vim-startuptime", cmd = "StartupTime" })

        -- For key mapping hints
        use({
            "folke/which-key.nvim",
            event = "BufEnter",
            config = function()
                require("configs.which-key")
            end,
        })

        -- Indent level
        use({
            "lukas-reineke/indent-blankline.nvim",
            event = "BufReadPre",
            config = function()
                require("configs.indent_blankline")
            end,
        })

        -- Shows lsp status
        use({
            "j-hui/fidget.nvim",
            event = "LspAttach",
            config = function()
                vim.api.nvim_create_autocmd(
                    "VimLeavePre",
                    { command = [[silent! FidgetClose]] }
                )
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
            event = "BufEnter",
            config = function()
                require("configs.nvim-tree")
            end,
        })

        -- Fuzzy finder and more
        use({
            {
                "nvim-telescope/telescope.nvim",
                event = "BufEnter",
                config = function()
                    require("configs.telescope")
                end,
                requires = {
                    "nvim-lua/plenary.nvim",
                    "telescope-fzf-native.nvim",
                },
            },
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                run = "make",
            },
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

        -- Awesome git wrapper
        use({
            "tpope/vim-fugitive",
            cmd = { "Git", "Gstatus", "Gblame", "Gpush", "Gpull" },
        })

        -- Surrounding stuff
        use({
            "kylechui/nvim-surround",
            config = function()
                require("nvim-surround").setup({})
            end,
        })

        -- Blazzingly fast movement in neovim
        use({
            "ggandor/leap.nvim",
            event = "BufReadPre",
            config = function()
                require("leap").set_default_keymaps()
            end,
        })

        use({
            "cshuaimin/ssr.nvim",
            config = function()
                local mapper = require("core.utils").mapper_factory
                mapper({ "n", "x" })("<leader>tr", function()
                    require("ssr").open()
                end)
            end,
        })

        ----------------------------------
        ---       LANGUAGE TOOLS       ---
        ----------------------------------

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
        use({
            "mattn/emmet-vim",
            ft = {
                "css",
                "html",
                "javascript",
                "javascriptreact",
                "markdown",
                "scss",
                "typescript",
                "typescriptreact",
            },
            config = function()
                local mapper = require("core.utils").mapper_factory
                -- Wrap selected text in emmet abbrev
                mapper("v")("<leader>S", "<C-y>,", { remap = true })
            end,
        })

        -- A plugin to ... umm ... comment stuff
        use({
            "numToStr/Comment.nvim",
            event = "InsertEnter",
            keys = { "gc", "gcc", "gbc" },
            config = function()
                require("Comment").setup({
                    pre_hook = require(
                        "ts_context_commentstring.integrations.comment_nvim"
                    ).create_pre_hook(),
                })
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

            -- treesitter powered textobjects
            {
                "nvim-treesitter/nvim-treesitter-textobjects",
                after = "nvim-treesitter",
            },

            -- treesitter querying
            {
                "nvim-treesitter/playground",
                after = "nvim-treesitter",
                cmd = {
                    "TSHighlightCapturesUnderCursor",
                    "TSPlaygroundToggle",
                },
            },

            -- Rainbow brackets
            {
                "p00f/nvim-ts-rainbow",
                after = "nvim-treesitter",
            },

            -- better comment support for jsx/tsx
            {
                "JoosepAlviste/nvim-ts-context-commentstring",
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
                "sh",
                "typescript",
                "typescriptreact",
            },
            config = function()
                require("configs.neogen")
            end,
            requires = "nvim-treesitter",
        })

        use({
            "jose-elias-alvarez/typescript.nvim",
            module = "typescript",
            ft = {
                "javascript",
                "javascriptreact",
                "typescript",
                "typescriptreact",
            },
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
            "goolord/alpha-nvim",
            config = function()
                require("configs.alpha")
            end,
        })

        -- Shows git signs in sign column
        use({
            "lewis6991/gitsigns.nvim",
            event = "BufReadPre",
            config = function()
                require("configs.gitsigns")
            end,
        })

        -- Sax bufferline
        use({
            "akinsho/bufferline.nvim",
            event = "BufEnter",
            requires = "nvim-web-devicons",
            config = function()
                require("configs.bufferline")
            end,
        })

        -- Colorschemes
        use({
            {
                "folke/tokyonight.nvim",
                disable = true,
                config = function()
                    require("configs.colors.tokyonight")
                end,
            },
            {
                "navarasu/onedark.nvim",
                disable = true,
                config = function()
                    require("configs.colors.onedark")
                end,
            },
            {
                "catppuccin/nvim",
                as = "catppuccin",
                commit = "3d0c37c",
                config = function()
                    require("configs.colors.catppuccin")
                    vim.cmd("colorscheme catppuccin")
                end,
            },
        })

        -- Color preview
        use({
            "NvChad/nvim-colorizer.lua",
            cmd = "ColorizerAttachToBuffer",
            ft = { "css", "scss" },
            config = function()
                require("configs.colorizer")
            end,
        })

        -- Statusline plugin
        use({
            "nvim-lualine/lualine.nvim",
            event = "VimEnter",
            requires = "nvim-web-devicons",
            config = function()
                require("configs.lualine")
            end,
        })

        -----------------------------------
        ---       LSP / IDE STUFF       ---
        -----------------------------------

        use({
            -- LSP, DAP, Formatters, and Linters installer
            {
                {
                    "williamboman/mason.nvim",
                    module = "mason",
                },
                {
                    "williamboman/mason-lspconfig.nvim",
                    module = "mason-lspconfig",
                },
            },

            -- LSP Setup
            {
                "neovim/nvim-lspconfig",
                event = "BufEnter",
                config = function()
                    require("configs.lsp")
                end,
            },

            -- Emmylua docs for vim.* completion
            {
                "folke/neodev.nvim",
                module = "neodev",
                requires = "nvim-lspconfig",
            },

            -- Generic lsp server
            {
                "jose-elias-alvarez/null-ls.nvim",
                after = "nvim-lspconfig",
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
                        module = "luasnip",
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
                module = "nvim-autopairs",
                event = "BufReadPre",
                config = function()
                    require("nvim-autopairs").setup({
                        check_ts = true,
                    })
                end,
            },
        })
    end,
    config = packer_config,
})
