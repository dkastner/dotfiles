syntax on
filetype plugin indent on
colorscheme darkblue
set textwidth=80
set colorcolumn=+1

set noswapfile

set tags=./tags

au BufNewFile,BufRead *.clj set ft=clojure
au BufNewFile *_spec.rb 0r ~/.vim/skeletons/rspec.rb
au BufNewFile,BufRead Gemfile set ft=ruby
au BufNewFile,BufRead Guardfile set ft=javascript
au BufNewFile,BufRead *.coffee set ft=coffee
au BufNewFile,BufRead *.json set ft=javascript
au BufNewFile,BufRead Cakefile set ft=coffee
au BufNewFile,BufRead Nakefile set ft=javascript
au BufNewFile,BufRead *.hbs set ft=html
augroup markdown
  au! BufRead,BufNewFile *.mkd  setfiletype mkd
  au! BufRead,BufNewFile *.md  setfiletype mkd
  au! BufRead,BufNewFile *.markdown  setfiletype mkd
augroup END

runtime! autoload/pathogen.vim
if exists("g:loaded_pathogen")
  call pathogen#runtime_append_all_bundles()
end

if (has('gui_running'))
  colorscheme darkblue 
  set guifont=Monaco:h16
  " set guifont=Inconsolata\ 18
  set guioptions-=T
  set columns=120
  set lines=70
  set number
  " Use the same symbols as TextMate for tabstops and EOLs
  set listchars=tab:▸\ ,eol:¬
  " let g:solarized_contrast="high"
  " colorschem solarized
endif

set tabstop=2
set shiftwidth=2
set expandtab
set softtabstop=2

set cursorline
set incsearch
set hlsearch

set clipboard=unnamed

set spell

set wildignore=*.sed

"Invisible character colors
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59

autocmd FileType ruby runtime ruby_mappings.vim

let mapleader = ","
let localleader = ","
map <silent> <LocalLeader>nt :NERDTreeToggle<CR>
map <silent> <LocalLeader>nr :NERDTree<CR>

map <silent> <LocalLeader>nh :nohls<CR>

" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>

" more shortcuts
map <S-k> k
map <Leader>bn :bn<CR>
map <Leader>bp :bp<CR>

imap jj <Esc>

" fuf shortcuts
map <Leader>Q :q<CR>
map <Leader>> :tabnext<CR>
map <Leader>< :tabprev<CR>
map <Leader>q :bdelete<CR>
map <Leader>w :w<CR>
map <Leader>. :bn<CR>
map <Leader>, :bp<CR>
map \] :s/^/#/<CR>
map \[ :s/^#//<CR>
map <Leader>c c/[A-Z_-]<CR>
map <Leader>d d/[A-Z_-]<CR>

map <Leader>h :call system('touch ' . bufname("%"))<CR>

"plugged in shortcuts
map <Leader>pj <Esc>:%!json_xs -f json_xs -f json -t json-pretty<CR>

"ruby
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
"improve autocomplete menu color
highlight Pmenu ctermbg=238 gui=bold

function! s:Project(dir)
  chdir a:dir
  e a:dir
  1
endfunction
command! -complete=file -nargs=+ Project call s:Project(<q-args>)


let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
