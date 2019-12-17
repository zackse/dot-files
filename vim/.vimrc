" vim, not vi
set nocompatible
syntax on
set nobackup
set nohlsearch
set noincsearch
set showmatch
set softtabstop=4
set shiftwidth=4
set tabstop=8
set expandtab
set shiftround                    "Indent/outdent to nearest tabstop
set noerrorbells
set autoindent
set ruler
set matchpairs+=<:>               "Allow % to bounce between angles too
set textwidth=78
set backspace=indent,eol,start    "Make backspaces delete sensibly
set guifont=Monospace\ 12
set modelines=3

" perl-specific settings
au BufRead,BufNewFile *.pm,*.pl,*.t set syn=perl cindent cinoptions=t0,(2,)30,u0,*40 cinwords=if,else,while,do,for,elsif,sub cinkeys=0{,0},0),:,!^F,o,O,e comments=n:# formatoptions=crql nosmartindent
" disable auto wrapping in html-like files
au BufRead,BufNewFile *.html,*.tmpl,*.shtml set textwidth=0 wrapmargin=0 syn=html
au BufRead,BufNewFile *.xml set textwidth=0 wrapmargin=0 syn=xml

au BufRead,BufNewFile cmd__ set syn=sh
au BufRead,BufNewFile release_notes set tw=0
au BufRead,BufNewFile *.md set tw=0

au BufRead,BufNewFile *.go set syn=go noexpandtab
au BufRead,BufNewFile *.clj set syn=clojure

" C-x C-e to edit command line in bash
au BufRead,BufNewFile /tmp/bash-fc-* set tw=0 syn=sh

" terraform sh template
au BufRead,BufNewFile *.sh.tpl set syn=sh

" bbs
autocmd FileType php set tw=0 noexpandtab tabstop=8 softtabstop=0 shiftwidth=0

au BufRead,BufNewFile *.pp set filetype=puppet

" Makefile
autocmd FileType make set tw=0 noexpandtab tabstop=8 softtabstop=0 shiftwidth=8

let perl_want_scope_in_variables=1
let perl_extended_vars=1
let perl_include_pod=1

let loaded_matchparen = 1

au BufRead,BufNewFile *.pm,*.pl,*.t setlocal keywordprg=perldoc\ -f

"Inserting these abbreviations inserts the corresponding Perl statement...
iab phbp  #! /usr/bin/perl -w      
iab pdbg  use Data::Dumper 'Dumper';warn Dumper [];hi
iab pbmk  use Benchmark qw( cmpthese );cmpthese -10, {};O     
iab putm  use Test::More qw( no_plan );
 
map ,pt :%! perltidy
map ,ptv :'<,'>! perltidy

" comment out line
map # 0I#j

" <TMPL_VAR> to <!-- TMPL_VAR -->
map ,t :%perldo s{<(/?TMPL_[^>]+)>}{<!-- $1 -->}g

" from http://www.perlmonks.org/index.pl?node_id=166856
function! InsertTabWrapper(direction)
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    elseif "backward" == a:direction
        return "\<c-p>"
    else
        return "\<c-n>"
    endif
endfunction

inoremap <S-tab> <c-r>=InsertTabWrapper ("backward")<cr>
inoremap <tab> <c-r>=InsertTabWrapper ("forward")<cr>

" http://www.vim.org/tips/tip.php?tip_id=80
" From Bram:
" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
" DF - Also do not do this if the file resides in the $TEMP directory,
"      chances are it is a different file with the same name.
" This comes from the $VIMRUNTIME/vimrc_example.vim file
autocmd BufReadPost *
  \ if expand("<afile>:p:h") !=? $TEMP |
  \   if line("'\"") > 0 && line("'\"") <= line("$") |
  \     exe "normal g`\"" |
  \     let b:doopenfold = 1 |
  \   endif |
  \ endif
" Need to postpone using "zv" until after reading the modelines.
autocmd BufWinEnter *
  \ if exists("b:doopenfold") |
  \   unlet b:doopenfold |
  \   exe "normal zv" |
  \ endif 
