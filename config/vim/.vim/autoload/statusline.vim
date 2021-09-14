function! statusline#linepercent() abort
  return line('.') * 100 / line('$')
endfunction

function! statusline#gutterpadding() abort
  let l:minwidth=2
  let l:gutterWidth=max([strlen(line('$')) + 1, &numberwidth, l:minwidth])
  let l:padding=repeat(' ', l:gutterWidth - 1)
  return l:padding
endfunction

function! statusline#fileprefix() abort
  let l:basename=expand('%:h')
  if l:basename == '' || l:basename == '.'
    return ''
  else
    " Make sure we show $HOME as ~.
    return substitute(l:basename . '/', '\C^' . $HOME, '~', '')
  endif
endfunction

function! statusline#ft() abort
  if strlen(&ft)
    return ',' . &ft
  else
    return ''
  endif
endfunction

function! statusline#fenc() abort
  if strlen(&fenc) && &fenc !=# 'utf-8'
    return ',' . &fenc
  else
    return ''
  endif
endfunction

function! statusline#lhs() abort
  let l:line=statusline#gutterpadding()
  let l:line.=&modified ? '+ ' : '  '
  return l:line
endfunction

function! statusline#rhs() abort
  let l:line=' '
  if winwidth(0) > 80
    let l:line.='ℓ ' " (Literal, \u2113 "SCRIPT SMALL L").
    let l:line.=line('.')
    let l:line.='/'
    let l:line.=line('$')
    let l:line.=' ('
    let l:line.=statusline#linepercent()
    let l:line.='%) c '
    let l:line.=virtcol('.')
    let l:line.='/'
    let l:line.=virtcol('$')
    let l:line.=' '
  endif
  return l:line
endfunction


let s:default_lhs_color='Error'
let s:focus_lhs_color=''

" function! statusline#check_modified() abort

" endfunction

function! statusline#update_highlight() abort
  " StatusLine (italics)
  let l:highlight=pinnacle#italicize('StatusLine')
  execute 'highlight User1 ' . l:highlight

  " StatusLine (bold)
  let l:highlight=pinnacle#embolden('StatusLine')
  execute 'highlight User2 ' . l:highlight

  " Right-hand side section
  let l:bg=pinnacle#extract_bg('ToolbarButton')
  let l:fg=pinnacle#extract_fg('User2')
  execute 'highlight User3 ' .
        \ pinnacle#highlight({
        \   'bg': l:fg,
        \   'fg': l:bg,
        \   'term': 'bold'
        \ })
endfunction
