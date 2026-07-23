local bufnr = vim.api.nvim_get_current_buf()

-- Buffer-local keymap helper (mirrors the LSP `map` helper in init.lua).
local map = function(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { silent = true, buffer = bufnr, desc = desc })
end

-- Small wrapper so mappings read as data: `rust('runnables')` builds a function
-- that calls `vim.cmd.RustLsp('runnables')`. rustaceanvim accepts either a plain
-- string or a table of args (e.g. {'hover', 'range'}).
local rust = function(args)
  return function()
    vim.cmd.RustLsp(args)
  end
end

-- Register buffer-local which-key groups. This config normally declares groups via
-- `spec` inside which-key's setup(), but that cannot be scoped to a buffer, so we
-- use `.add(...)` here. Guarded so it is a no-op when which-key is unavailable.
local ok, wk = pcall(require, 'which-key')
if ok then
  wk.add {
    { '<leader>r', group = '[R]ust', buffer = bufnr },
    { '<leader>rr', group = 'Run/Test/Debug', buffer = bufnr },
    { '<leader>rv', group = '[V]iew/Inspect', buffer = bufnr },
    { '<leader>rd', group = '[D]iagnostics', buffer = bufnr },
    { '<leader>rw', group = '[W]orkspace', buffer = bufnr },
    { '<leader>re', group = '[E]dit/Refactor', buffer = bufnr },
  }
end

-- Existing top-level mappings (kept as-is).
map('n', '<leader>a', rust('codeAction'), 'Rust: code [A]ction')
-- Override Neovim's built-in hover keymap with rustaceanvim's hover actions.
map('n', 'K', rust { 'hover', 'actions' }, 'Rust: hover actions')

-- Top-level Rust mappings.
map('n', '<leader>rk', rust { 'hover', 'actions' }, 'Hover actions (alias K)')
map('x', '<leader>rt', rust { 'hover', 'range' }, '[T]ype of selection')
map('n', '<leader>rp', rust('parentModule'), '[P]arent module')

-- Run/Test/Debug (<leader>rr).
map('n', '<leader>rrr', rust('runnables'), '[R]unnables')
map('n', '<leader>rrR', rust('run'), '[R]un at cursor')
map('n', '<leader>rrd', rust('debuggables'), '[D]ebuggables')
map('n', '<leader>rrD', rust('debug'), '[D]ebug at cursor')
map('n', '<leader>rrt', rust('testables'), '[T]estables')
map('n', '<leader>rrl', rust('relatedTests'), 'Re[l]ated tests')

-- View/Inspect (<leader>rv).
map('n', '<leader>rvh', rust { 'view', 'hir' }, 'View [H]IR')
map('n', '<leader>rvm', rust { 'view', 'mir' }, 'View [M]IR')
map('n', '<leader>rvs', rust('syntaxTree'), '[S]yntax tree')
map('n', '<leader>rve', rust('expandMacro'), '[E]xpand macro')
map('n', '<leader>rvg', rust('crateGraph'), 'Crate [g]raph')

-- Diagnostics (<leader>rd).
map('n', '<leader>rde', rust('explainError'), '[E]xplain error')
map('n', '<leader>rdd', rust('renderDiagnostic'), 'Ren[d]er diagnostic')
map('n', '<leader>rdl', rust('relatedDiagnostics'), 'Re[l]ated diagnostics')
map('n', '<leader>rdf', rust { 'flyCheck', 'run' }, '[F]lycheck run')
map('n', '<leader>rdc', rust { 'flyCheck', 'cancel' }, 'Flycheck [c]ancel')
map('n', '<leader>rdx', rust { 'flyCheck', 'clear' }, 'Flycheck clear ([x])')

-- Workspace (<leader>rw).
map('n', '<leader>rws', rust('workspaceSymbol'), 'Workspace [s]ymbol')
map('n', '<leader>rwr', rust('reloadWorkspace'), '[R]eload workspace')
map('n', '<leader>rwc', rust('openCargo'), 'Open [C]argo.toml')
map('n', '<leader>rwd', rust('openDocs'), 'Open [d]ocs (docs.rs)')
map('n', '<leader>rwp', rust('rebuildProcMacros'), 'Rebuild [p]roc macros')
map('n', '<leader>rwl', rust('logFile'), 'Open [l]og file')

-- Edit/Refactor (<leader>re). Range-aware commands are bound in normal and visual.
map({ 'n', 'x' }, '<leader>rea', rust('codeAction'), 'Code [a]ction')
map({ 'n', 'x' }, '<leader>rej', rust('joinLines'), '[J]oin lines')
map({ 'n', 'x' }, '<leader>res', rust('ssr'), '[S]tructural search & replace')
map('n', '<leader>reu', rust { 'moveItem', 'up' }, 'Move item [u]p')
map('n', '<leader>red', rust { 'moveItem', 'down' }, 'Move item [d]own')
