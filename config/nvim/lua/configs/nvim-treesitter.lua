local configs_treesitter =
    vim.api.nvim_create_augroup("ConfigsTreesitter", { clear = true })
local autocmd = vim.api.nvim_create_autocmd

local enabled_parsers = {
    "bash",
    "html",
    "javascript",
    "json",
    "jsonc",
    "lua",
    "markdown",
    "markdown_inline",
    "scss",
    "typescript",
    "vim",
    "yaml",
}

autocmd("FileType", {
    group = configs_treesitter,
    pattern = enabled_parsers,
    command = "setlocal foldmethod=expr foldexpr=nvim_treesitter#foldexpr()",
})

require("nvim-treesitter.configs").setup({

    -- One of "all", "maintained" (parsers with maintainers), or a list of languages
    ensure_installed = enabled_parsers,

    -- Install languages synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- List of parsers to ignore installing
    -- ignore_install = { "javascript" },

    highlight = {

        -- `false` will disable the whole extension
        enable = true,

        -- list of language that will be disabled
        -- disable = {},

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },

    -- textobjects
    textobjects = {
        select = {
            enable = true,
            lookahead = true,

            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@conditional.outer",
                ["ic"] = "@conditional.inner",
                -- ["ac"] = "@class.outer",
                -- ["ic"] = "@class.inner",
            },

            -- choose the select mode (default is charwise 'v')
            selection_modes = {
                ["@function.inner"] = "V", -- linewise
                ["@function.outer"] = "V",
            },
        },

        swap = {
            enable = true,
            swap_next = {
                ["[w"] = "@parameter.inner",
            },
            swap_previous = {
                ["]w"] = "@parameter.inner",
            },
        },

        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
                ["]m"] = "@function.outer",
                ["]]"] = "@class.outer",
            },
            goto_previous_start = {
                ["[m"] = "@function.outer",
                ["[["] = "@class.outer",
            },
        },
    },

    playground = {
        enable = true,
        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    },

    indent = {
        enable = true,
    },

    rainbow = {
        enable = true,
        disable = { "html", "json", "lua" },
        extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
        max_file_lines = nil, -- Do not enable for files with more than n lines, int
        colors = {
            -- Colors extracted from VSCode's rainbow bracket extension
            "#e6b422",
            "#c70067",
            "#00a960",
            "#fc7482",
            "#33ccff",
            "#8080ff",
            "#0073a8",
            "#d4d4aa",
            "#d1a075",
            "#9c6628",
        },
        termcolors = {
            "Red",
            "Green",
            "Yellow",
            "Blue",
            "Magenta",
            "Cyan",
            "White",
            "LightYellow",
            "LightRed",
            "LightGreen",
        },
    },
})
