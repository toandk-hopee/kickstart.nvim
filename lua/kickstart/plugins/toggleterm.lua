return {
  'akinsho/toggleterm.nvim',
  version = '*',
  config = function()
    require('toggleterm').setup {
      lazy = true,
      open_mapping = { [[<c-t>]], [[<c-¥>]] },
    }
    vim.keymap.set('n', '<leader>tr', function()
      local fidget = require 'fidget'

      -- find ".ttermrun" in the working directory for cmd to run
      local cwd = vim.fn.getcwd()
      local ttermrun = cwd .. '/.ttermrun'
      local cmd = ''
      if vim.fn.filereadable(ttermrun) == 1 then
        cmd = vim.fn.readfile(ttermrun)[1]
      else
        fidget.notify('No run config is found in the current directory', vim.log.levels.WARN)
        return
      end

      -- tries to find toggleterm with id 99 (arbitrarily high number)
      -- if it exists, sends SIGINT/2 (interrupt) to the first child process
      -- if not, creates a new terminal with the same id
      local toggleterm = require 'toggleterm.terminal'
      local term = toggleterm.get(99, true)
      if term ~= nil then
        local jobpid = vim.fn.jobpid(term.job_id)
        local termchildren = vim.api.nvim_get_proc_children(jobpid)
        if next(termchildren) ~= nil then
          vim.system { 'kill', '-2', '-' .. termchildren[1] }
        end
      else
        term = toggleterm.Terminal:new { id = 99, display_name = 'RUN' }
        term:spawn()
      end
      if term ~= nil then
        fidget.notify('Running: ' .. cmd, vim.log.levels.INFO)
        term:send(cmd, true)
      else
        fidget.notify('Failed to create terminal', vim.log.levels.ERROR)
        return
      end
    end, { desc = 'Make [T]oggleterm [R]un' })
  end,
}
