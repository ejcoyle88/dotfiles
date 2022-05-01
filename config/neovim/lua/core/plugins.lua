local fn = vim.fn

-- disable builtins plugins
local disabled_built_ins = {
    "netrw",
    "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
    "gzip",
    "zip",
    "zipPlugin",
    "tar",
    "tarPlugin",
    "getscript",
    "getscriptPlugin",
    "vimball",
    "vimballPlugin",
    "2html_plugin",
    "logipat",
    "rrhelper",
    "spellfile_plugin",
    "matchit"
}

for _, plugin in pairs(disabled_built_ins) do
    vim.g["loaded_" .. plugin] = 1
end

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    }
    print "Installing packer close and reopen Neovim..."
    vim.cmd [[packadd packer.nvim]]
end

function get_setup(name)
    return string.format('require("user/%s")', name)
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end,
    },
}

-- Install your plugins here
return packer.startup(function(use)
    -- My plugins here
    use "wbthomason/packer.nvim" -- Have packer manage itself
    use {"nvim-lua/popup.nvim", opt = true } -- An implementation of the Popup API from vim in Neovim
    use "nvim-lua/plenary.nvim" -- Useful lua functions used by lots of plugins
    use ({"lewis6991/impatient.nvim", config = get_setup("impatient")})

    use({
      "catppuccin/nvim",
      as = "catppuccin"
    })

    use ({"DanilaMihailov/beacon.nvim", config = get_setup("beacon") }) -- show cursor on jumps
    use "kyazdani42/nvim-web-devicons"
    use ({"kyazdani42/nvim-tree.lua", config = get_setup("nvim-tree") })
    use {
        'romgrk/barbar.nvim',
        requires = {'kyazdani42/nvim-web-devicons'},
        config = get_setup("barbar")
    }
    use ({"nvim-lualine/lualine.nvim", config = get_setup("lualine")})

    -- LSP
    use "neovim/nvim-lspconfig" -- enable LSP
    use "williamboman/nvim-lsp-installer" -- simple to use language server installer
    use "tamago324/nlsp-settings.nvim" -- language server settings defined in json for
    use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters
    use "MunifTanjim/prettier.nvim"

    -- snippets
    use "L3MON4D3/LuaSnip" --snippet engine
    use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

    -- cmp
    use ({'hrsh7th/nvim-cmp', config = get_setup("cmp") })
    use "hrsh7th/cmp-buffer" -- buffer completions
    use "hrsh7th/cmp-path" -- path completions
    use "hrsh7th/cmp-cmdline" -- cmdline completions
    use "saadparwaiz1/cmp_luasnip" -- snippet completions
    use 'hrsh7th/cmp-nvim-lsp'

    -- Telescope
    use ({"nvim-telescope/telescope.nvim",
        config = get_setup("telescope"),
        module = "telescope",
        cmd = "Telescope",
        requires = { { 'nvim-lua/plenary.nvim' } }
    })

    -- Treesitter
    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        module = 'nvim-treesitter',
        event = "BufRead",
		    config = get_setup("treesitter"),
    }

    -- Git
    use ({"lewis6991/gitsigns.nvim",
        config = get_setup("gitsigns"),
        setup = function()
            require("core.utils").packer_lazy_load "gitsigns.nvim"
        end,
    })
    
    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
