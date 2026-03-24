-- Editor plugins (enhance editing capabilities)
return {
	-- autopairs
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("user.autopairs").setup()
		end,
	},
	
	-- easy comments
	{
		"numToStr/Comment.nvim",
		event = "BufReadPost",
		config = function()
			require("user.comment").setup()
		end,
	},
	{ "JoosepAlviste/nvim-ts-context-commentstring", event = "VeryLazy" },
	
	-- snippets
	{ "L3MON4D3/LuaSnip", event = "InsertEnter" },
	{ "rafamadriz/friendly-snippets", event = "InsertEnter" },
	
	-- completions
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			{ "hrsh7th/cmp-buffer", event = "InsertEnter" },
			{ "hrsh7th/cmp-path", event = "InsertEnter" },
			{ "hrsh7th/cmp-cmdline", event = "CmdlineEnter" },
			{ "hrsh7th/cmp-nvim-lsp", event = "InsertEnter" },
			{ "hrsh7th/cmp-nvim-lua", event = "InsertEnter" },
			{
				"L3MON4D3/LuaSnip",
				event = "InsertEnter",
				dependencies = { "rafamadriz/friendly-snippets" },
			},
		},
		config = function()
			require("user.cmp").setup()
		end,
	},
	
	-- make it easy to add surrounding characters
	{ "tpope/vim-surround", event = "BufReadPost" },
	
	-- distraction-free writing
	{
		"folke/zen-mode.nvim",
		cmd = "ZenMode",
		opts = {
			window = {
				width = 80,
				options = {
					number = false,
					relativenumber = false,
					signcolumn = "no",
					cursorline = false,
				},
			},
			plugins = {
				twilight = { enabled = false },
				gitsigns = { enabled = false },
			},
		},
	},
	{
		"folke/twilight.nvim",
		cmd = "Twilight",
		opts = {
			dimming = { alpha = 0.25 },
			context = 10,
		},
	},
}