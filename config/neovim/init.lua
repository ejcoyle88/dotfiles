vim.g.mapleader = " "

local g = vim.g
local opt = vim.opt
local cmd = vim.cmd
local fn = vim.fn

local function add(value, str, sep)
    sep = sep or ','
    str = str or ''
    value = type(value) == 'table' and table.concat(value, sep) or value
    return str ~= '' and table.concat({ value, str }, sep) or value
end

-- https://blog.devgenius.io/create-custom-keymaps-in-neovim-with-lua-d1167de0f2c2
-- https://oroques.dev/notes/neovim-init/
local map = function(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local nnoremap = function(lhs, rhs, opts)
    map('n', lhs, rhs, opts)
end

local inoremap = function(lhs, rhs, opts)
    map('i', lhs, rhs, opts)
end

local vnoremap = function(lhs, rhs, opts)
    map('v', lhs, rhs, opts)
end

local nnoremaps = function(lhs, rhs)
    nnoremap(lhs, rhs, { silent = true })
end

local ex = setmetatable({}, {
    __index = function(t, k)
        local command = k:gsub("_$", "!")
        local f = function(...)
            return vim.api.nvim_command(table.concat(vim.tbl_flatten {command, ...}, " "))
        end
        rawset(t, k, f)
        return f
    end
});

function _G.project_files()
    local opts = {} -- define here if you want to define something
    local ok = pcall(require"telescope.builtin".git_files, opts)
    if not ok then require"telescope.builtin".find_files(opts) end
end

require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'christoomey/vim-tmux-navigator'
    use {
        'williamboman/mason.nvim',
        run = ":MasonUpdate"
    }
    use 'williamboman/mason-lspconfig.nvim'
    use 'neovim/nvim-lspconfig'
    use 'simrat39/rust-tools.nvim'
    use "mfussenegger/nvim-dap"
    use "jay-babu/mason-nvim-dap.nvim"
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-nvim-lua'
    use 'hrsh7th/cmp-nvim-lsp-signature-help'
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/vim-vsnip'
    use 'sunjon/shade.nvim'
    use 'MunifTanjim/prettier.nvim'
    use 'folke/tokyonight.nvim'
    use {
        "nvim-telescope/telescope.nvim",
        requires = {
            { 'nvim-lua/plenary.nvim' },
            { 'nvim-treesitter/nvim-treesitter' }
        }
    }
    use {
        "nvim-treesitter/nvim-treesitter",
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end
    }
    use {
        'nmac427/guess-indent.nvim',
        config = function() require('guess-indent').setup {} end,
    }
end)

require("mason").setup()
require("mason-nvim-dap").setup()
require("mason-lspconfig").setup()

require("mason-lspconfig").setup_handlers {
    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.
    function (server_name) -- default handler (optional)
        local capabilities = require('cmp_nvim_lsp').default_capabilities()
        require("lspconfig")[server_name].setup {
            capabilities = capabilities
        }
    end,
}

local lspconfig = require'lspconfig'
lspconfig.csharp_ls.setup {
    root_dir = function(startpath)
        return lspconfig.util.root_pattern("*.sln")(startpath)
            or lspconfig.util.root_pattern("*.csproj")(startpath)
            or lspconfig.util.root_pattern("*.fsproj")(startpath)
            or lspconfig.util.root_pattern(".git")(startpath)
    end,
    on_attach = function(_, bufnr)
        -- Enable completion triggered by <c-x><c-o>
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = bufnr, noremap=true, silent=true}
        local nbufkeymap = function(key, bind)
            vim.keymap.set('n', key, bind, opts)
        end

        nbufkeymap('<leader>gs', vim.lsp.buf.declaration)
        nbufkeymap('<leader>gd', vim.lsp.buf.definition)
        nbufkeymap('<leader>gi', vim.lsp.buf.implementation)
        nbufkeymap('<leader>gr', vim.lsp.buf.references)
        nbufkeymap('<leader>ch', vim.lsp.buf.hover)
        nbufkeymap('<leader>cs', vim.lsp.buf.signature_help)
        nbufkeymap('<leader>cd', vim.lsp.buf.type_definition)
        nbufkeymap('<leader>cr', vim.lsp.buf.rename)
        nbufkeymap('<leader>ca', vim.lsp.buf.code_action)
        nbufkeymap('<leader>cf', vim.lsp.buf.formatting)
        nbufkeymap('<leader>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end)
        nbufkeymap('<leader>wa', vim.lsp.buf.add_workspace_folder)
        nbufkeymap('<leader>wr', vim.lsp.buf.remove_workspace_folder)
    end,
}

