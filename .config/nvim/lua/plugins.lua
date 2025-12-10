local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	--themes
	"tanvirtin/monokai.nvim",
	"blazkowolf/gruber-darker.nvim",
	"ayu-theme/ayu-vim",
	"xero/miasma.nvim",
	"savq/melange-nvim",
	"jpwol/thorn.nvim",

	-- telescope
	{
		'nvim-telescope/telescope.nvim', tag = 'v0.2.0',
		dependencies = { 
			'nvim-lua/plenary.nvim',
			{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
			{ "nvim-tree/nvim-web-devicons", opts = {} },
		},

	},

	-- blink completion plugin (provides lsp, fuzzy search etc)
	{
		"saghen/blink.cmp",
		-- optional: provides snippets for the snippet source
		dependencies = { "rafamadriz/friendly-snippets" },

		-- Use a release tag to download pre-built binaries
		version = "*",
		-- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
		-- build = 'cargo build --release',
		-- If you use Nix, you can build from source using the latest nightly rust with:
		-- build = 'nix run .#build-plugin',

		opts = {
		    -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
		    -- 'super-tab' for mappings similar to VSCode (tab to accept)
		    -- 'enter' for enter to accept
		    -- 'none' for no mappings
		    --
		    -- All presets have the following mappings:
		    -- C-space: Open menu or open docs if already open C-n/C-p or Up/Down: Select next/previous item C-e: Hide menu
		    -- C-k: Toggle signature help (if signature.enabled = true)
		    --
		    -- See :h blink-cmp-config-keymap for defining your own keymap
		    keymap = {
			-- Each keymap may be a list of commands and/or functions
			preset = "enter",
			-- Select completions
			["<Up>"] = { "select_prev", "fallback" },
			["<Down>"] = { "select_next", "fallback" },
			["<Tab>"] = { "select_next", "fallback" },
			["<S-Tab>"] = { "select_prev", "fallback" },
			-- Scroll documentation
			["<C-b>"] = { "scroll_documentation_up", "fallback" },
			["<C-f>"] = { "scroll_documentation_down", "fallback" },
			-- Show/hide signature
			["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
		    },

		    appearance = {
			-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
			-- Adjusts spacing to ensure icons are aligned
			nerd_font_variant = "mono",
		    },

		    sources = {
			-- `lsp`, `buffer`, `snippets`, `path`, and `omni` are built-in
			-- so you don't need to define them in `sources.providers`
			default = { "lsp", "path", "snippets", "buffer" },

			-- Sources are configured via the sources.providers table
		    },

		    -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
		    -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
		    -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
		    --
		    -- See the fuzzy documentation for more information
		    fuzzy = { implementation = "prefer_rust_with_warning" },
		    completion = {
			-- The keyword should only match against the text before
			keyword = { range = "prefix" },
			menu = {
			    -- Use treesitter to highlight the label text for the given list of sources
			    draw = {
				treesitter = { "lsp" },
			    },
			},
			-- Show completions after typing a trigger character, defined by the source
			trigger = { show_on_trigger_character = true },
			documentation = {
			    -- Show documentation automatically
			    auto_show = true,
			},
		    },

		    -- Signature help when tying
		    signature = { enabled = true },
		},
		opts_extend = { "sources.default" },
	    },

	-- lsp
	{
		"mason-org/mason.nvim", opts = {} 
	},

	-- transparency plugin
	{
		"xiyaowong/transparent.nvim", opts = {}
		-- TransparentEnable
		-- TransparentDisable
		-- TransparentToggle

	},
})


local actions = require('telescope.actions')
require('telescope').setup{
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    mappings = {
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
--        ["<C-h>"] = "which_key"
		["<C-q>"] = actions.close,
		["<C-c>"] = actions.send_to_qflist + actions.open_qflist,
      },

      n = {
		["<C-q>"] = actions.close,
		["<C-c>"] = actions.send_to_qflist + actions.open_qflist,
      }
    }
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
    fzf = {
	    fuzzy = true,
	    override_generic_sorter = true,
	    override_file_sorter = true,
	    case_mode = "smart_case",
    },

  }
}

require('telescope').load_extension('fzf')
