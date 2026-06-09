require('nvim-treesitter').install('rust')

-- Askama (Rust templating) Treesitter grammar.
--
-- The stock `htmldjango` parser is a Django/Jinja grammar and chokes on
-- Askama's Rust-flavored syntax (`{{ x.unwrap_or("") }}`, `{% if let %}`,
-- `{% match %}`, `{% macro %}`, `i18n!(..)`), emitting ERROR nodes that wipe
-- out highlighting for whole regions. `lpnh/tree-sitter-askama` parses those
-- cleanly and injects `html` for the markup.
--
-- This only registers + installs the parser; it is NOT yet associated with any
-- filetype. Requires the `tree-sitter` CLI and a C compiler on PATH to build.
--
-- The registration lives in a `User TSUpdate` autocommand (the official way to
-- add a custom parser): nvim-treesitter rebuilds its parser table on every
-- install/update, firing this event, so the entry is re-added each time.
vim.api.nvim_create_autocmd('User', {
  pattern = 'TSUpdate',
  callback = function()
    require('nvim-treesitter.parsers').askama = {
      install_info = {
        url = 'https://github.com/lpnh/tree-sitter-askama',
        revision = 'v0.3.0', -- commit hash or tag to check out
        queries = 'queries', -- also install queries from this directory
      },
    }
  end,
})
require('nvim-treesitter').install('askama')

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
