" <Leader> mappings
"
" <Leader>r -- Cycle through relativenumber + number, number (only), and no
" numbering (mnemonic: relative).
"
" https://www.youtube.com/watch?v=0aEv1Nj0IPg
nnoremap <silent> <Leader>r :call mappings#cycle_numbering()<CR>
