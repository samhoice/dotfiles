-- pipx install pyright
-- require'lspconfig'.pyright.setup{}
require'lspconfig'.basedpyright.setup{}
-- npm install i -g tsserver
-- Instead of that, use typescript-language-server
-- require'lspconfig'.tsserver.setup{}
require'lspconfig'.ts_ls.setup{}
-- npm i -g vscode-langservers-extracted
--require'lspconfig'.eslint.setup{}
--require'lspconfig'.marksman.setup{}

 vim.api.nvim_create_autocmd("Filetype", {
 	pattern = { "html", "shtml", "htm" },
 	callback = function()
 		vim.lsp.start({
 			name = "superhtml",
 			cmd = { "superhtml", "lsp" },
 			root_dir = vim.fs.dirname(vim.fs.find({".git"}, { upward = true })[1])
 		})
 	end
 })

require'lualine'.setup{}

-- require('buffer_switcher')

-- Make errors show up in the location list
vim.api.nvim_create_augroup('diagnostics', { clear = true })
vim.api.nvim_create_autocmd('DiagnosticChanged', {
  group = 'diagnostics',
  callback = function()
    vim.diagnostic.setloclist({ open = false })
  end,
})

-- These are supposed to be configured by default but don't seem to be?
vim.keymap.set('n', 'grn', vim.lsp.buf.rename)
vim.keymap.set('n', 'gra', vim.lsp.buf.code_action)
vim.keymap.set('n', 'grr', vim.lsp.buf.references)
vim.keymap.set('n', 'grh', vim.lsp.buf.signature_help)

require('lualine').hide()
require('lualine').hide({unhide=true})

-- vim.api.nvim_set_option('cursorline', true)
-- vim.api.nvim_set_option('cursorcolumn', true)

ll_hidden = false

function toggleLuaLine ()
    require('lualine').hide({unhide=ll_hidden})
    ll_hidden = not ll_hidden
end

function focus_on ()
    require('lualine').hide({unhide=false})
    ll_hidden = true 
    vim.cmd('Goyo!')
    vim.cmd('Goyo')
end

function focus_off ()
    require('lualine').hide({unhide=true})
    ll_hidden = false
    vim.cmd('Goyo!')
end

function toggle_focus ()
    toggleLuaLine()
    vim.cmd('Goyo')
end


vim.keymap.set('n', '[of', focus_on)
vim.keymap.set('n', ']of', focus_off)
vim.keymap.set('n', 'yof', toggle_focus)

-- https://github.com/nvim-treesitter/nvim-treesitter/wiki/Installation
require'nvim-treesitter.configs'.setup{highlight={enable=true}}
