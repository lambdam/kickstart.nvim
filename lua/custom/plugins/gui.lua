vim.opt.guifont = 'FiraCode Nerd Font:h14'

-- Neovide configuration
if vim.g.neovide then
  vim.g.neovide_cursor_animation_length = 0.1 -- default 0.15
  vim.g.neovide_scroll_animation_length = 0.1 -- default 0.3
  vim.g.neovide_cursor_trail_size = 0.5 -- default 1
end
