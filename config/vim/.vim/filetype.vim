augroup filetypedetect
  " edit-and-execute-command (temporary files)
  au BufNewFile,BufRead /tmp/bash-fc.*  setf bashfc
augroup END
