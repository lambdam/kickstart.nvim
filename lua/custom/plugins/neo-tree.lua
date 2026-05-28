local default_width = 40

local function toggle_width()
  local win = vim.api.nvim_get_current_win()
  local wide = math.floor(vim.o.columns * 0.9) -- 90% of the screen's width
  local current = vim.api.nvim_win_get_width(win)
  vim.api.nvim_win_set_width(win, current ~= default_width and default_width or wide)
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
