
let g:cursor = nr2char(str2nr(2038, 16), 1)

nnoremap <expr> <C-N> 'geea' . g:cursor . "\<Esc>b*"
nnoremap <expr> <C-_>    'i' . g:cursor . "\<Esc>l"
inoremap <expr> <C-_> g:cursor
cnoremap <expr> <C-_> g:cursor
nnoremap <silent> <C-Z> :call subliminal#main()<CR>

augroup MultiCursors
	autocmd!
	autocmd BufWritePre * execute 'silent! keeppatterns %s/' . g:cursor . '//g'

	" Conceal!
	autocmd FileType * setlocal conceallevel=2
	autocmd FileType * setlocal concealcursor=nvic
	autocmd FileType * execute 'syntax match Cursor /' . g:cursor .
				\ '/ conceal containedin=ALL'
	autocmd FileType * execute '2match Cursor /' . g:cursor . '\zs./'
augroup END

command! -range=% SubliminalInsert call subliminal#insert(0)
command! -range=% SubliminalAppend call subliminal#insert(1)

