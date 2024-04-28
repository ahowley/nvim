-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.6',
		-- or                            , branch = '0.1.x',
		requires = { {'nvim-lua/plenary.nvim'} }
	}

	use {
		"folke/which-key.nvim",
		config = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
			require("which-key").setup {

			}
		end
	}

	use { "tpope/vim-sleuth" }

	use {
		'numToStr/Comment.nvim',
		config = function()
			require('Comment').setup {
				toggler = {
					line = '<leader>cc',
					block = '<leader>bc',
				},
				opleader = {
					line = '<leader>c',
					block = '<leader>b',
				},
				extra = {
					below = '<leader>co',
					eol = '<leader>cA',
				},
				mappings = {
					basic = true,
					extra = true,
				},
			}
		end
	}

	use { "lewis6991/gitsigns.nvim", config = function()
		require("gitsigns").setup {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		}
	end}
end)
