syntax on
filetype plugin indent on
colorscheme darkblue 
au BufNewFile,BufRead *.clj set ft=clojure

runtime! autoload/pathogen.vim
if exists("g:loaded_pathogen")
  call pathogen#runtime_append_all_bundles()
end

if (has('gui_running'))
  set guifont=Monaco:h16
  set guioptions-=T
  set columns=120
  set lines=70
  set number
endif

set tabstop=2
set shiftwidth=2
set expandtab

set clipboard=unnamed

autocmd FileType ruby runtime ruby_mappings.vim

map <silent> <LocalLeader>nt :NERDTreeToggle<CR>
map <silent> <LocalLeader>nr :NERDTree<CR>

map <silent> <LocalLeader>nh :nohls<CR>

"ruby
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
"improve autocomplete menu color
highlight Pmenu ctermbg=238 gui=bold
