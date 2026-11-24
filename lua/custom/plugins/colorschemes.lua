-- Extra colorscheme plugins, so they show up (and work) in `:Telescope colorscheme`.
-- base16-nvim is installed on disk, but without a vim.pack.add it is never loaded,
-- so its colors/*.vim files fail with "module 'base16-colorscheme' not found".

---@param repo string
---@return string
local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add { gh 'RRethy/base16-nvim' }
vim.pack.add { gh 'navarasu/onedark.nvim' }
vim.pack.add { gh 'olimorris/onedarkpro.nvim' }

require('onedark') --.setup { style = 'light' }
vim.cmd.colorscheme 'onedark'
