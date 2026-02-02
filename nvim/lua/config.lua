-- pipx install pyright
-- require'lspconfig'.pyright.setup{}
-- require'lspconfig'.basedpyright.setup{}
-- npm install i -g tsserver
-- Instead of that, use typescript-language-server
-- require'lspconfig'.tsserver.setup{}
-- require'lspconfig'.ts_ls.setup{}
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


function create_scratch_buffer ()
    -- Thanks to claude
    -- Create a new buffer
    local buf = vim.api.nvim_create_buf(false, true)
    
    -- Set buffer options
    vim.api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')
    vim.api.nvim_buf_set_option(buf, 'buftype', 'nofile')

    vim.api.nvim_buf_set_option(buf, 'buflisted', false)

    vim.api.nvim_buf_set_option(buf, 'swapfile', false)
    
    -- Switch to the new buffer
    vim.api.nvim_set_current_buf(buf)
    
    -- Set window options for the current window
    vim.opt_local.list = false
    vim.opt_local.relativenumber = false
    vim.opt_local.number = false
    
    return buf
end

local function dump_command(cmd)
    -- Execute the command and capture output

    local output = vim.api.nvim_exec2(cmd, { output = true })
    
    -- Create new scratch buffer
    local buf = create_scratch_buffer()
    
    -- Split output into lines and set buffer content
    local lines = vim.split(output.output, '\n')
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    
    -- Set buffer as readonly and unmodifiable
    vim.api.nvim_buf_set_option(buf, 'readonly', true)
    vim.api.nvim_buf_set_option(buf, 'modifiable', false)
    vim.api.nvim_buf_set_option(buf, 'modified', false)
    
    -- Map Escape to close buffer (using bdelete)
    vim.api.nvim_buf_set_keymap(buf, 'n', '<Esc>', ':bdelete<CR>', 
        { noremap = true, silent = true })
    
    return buf
end

vim.api.nvim_create_user_command('Scratch', create_scratch_buffer, {})
vim.api.nvim_create_user_command('Dump', function(opts)
    dump_command(opts.args)
end, { nargs = 1, complete = 'command' })


-- Source - https://stackoverflow.com/a
-- Posted by Stacky
-- Retrieved 2025-12-09, License - CC BY-SA 4.0

-- use windows clipboard in WSL2:
local uname_output = vim.fn.system('uname -r')
if string.find(uname_output, "microsoft") then
    -- Create the augroup
    local augroup_id = vim.api.nvim_create_augroup("Yank", { clear = true })

    -- Create the autocmd for TextYankPost
    vim.api.nvim_create_autocmd("TextYankPost", {
        group = augroup_id,
        callback = function()
            -- Get the content of the default register (yanked text)
            local yanked_text = vim.fn.getreg('"')
            -- Pipe the yanked text to clip.exe
            vim.fn.system({ "/mnt/c/Windows/System32/clip.exe" }, yanked_text)
        end,
    })
end

