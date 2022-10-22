-- TODO
-- Need to add the dashboard plugin. Need to also figure out the plugins needed
-- to make the autocompletions nicer

-- Redefine the leader key to be space
-- Remap space to be the leader key
vim.api.nvim_set_keymap('', ',', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

vim.cmd [[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]]

-------------- PLUGINS -------------------
require("packer").startup(function(use)
	use 'wbthomason/packer.nvim' -- Package manager
	
	-- Latex requirement
	use 'lervag/vimtex' --latex requirement

	-- File tree
	use { 'kyazdani42/nvim-tree.lua', requires = {
      	'kyazdani42/nvim-web-devicons', -- optional, for file icon
    	},
    	config = function() require'nvim-tree'.setup {} end
	}

	-- Status bar
	use 'nvim-lualine/lualine.nvim' -- statusbar

	-- Syntax highlighting :TSInstall for the language needed
	use 'nvim-treesitter/nvim-treesitter' -- syntax highlighting

	-- Show sections in code
	use 'preservim/tagbar' -- to display code segments

	-- Colorschemes
	use 'sainnhe/everforest'
	use 'folke/tokyonight.nvim'
	use "EdenEast/nightfox.nvim" -- nightfox, duskfox, nordfox
	use 'marko-cerovac/material.nvim'
	use { 'AhmedAbdulrahman/aylin.vim', branch = '0.5-nvim'}
	use 'frenzyexists/aquarium-vim'


	-- To use R
	use 'jalvesaq/Nvim-R' --to use R language in vim				

	-- Terminal
	use {"akinsho/toggleterm.nvim", tag = "*"}

	-- Autoclose brackets and quotes
	use 'steelsojka/pears.nvim' -- to enable brackets and others to automatch

	-- Line Commenting
	use {
		'numToStr/Comment.nvim',
		config = function()
			require('Comment').setup()
		end
	}

	-- Indent Blankline
	use "lukas-reineke/indent-blankline.nvim"

	-- For nicer tabs in buffer
	use {'akinsho/bufferline.nvim', tag = "v2.*", requires = 'kyazdani42/nvim-web-devicons'}

	-- LSP 
	use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
	use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
	use 'hrsh7th/cmp-nvim-lsp'
	use 'saadparwaiz1/cmp_luasnip'
	use 'L3MON4D3/LuaSnip' -- Snippets plugin

	-- Lsp-kind VSCODE pictures
	use 'onsails/lspkind-nvim'
	use {
		'ray-x/lsp_signature.nvim',
		config = function()
			require "lsp_signature".setup()
		end
	}

end)

-- Tokyonight config
-- vim.g.tokyonight_style = "storm"
-- vim.g.tokyonight_italic_keywords = false
-- vim.g.tokyonight_italic_comments = false
-- vim.g.tokyonight_colors = { hint = "orange", error = "#ff0000" }
-- vim.g.tokyonight_transparent_sidebar = true
-- vim.g.tokyonight_lualine_bold = true
-- vim.cmd [[colorscheme tokyonight]]

-- nightfox config
require('nightfox').setup({
	options = {
		terminal_colors = true,
		transparent = true,
	}
})
-- vim.cmd [[colorscheme nightfox]] --nightfox, duskfox, nordfox, carbonfox
vim.cmd [[colorscheme carbonfox]]

-- Material Theme config
require('material').setup({
	contrast = {
		--sidebars = true,
	},
	disable = {
		borders = true,
	},
	lualine_style = 'default'
})
vim.g.material_style = 'palenight' --oceanic, deep ocean, palenight 

-- Aquarium vim

-- vim.cmd[[colorscheme material]]
---------------------------- OPTIONS ------------------------
vim.g.everforest_background = "hard"
vim.opt.number = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smarttab = true
vim.opt.smartindent = true
vim.opt.belloff= "all"
vim.opt.cursorline = true
vim.opt.wildmenu = true
vim.opt.syntax = "on"
vim.opt.textwidth = 80
vim.opt.encoding = "UTF-8"
vim.opt.showmatch = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.background = "dark" --dont need to use this for nightfox
vim.opt.showmode = false
vim.g.vimtex_view_method = 'Skim'
vim.g.autoindent = true
vim.g.smartindent = true

--enable mouse just in case
vim.opt.mouse = 'a'

--------------------- MAPPINGS ----------------------------------
-- For Nvim tree
vim.api.nvim_set_keymap("n", "<leader>t", ":NvimTreeToggle<CR>", { noremap = true})
vim.api.nvim_set_keymap("n", "<leader>r", ":NvimTreeRefresh<CR>", { noremap = true})

-- For splitting terminal
vim.api.nvim_set_keymap("n", "<leader>sh", ":hsplit | term<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>sv", ":vsplit | term<CR>", {noremap = true})

-- for general navigation
vim.api.nvim_set_keymap("", "<C-J>", "<C-W><C-J>", { noremap = true })
vim.api.nvim_set_keymap("", "<C-K>", "<C-W><C-K>", { noremap = true })
vim.api.nvim_set_keymap("", "<C-L>", "<C-W><C-L>", { noremap = true })
vim.api.nvim_set_keymap("", "<C-H>", "<C-W><C-H>", { noremap = true })

-- for terminal, going to normal mode
local opts = {noremap = true}
vim.api.nvim_set_keymap('t', '<esc>', [[<C-\><C-n>]], opts)
vim.api.nvim_set_keymap('t', 'jk', [[<C-\><C-n>]], opts)
vim.api.nvim_set_keymap('t', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
vim.api.nvim_set_keymap('t', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
vim.api.nvim_set_keymap('t', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
vim.api.nvim_set_keymap('t', '<C-l>', [[<C-\><C-n><C-W>l]], opts)

--for tagbar
vim.api.nvim_set_keymap("n", "<F8>", ":TagbarToggle<CR>", { noremap = true })

-- to get into normal mode
vim.api.nvim_set_keymap("i", "jh", "<Esc>", { noremap = true })

----------------- PLUGIN CONFIGURATION ------------------------------
-- set status bar
require('lualine').setup {
  options = {
    icons_enabled = false,
    theme = 'aylin',
    component_separators = '|',
    section_separators = '',
  }
}


-- Toggleterm
require("toggleterm").setup{
	size = 15,
	open_mapping = [[<leader>;]],
	direction = "horizontal",
	close_on_exit = false,
	shade_terminals = false,
	-- float_opts = {
	-- 	border = 'curved',
	-- 	winblend = 0,
	-- 	highlights = {
	-- 		border = "Normal",
	-- 		background = "Normal"
	-- 	}
	-- }
}

-- Indent-Blankline
require("indent_blankline").setup{
	show_end_of_line = true,
}

-- Comment
require("Comment").setup{
	toggler = {
		line = "gcc",
		block = "gbc",
	},
}

-- Treesitter configuration
-- Parsers must be installed manually via :TSInstall
require'nvim-tree'.setup()

require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true, -- false will disable the whole extension
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = 'gnn',
      node_incremental = 'grn',
      scope_incremental = 'grc',
      node_decremental = 'grm',
    },
  },
  indent = {
    enable = true,
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
  },
}

-- Pears.nvim
require "pears".setup()

-- Bufferline 
-- in order to change the buffer cycle, i need to set them myself using config
require('bufferline').setup {
  options = {
	diagnostics = "nvim_lsp",
	offsets = {
		{
			filetype = "NvimTree",
			text = "File Explorer",
			highlight = "Directory",
			text_align = "left"
		}
    },
    show_buffer_icons = true, 
    show_buffer_close_icons = true,
    show_close_icon = true,
    show_tab_indicators = true,
    persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
    separator_style = "slant",
    enforce_regular_tabs = false,
    always_show_bufferline = true,
  }
} 

-- keymappings for bufferline

vim.api.nvim_set_keymap("n", "[b", ":BufferLineCycleNext<CR>", { noremap = true})
vim.api.nvim_set_keymap("n", "]b", ":BufferLineCyclePrev<CR>", { noremap = true})
vim.api.nvim_set_keymap("n", "mn", ":BufferLineMoveNext<CR>", { noremap = true})
vim.api.nvim_set_keymap("n", "mp", ":BufferLineMovePrev<CR>", { noremap = true})

------------------- LSP -----------------------------
-- need to set this up
-- Diagnostic keymapping
vim.api.nvim_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', { noremap = true, silent = true })

-- Refer to the kickstart.nvim file provided by the nvim-cmp people/ lsp-config completion person
local lspconfig = require 'lspconfig'
 local on_attach = function(_, bufnr)
	require("lsp_signature").setup({
		bind = true,
		handler_opts ={
			border = "rounded"
		}
	}, bufnr)
	local opts = { noremap = true, silent = true }
end

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Enable the following language servers
local servers = { 'pyright', 'gopls', 'eslint', 'r_language_server', "vuels" }
for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup {
		on_attach = on_attach,
		capabilities = capabilities,
	}	
end

-- cmp
local cmp = require 'cmp'
local luasnip = require 'luasnip'
local lspkind = require  'lspkind'
cmp.setup({
  mapping = {
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-e>"] = cmp.mapping.close(),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif require("luasnip").expand_or_jumpable() then
        require("luasnip").expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif require("luasnip").jumpable(-1) then
        require("luasnip").jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  },
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  sources = { { name = "nvim_lsp" }, { name = "luasnip" } },
  completion = { completeopt = "menu,menuone,noinsert" },
})


cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(), -- important!
  sources = {
    { name = 'nvim_lua' },
    { name = 'cmdline' },
  },
})
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(), -- important!
  sources = {
    { name = 'buffer' },
  },
})
