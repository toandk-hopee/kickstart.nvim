-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal' },
  },
  opts = {
    filesystem = {
      window = {
        mappings = {
          ['\\'] = 'close_window',
        },
      },
    },
  },
  config = function()
    require('neo-tree').setup {
      filesystem = {
        filtered_items = {
          visible = true,
          show_hidden_count = true,
          hide_dotfiles = false,
          hide_gitignored = false,
        },
        follow_current_file = {
          enabled = true,
          leave_dirs_open = false,
        },
      },
      buffers = { follow_current_file = { enable = true } },
      window = {
        width = 25,
      },
      lazy = false,
    }
  end,
  --init = function()
  --  -- FIX: use `autocmd` for lazy-loading neo-tree instead of directly requiring it,
  --  -- because `cwd` is not set up properly.
  --  vim.api.nvim_create_autocmd('BufEnter', {
  --    group = vim.api.nvim_create_augroup('Neotree_start_directory', { clear = true }),
  --    desc = 'Start Neo-tree with directory',
  --    once = true,
  --    callback = function()
  --      if package.loaded['neo-tree'] then
  --        return
  --      else
  --        local stats = vim.uv.fs_stat(vim.fn.argv(0))
  --        if stats and stats.type == 'directory' then
  --          require 'neo-tree'
  --        end
  --      end
  --    end,
  --  })
  --end,
}
