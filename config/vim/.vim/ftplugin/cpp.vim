" C++ specific settings.
if exists("g:loaded_youcompleteme")
  autocmd BufWrite * YcmCompleter Format

  " goto [d]e[c]laration
  nnoremap <buffer><silent> <LocalLeader>dc :YcmCompleter GoToDeclaration<CR>
  " goto [d]e[f]inition
  nnoremap <buffer><silent> <LocalLeader>df :YcmCompleter GoToDefinition<CR>
  " goto [c]allers
  nnoremap <buffer><silent> <LocalLeader>c :YcmCompleter GoToCallers<CR>
endif
