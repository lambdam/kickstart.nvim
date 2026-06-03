local default_width = 40

local function toggle_width()
  local win = vim.api.nvim_get_current_win()
  local wide = math.floor(vim.o.columns * 0.9) -- 90% of the screen's width
  local current = vim.api.nvim_win_get_width(win)
  vim.api.nvim_win_set_width(win, current ~= default_width and default_width or wide)
end

-- Live grep in the folder under the cursor in the tree
local function grep_in_node(state)
  local node = state.tree:get_node()
  -- For a file, use its parent directory; for a directory, use the directory itself
  local dir = node.type == 'directory' and node.path or vim.fn.fnamemodify(node.path, ':h')
  require('telescope.builtin').live_grep { search_dirs = { dir } }
end

require('neo-tree').setup {
  window = {
    width = default_width,
  },
  filesystem = {
    window = {
      mappings = {
        ['\\'] = 'close_window',
        ['<'] = function() vim.cmd('vertical resize -5') end,
        ['>'] = function() vim.cmd('vertical resize +5') end,
        ['<Tab>'] = toggle_width,
        ---@diagnostic disable-next-line: assign-type-mismatch
        ['gs'] = { grep_in_node, desc = '[G]rep in folder' },
      },
    },
  },
}

local function update_background()
  vim.api.nvim_set_hl(0, 'NeoTreeNormal', { link = 'Normal' })
  vim.api.nvim_set_hl(0, 'NeoTreeNormalNC', { link = 'Normal' })
  vim.api.nvim_set_hl(0, 'NeoTreeEndOfBuffer', { link = 'Normal' })
end

update_background()

vim.api.nvim_create_autocmd('ColorScheme', { callback = update_background })

-- Live grep scoped to a prompted subfolder (defaults to the current file's folder)
vim.keymap.set('n', '<leader>sG', function()
  vim.ui.input({ prompt = 'Subfolder: ', completion = 'dir', default = vim.fn.expand '%:h' }, function(dir)
    if dir and dir ~= '' then
      require('telescope.builtin').live_grep { search_dirs = { dir } }
    end
  end)
end, { desc = '[S]earch by [G]rep in folder' })
