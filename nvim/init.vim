"lua require'config'

let mapleader=" "
let localleader="\\"

call plug#begin('~/.vim/vplug')
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'jremmen/vim-ripgrep'
Plug 'vimwiki/vimwiki'
Plug 'NLKNguyen/papercolor-theme'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'preservim/vim-pencil' " wrapping
Plug 'nvim-lualine/lualine.nvim'
"Plug 'neovim/nvim-lspconfing'
call plug#end()

:set backupcopy=yes

" My config mappings from .vimrc
noremap <leader>ev :edit ~/.config/nvim/init.vim<cr>
noremap <leader>el :edit ~/.config/nvim/lua/config.lua<cr>
noremap <leader>sv :source ~/.config/nvim/init.vim<cr>
noremap <leader>sl :luafile ~/.config/nvim/lua/config.lua<cr>
noremap <leader>ed :edit ~/.config/nvim/ftplugin/<cr>

" hightlight like search without moving the cursor
nnoremap <Space>* <Cmd>let @/='\<'.expand('<cword>').'\>'<bar>set hlsearch<CR>

" Date
noremap <leader>D :execute ':normal! a'.strftime('%Y-%m-%d')<cr>

" Make Esc work in the terminal the way you'd expect
" NOTE: This breaks the popup windows like <leader>-p
"tnoremap <Esc> <C-\><C-n>

" Not using tmux anymore but like having these mappings
noremap <C-h> <C-w><C-h>
noremap <C-j> <C-w><C-j>
noremap <C-k> <C-w><C-k>
noremap <C-l> <C-w><C-l>

nnoremap <leader>p :FZF<CR>

nnoremap <leader>bd :e#<bar>bd #<CR>
nnoremap <leader>; :Buffers<CR>
"nnoremap <leader>; :lua open_floating_buffer_list()<CR>


"nnoremap yof :Goyo<CR>:lua toggleLuaLine()<CR>
"nnoremap <leader>w<leader>w :e 2024-06.md<cr>

"let g:vimwiki_list=[{'path': '~/', 'listsyms': ' .oOx'}]

command! StripTrailingWhiteSpace :%s/\s\{1,\}$<cr>

" Expirimental from here: 5/20/24, this actually works just fine for me
" https://github.com/neovim/neovim/issues/5054#issuecomment-911087978
" capture (dump) the (somewhat long) ouput of the commands like `:digraph`, `:map', `:highlight`, `:scripnames` etc.

function! s:dump(cmd) abort

    let m = execute(a:cmd)
    " Start a new split or maybe a buffer or a tab
    enew | " open a new buffer
    " 10split | enew | " open a new split (with 10% height (?))
    " tabnew | " open a new tab

    " Make it a scratch buffer ( `:help special-buffers`)
    setlocal
                \ bufhidden=wipe
                \ buftype=nofile
                \ nobuflisted
                \ nolist
                \ noswapfile
                \ norelativenumber
                \ nonumber<

    " Write the cmd output to the buffer
    put =m
    " There are 2 empty line at the beginning of the buffer before the ouput of
    " the cmd. Not sure from where they are comning from. Anyhow I will delete
    " them.
    " norm gg2dd

    " No modifications to this buffer
    setlocal readonly nomodifiable nomodified

    " Press escape to close when you're done
    nnoremap <buffer><silent> <Esc> :Bd<CR>

endfunction

" Define a command to use the function easier
command! -nargs=1 Pager execute "call s:dump(" string(<q-args>) ")"

"colorscheme kanagawa
"colorscheme tokyonight
colorscheme PaperColor

