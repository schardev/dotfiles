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
        -- Packer can manage itself
        use("wbthomason/packer.nvim")

        -- Powerful linting tool
        use({
            "dense-analysis/ale",
            config = function()
                require("configs.ale")
            end,
        })

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

        -- Cool start menu
        use({
            "mhinz/vim-startify",
            config = function()
                require("configs.startify")
            end,
        })

        -- Language server
        use({
            "neoclide/coc.nvim",
            config = function()
                require("configs.coc")
            end,
            branch = "release",
        })

        -- Commentary stuff
        use("tpope/vim-commentary")

        -- Awesome git wrapper
        use({
            "tpope/vim-fugitive",
            cmd = { "Git", "Gstatus", "Gblame", "Gpush", "Gpull" },
        })

        -- Surrounding stuff
        use("tpope/vim-surround")

        -- Sax bufferline
        use({
            "akinsho/bufferline.nvim",
            config = function()
                require("configs.bufferline")
            end,
        })

        -- For key mapping hints
        use({
            "folke/which-key.nvim",
            config = function()
                require("which-key").setup({
                    plugins = {
                        spelling = {
                            enabled = true,
                        },
                    },
                })
            end,
        })

        -- Lua fork of Nerdtree
        use({
            "kyazdani42/nvim-tree.lua",
            config = function()
                require("configs.nvim-tree")
            end,
        })

        -- File icons
        use("kyazdani42/nvim-web-devicons")

        -- Indent level
        use({
            "lukas-reineke/indent-blankline.nvim",
            config = function()
                require("configs.indent_blankline")
            end,
        })

        -- Lua fork of onedark colorscheme
        use("navarasu/onedark.nvim")

        -- Statusline plugin
        use({
            "nvim-lualine/lualine.nvim",
            config = function()
                require("configs.lualine")
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
                requires = "nvim-treesitter",
            },

            -- Rainbow brackets
            {
                "p00f/nvim-ts-rainbow",
                requires = "nvim-treesitter",
            },
        })

        -- Fuzzy finder and more
        use({
            "nvim-telescope/telescope.nvim",
            cond = function()
                return not vim.env.IS_TERMUX
            end,
            requires = "nvim-lua/plenary.nvim",
        })

        -- Color preview
        use({
            "norcalli/nvim-colorizer.lua",
            ft = { "html", "css", "scss", "javascript", "vim", "lua" },
            config = function()
                require("configs.colorizer")
            end,
        })
    end,
    config = packer_config,
})
