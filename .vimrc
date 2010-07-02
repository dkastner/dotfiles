syntax on
filetype plugin indent on
colorscheme darkblue 

au BufNewFile,BufRead *.clj set ft=clojure
au BufNewFile *_spec.rb 0r ~/.vim/skeletons/rspec.rb
au BufNewFile,BufRead Gemfile set ft=ruby
augroup markdown
  au! BufRead,BufNewFile *.mkd  setfiletype mkd
  au! BufRead,BufNewFile *.md  setfiletype mkd
augroup END

runtime! autoload/pathogen.vim
if exists("g:loaded_pathogen")
  call pathogen#runtime_append_all_bundles()
end

if (has('gui_running'))
  " set guifont=Monaco:h16
  set guifont=Inconsolata:h22
  set guioptions-=T
  set columns=120
  set lines=70
  set number
  " Use the same symbols as TextMate for tabstops and EOLs
  set listchars=tab:▸\ ,eol:¬
endif

set tabstop=2
set shiftwidth=2
set expandtab
set softtabstop=2

set clipboard=unnamed

set spell

"Invisible character colors
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59

autocmd FileType ruby runtime ruby_mappings.vim

map <silent> <LocalLeader>nt :NERDTreeToggle<CR>
map <silent> <LocalLeader>nr :NERDTree<CR>

map <silent> <LocalLeader>nh :nohls<CR>

" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>

" more shortcuts
map <D-s> :w<CR>
map <D-w> :q<CR>
map <D-}> :tabnext<CR>
map <D-{> :tabprev<CR>
map <D-/> :s/^/#/<CR>
map <D-'> :s/^#//<CR>

" fuf shortcuts
map <D-T> :FuzzyFinderTextMate<CR>

"ruby
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
"improve autocomplete menu color
highlight Pmenu ctermbg=238 gui=bold

"specky commands
let g:speckyBannerKey = "<C-S>b"
let g:speckyRunRdocKey = "<C-S>r"
let g:speckySpecSwitcherKey = "<C-S>x"
let g:speckyRunSpecKey = "<C-S>s"
let g:speckyRunSpecCmd = "spec -fs -r loadpath.rb"
let g:speckyRunRdocCmd = "fri -L -f plain"
let g:speckyWindowType = 2
