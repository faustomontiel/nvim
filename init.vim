" ───────────── Plugin manager ─────────────
call plug#begin('~/.vim/plugged')

" Navegador de archivos
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-tree/nvim-web-devicons' " iconos bonitos

" Autocompletado estilo VSCode
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Tema de colores (opcional)
Plug 'morhetz/gruvbox'
"Plug 'folke/tokyonight.nvim'
Plug 'ellisonleao/gruvbox.nvim'
Plug 'hashivim/vim-terraform'

" Requisitos para Telescope
Plug 'nvim-lua/plenary.nvim'          " dependencia
Plug 'nvim-telescope/telescope.nvim'  " el plugin en sí

"GIT diff
Plug 'tpope/vim-fugitive'


call plug#end()

" ───────────── Configuración general ─────────────
syntax on
set number
set relativenumber
set termguicolors
"colorscheme tokyonight
set background=dark
colorscheme gruvbox

" Restaurar posición del cursor
if has("autocmd")
  au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal! g'\"" |
        \ endif
endif

" Indentación automática
set autoindent
set smartindent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" Moverse entre líneas con h/l en los bordes
set whichwrap+=<,>,h,l


inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"


" ───────────── nvim-tree ─────────────
lua << EOF
require("nvim-tree").setup()
EOF
nnoremap <C-n> :NvimTreeToggle<CR>

lua << EOF
require('telescope').setup{}
EOF

let mapleader = " "
nnoremap <leader>ff :Telescope find_files<CR>
nnoremap <leader>fg :Telescope live_grep<CR>
nnoremap <leader>fb :Telescope buffers<CR>
nnoremap <leader>fh :Telescope help_tags<CR>


" ───────────── coc.nvim ─────────────
" Mostrar sugerencias automáticamente
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <silent><expr> <S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Ir a definición, hover info, etc.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> K :call CocActionAsync('doHover')<CR>
nmap <leader>rn <Plug>(coc-rename)