lspconfig.lua_ls.setup {
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {'vim'},
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
}

local rt = require("rust-tools")

rt.setup({
  server = {
    on_attach = function(_, bufnr)
      -- Hover actions
      vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
  },
})

local sign = function(opts)
  vim.fn.sign_define(opts.name, {
    texthl = opts.name,
    text = opts.text,
    numhl = ''
  })
end

sign({name = 'DiagnosticSignError', text = ''})
sign({name = 'DiagnosticSignWarn', text = ''})
sign({name = 'DiagnosticSignHint', text = ''})
sign({name = 'DiagnosticSignInfo', text = ''})

vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    update_in_insert = true,
    underline = true,
    severity_sort = false,
    float = {
        border = 'rounded',
        source = 'always',
        header = '',
        prefix = '',
    },
})

vim.cmd([[
set signcolumn=yes
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])

vim.opt.completeopt = {'menuone', 'noselect', 'noinsert'}
vim.opt.shortmess = vim.opt.shortmess + { c = true}
vim.api.nvim_set_option('updatetime', 300)

require("tokyonight").setup({
    style = "night",
    transparent = true,
    terminal_colors = true
})

vim.opt.completeopt = {'menuone', 'noselect', 'noinsert', 'preview'}

local cmp = require('cmp')

cmp.setup({
    sources = {
        { name = 'path' },
        { name = 'nvim_lsp', keyword_length = 3 },
        { name = 'nvim_lsp_signature_help' },
        { name = 'nvim_lua', keyword_length = 2 },
        { name = 'buffer', keyword_length = 2 },
        { name = 'vsnip', keyword_length = 2 },
    },
    mapping = {
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-\\>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true
        })
    },
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    formatting = {
        fields = {'menu', 'abbr', 'kind'},
        format = function(entry, item)
            local menu_icon ={
                nvim_lsp = 'λ',
                vsnip = '⋗',
                buffer = 'b',
                path = 'p'
            }
            item.menu = menu_icon[entry.source.name]
            return item
        end,
    },
})


