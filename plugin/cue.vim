

" A plugin for cue files.
" Install useful tools for *.cue files







function! s:fmtAutosave()
  " Cue code formatting on save
  if get(g:, "cue_fmt_on_save", 1)
    call cue#Format()
  endif
endfunction


" auto group and clear inside prevents multiple registration of the same
" auto commands
augroup vim-cue
   autocmd!
   autocmd BufReadPre *.cue setlocal foldmethod=syntax
   autocmd BufReadPre *.cue setlocal foldlevel=100
   autocmd BufWritePre *.cue call s:fmtAutosave()
augroup END

