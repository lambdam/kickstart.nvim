vim.keymap.set("n", "<leader>e", function()
  vim.diagnostic.config({ virtual_lines = { current_line = true } })
  vim.api.nvim_create_autocmd("CursorMoved", {
    once = true,
    callback = function()
      vim.diagnostic.config({ virtual_lines = false })
    end,
  })
end, { desc = "Peek diagnostic (virtual line) for current line" })

vim.keymap.set("n", "<leader>E", function()
  if vim.diagnostic.config().virtual_lines == false then
    vim.diagnostic.config({ virtual_lines = { current_line = true } })
  else
    vim.diagnostic.config({ virtual_lines = false })
  end
end, { desc = "Toggle current-line virtual lines" })