local telescope_status_ok, telescope = pcall(require, "telescope")
if telescope_status_ok then
    local actions = require "telescope.actions"

    telescope.setup {
        defaults = {

            prompt_prefix = " ",
            selection_caret = " ",
            path_display = { "smart" },
            borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },

            mappings = {
                i = {
                    ["<esc>"] = actions.close,
                    ["<C-n>"] = actions.cycle_history_next,
                    ["<C-p>"] = actions.cycle_history_prev,

                    ["<C-j>"] = actions.move_selection_next,
                    ["<C-k>"] = actions.move_selection_previous,

                    ["<C-c>"] = actions.close,

                    ["<Down>"] = actions.move_selection_next,
                    ["<Up>"] = actions.move_selection_previous,

                    ["<CR>"] = actions.select_default,
                    ["<C-x>"] = actions.select_horizontal,
                    ["<C-v>"] = actions.select_vertical,
                    ["<C-t>"] = actions.select_tab,

                    ["<C-u>"] = actions.preview_scrolling_up,
                    ["<C-d>"] = actions.preview_scrolling_down,

                    ["<PageUp>"] = actions.results_scrolling_up,
                    ["<PageDown>"] = actions.results_scrolling_down,

                    ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
                    ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
                    ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
                    ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                    ["<C-l>"] = actions.complete_tag,
                    ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
                },

                n = {
                    ["<esc>"] = actions.close,
                    ["<CR>"] = actions.select_default,
                    ["<C-x>"] = actions.select_horizontal,
                    ["<C-v>"] = actions.select_vertical,
                    ["<C-t>"] = actions.select_tab,

                    ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
                    ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
                    ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
                    ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

                    ["j"] = actions.move_selection_next,
                    ["k"] = actions.move_selection_previous,
                    ["H"] = actions.move_to_top,
                    ["M"] = actions.move_to_middle,
                    ["L"] = actions.move_to_bottom,

                    ["<Down>"] = actions.move_selection_next,
                    ["<Up>"] = actions.move_selection_previous,
                    ["gg"] = actions.move_to_top,
                    ["G"] = actions.move_to_bottom,

                    ["<C-u>"] = actions.preview_scrolling_up,
                    ["<C-d>"] = actions.preview_scrolling_down,

                    ["<PageUp>"] = actions.results_scrolling_up,
                    ["<PageDown>"] = actions.results_scrolling_down,

                    ["?"] = actions.which_key,
                },
            },
        },
        pickers = {
            -- Default configuration for builtin pickers goes here:
            -- picker_name = {
            --   picker_config_key = value,
            --   ...
            -- }
            -- Now the picker_config_key will be applied every time you call this
            -- builtin picker
        },
        extensions = {
            -- Your extension configuration goes here:
            -- extension_name = {
            --   extension_config_key = value,
            -- }
            -- please take a look at the readme of the extension you want to configure
        },
    }
end

local treesitter_status_ok, treesitter_configs = pcall(require, "nvim-treesitter.configs")
if treesitter_status_ok then
    treesitter_configs.setup {
        ensure_installed = {
            "c_sharp",
            "javascript",
            "dockerfile",
            "graphql",
            "html",
            "json",
            "lua",
            "python",
            "regex",
            "ruby",
            "rust",
            "toml",
            "tsx",
            "vim",
            "yaml",
        }, -- "all" or a list of languages
        sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
        ignore_install = { "" }, -- List of parsers to ignore installing
        autopairs = {
            enable = true,
        },
        highlight = {
            enable = true, -- false will disable the whole extension
            disable = { "" }, -- list of language that will be disabled
            additional_vim_regex_highlighting = true,
        },
        indent = {
            enable = true,
            disable = { "yaml" }
        },
        context_commentstring = {
            enable = true,
            enable_autocmd = false,
        },
        rainbow = {
            enable = true,
            extended_mode = true,
            max_file_lines = nil
        },
    }
end

vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'

g.syntax='on'

g.noerrorbells=true
g.hidden=true

opt.termguicolors=true

vim.cmd[[colorscheme tokyonight]]

opt.background='dark'

opt.shell = '/bin/zsh'
opt.path = vim.opt.path + ',**'
opt.wildmenu=true
opt.wildmode='longest:full,full'
opt.wildignore = add {
    '.bak', '.pyc', '.o', '.ojb', '.a', '.orig,',
    '.pdf','.jpg','.gif','.png','.jpeg',
    '.avi','.mkv','.so',
    '**/vendor/**',
    '**/node_modules/**',
    '**/bin/**',
    '**/obj/**',
    '*.DS_Store'
}
opt.tabstop=4
opt.softtabstop=4
opt.shiftwidth=4
opt.expandtab=true
opt.scrolloff=10

opt.showcmd=true

opt.hlsearch=true
opt.incsearch=true
opt.wrapscan=true
opt.smartcase=true
opt.ignorecase=true
opt.gdefault=true

opt.smartindent = true
opt.autoindent = true

