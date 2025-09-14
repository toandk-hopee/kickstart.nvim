-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'lambdalisue/vim-kensaku-search',
    cmd = 'VKen',
    keys = { { 'vkensaku', ':cnoremap <cr>(kensaku-search-replace)<cr>', desc = 'Japanese search with romaji' } },
    opts = {},
  },
}
