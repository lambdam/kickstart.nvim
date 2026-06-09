-- JavaScript tooling (LSP + linting + formatting)
--
-- Note: the `ts_ls` language server and `eslint` server both handle plain
-- JavaScript (.js / .jsx / .mjs / .cjs), not just TypeScript -- so this is all
-- you need for a JS project. No TypeScript-specific config is added here.

-- Treesitter: highlighting, indentation and text objects for JS.
-- (jsx is parsed by the `javascript` parser, so no separate install needed.)
require('nvim-treesitter').install('javascript')

-- Make sure the tools are installed via Mason.
--   typescript-language-server -> `ts_ls`     : completion, go-to-def, rename, hover
--   eslint-lsp                 -> `eslint`    : diagnostics + `:EslintFixAll` code action
--   prettierd                  -> formatter   : used by conform (see below)
local registry = require('mason-registry')
for _, pkg in ipairs({ 'typescript-language-server', 'eslint-lsp', 'prettierd' }) do
  if not registry.is_installed(pkg) then
    registry.get_package(pkg):install()
  end
end

-- Enable the language servers using Neovim's native LSP API.
-- nvim-lspconfig ships sensible defaults (cmd + filetypes + root detection),
-- and `eslint` automatically respects flat config (eslint.config.js) as well
-- as legacy .eslintrc files, so we don't override anything here.
vim.lsp.enable('ts_ls')
vim.lsp.enable('eslint')

-- Formatting: register Prettier with conform so `<leader>f` formats JS files.
-- `stop_after_first` runs prettierd if available, falling back to prettier.
-- This only registers the formatter -- nothing runs automatically on save
-- (format-on-save is controlled by the `format_on_save` table in init.lua).
local conform = require('conform')
local prettier = { 'prettierd', 'prettier', stop_after_first = true }
for _, ft in ipairs({
  'javascript',
  'javascriptreact',
  'json',
  'jsonc',
  'css',
  'scss',
  'html',
}) do
  conform.formatters_by_ft[ft] = prettier
end