opt.wrap=true
opt.linebreak=true
opt.textwidth=0
opt.wrapmargin=0

opt.foldmethod="syntax"
opt.foldnestmax=2

opt.number=true
opt.relativenumber=true
opt.cursorline=true

opt.swapfile=false
opt.backup=false
opt.writebackup=false
opt.undodir= os.getenv( "HOME" ) .. "/.config/nvim/undodir"
opt.undofile=true

-- Give more space for displaying messages.
opt.cmdheight=2

-- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
-- delays and poor user experience.
opt.updatetime=300

-- Don't pass messages to |ins-completion-menu|.
opt.shortmess = table.concat({
    't', -- truncate file messages at start
    'A', -- ignore annoying swap file messages
    'o', -- file-read message overwrites previous
    'O', -- file-read message overwrites previous
    'T', -- truncate non-file messages in middle
    'f', -- (file x of x) instead of just (x of x
    'F', -- Don't give file info when editing a file
    's',
    'c',
    'W' -- Dont show [w] or written when writing
})

-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appear/become resolved.
if fn.has("patch-8.1.1564") then
    -- Recently vim can merge signcolumn and number column into one
    opt.signcolumn='number'
else
    opt.signcolumn='yes'
end

opt.formatoptions = "l"
opt.formatoptions = opt.formatoptions
- "a" -- Auto formatting is BAD.
- "t" -- Don't auto format my code. I got linters for that.
+ "c" -- In general, I like it when comments respect textwidth
+ "q" -- Allow formatting comments w/ gq
- "o" -- O and o, don't continue comments
+ "r" -- But do continue when pressing enter.
+ "n" -- Indent past the formatlistpat, not underneath it.
+ "j" -- Auto-remove comments if possible.
- "2" -- I'm not in gradeschool anymore

-- Toggle auto-indent before clipboard paste
--opt.pastetoggle='<leader>p'

-- Shortcut to rapidly toggle `set list`
nnoremaps('<leader>l', ':set list!<cr>')

-- Normal/Visual tab for bracket pairs
nnoremap('<tab>', '%')
vnoremap('<tab>', '%')

-- :q and :wq close buffers
ex.cabbrev('wq', 'w<bar>bd')
ex.cabbrev('q', 'bd')
ex.cabbrev('qq', 'quit')
ex.cabbrev('wqq', 'w<bar>quit')

-- Bindings for swapping buffer next/prev.
nnoremaps('<leader>bl', ':Telescope buffers<CR>')
nnoremaps('<leader>bn', ':bn<CR>')
nnoremaps('<leader>bv', ':bp<CR>')
nnoremaps('<leader>bp', '<C-^>')
nnoremaps('<leader>bq', ':bp <BAR> bd #<CR>')
nnoremaps('<leader>bc', ':enew<CR>')
nnoremaps('<leader>bw', ':w<CR>')

-- Forcing myself to learn to use HJKL. :(
nnoremap('<up>', '<nop>')
nnoremap('<down>', '<nop>')
nnoremap('<left>', '<nop>')
nnoremap('<right>', '<nop>')
inoremap('<down>', '<nop>')
inoremap('<left>', '<nop>')
inoremap('<right>', '<nop>')
inoremap('<up>', '<nop>')

-- This makes j and k work as you would expect with wrapped lines,
-- while still working with the line numbers when making a jump
-- command
cmd[[nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')]]
cmd[[nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')]]

-- un-highlight search results
nnoremaps('<leader><leader>', ':noh<cr>')

-- Make search case insensitive by default
nnoremap('/', '/\\v')
vnoremap('/', '/\\v')

-- Make 'r' redo, because I never use 'replace' and <c-r> is
-- an awkward hand movement
nnoremap('r', '<c-r>')

nnoremaps('<leader>ff', ':Telescope find_files<CR>')
nnoremaps('<leader>fg', ':lua project_files()<CR>')
