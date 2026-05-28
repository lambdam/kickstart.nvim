require('nvim-treesitter').install('rust')

vim.pack.add { 'https://github.com/mfussenegger/nvim-dap' }

local registry = require('mason-registry')
if not registry.is_installed('codelldb') then
  registry.get_package('codelldb'):install()
end

if vim.fn.executable('rust-analyzer') == 0 then
  vim.notify(
    'rust-analyzer not found in PATH. Install with: rustup component add rust-analyzer',
    vim.log.levels.WARN
  )
end

vim.pack.add {{
  src = 'https://github.com/mrcjkb/rustaceanvim',
  -- To avoid being surprised by breaking changes,
  -- I (Claude) recommend you set a version range
  version = vim.version.range('^9')
}}
