-- Extra Telescope settings. Loaded after the main Telescope setup in init.lua;
-- calling setup() again only adds/overrides the keys given here.
require('telescope').setup {
  pickers = {
    colorscheme = { enable_preview = true },
  },
}

vim.keymap.set('n', '<leader>sc', function() require('telescope.builtin').colorscheme { enable_preview = true } end, { desc = '[S]earch [C]olorscheme' })
