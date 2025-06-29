-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local plugins = {
    
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    
    {
      'nvim-telescope/telescope.nvim', tag = '0.1.8', 
      dependencies = { 'nvim-lua/plenary.nvim' }
    },

    {
      "nvim-treesitter/nvim-treesitter", branch = 'master', lazy = false, build = ":TSUpdate"
    },

  }

local opts = {}

require("lazy").setup(plugins, opts)

-- Telescope configuration
local builtin = require("telescope.builtin")
vim.keymap.set('n', '<D-f>', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

-- Treesitter configuration
local ts_config = require("nvim-treesitter.configs")
ts_config.setup({
  ensure_installed = {
    "lua", 
    "typescript", 
    "python", 
    "rust", 
    "ruby"
  },
  highlight = { enable = true },
  indent = { enable = true },
})


require("catppuccin").setup()
vim.cmd.colorscheme "catppuccin"
