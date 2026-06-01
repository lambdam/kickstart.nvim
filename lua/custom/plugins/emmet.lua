-- Install the emmet-language-server via Mason if it isn't already
local registry = require('mason-registry')
if not registry.is_installed('emmet-language-server') then
  registry.get_package('emmet-language-server'):install()
end

-- Enable emmet_language_server using Neovim's native LSP API.
-- nvim-lspconfig ships the default config (cmd + filetypes), which already
-- covers html, css/scss/sass/less, jsx/tsx, vue, svelte, astro, eruby,
-- htmlangular and htmldjango -- so we don't override `filetypes` here.
vim.lsp.enable('emmet_language_server')
