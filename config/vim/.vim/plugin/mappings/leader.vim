" <Leader> mappings

nnoremap <Leader>e :Lex 30<CR>

" <Leader><Leader> -- Open last buffer.
nnoremap <Leader><Leader> <C-^>

" open last buffer (i.e. the alternate file)
nnoremap <Leader>o :only<CR>

" close buffer
nnoremap <Leader>q :quit<CR>
nnoremap <Leader>w :write<CR>
nnoremap <Leader>x :xit<CR>

" search and replace
nnoremap <Leader>s :%s/\\<<C-r><C-w>\\>/<C-r><C-w>/g<Left><Left>
