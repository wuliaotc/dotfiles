return {
  on_setup = function(server)
      capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
      capabilities.offsetEncoding = 'utf-8'
    server.setup({
      capabilities = capabilities,
      flags = {
        debounce_text_changes = 150,
      },
      on_attach = function(client, bufnr)
        client.server_capabilities.document_formatting = false
        client.server_capabilities.document_range_formatting = false
        local function buf_set_keymap(...)
          ---@diagnostic disable-next-line: missing-parameter
          vim.api.nvim_buf_set_keymap(bufnr, ...)
        end
        require("keybindings").mapLSP(buf_set_keymap)
      end,
    })
  end,
}
