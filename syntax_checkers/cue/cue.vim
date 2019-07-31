" Vim syntastic plugin
" Language: cue
" Author: JuanJo Ciarlante <juanjosec@gmail.com>
"
" For details on how to add an external Syntastic checker:
" https://github.com/scrooloose/syntastic/wiki/Syntax-Checker-Guide#external

if exists("g:loaded_syntastic_cue_cue_checker")
  finish
endif
let g:loaded_syntastic_cue_cue_checker = 1

let s:save_cpo = &cpo
set cpo&vim

function! SyntaxCheckers_cue_cue_IsAvailable() dict
  return executable(self.getExec())
endfunction

function! SyntaxCheckers_cue_cue_GetLocList() dict

  let errorformat =
        \ 'Error: parse: %m,' .
        \ 'expected %m,' .
        \ '\ \ \ \ %f:%l:%c,' .
        \ ''

  return SyntasticMake({
        \ 'makeprg': self.makeprgBuild({}),
        \ 'errorformat': errorformat })
endfunction

call g:SyntasticRegistry.CreateAndRegisterChecker({
      \ 'filetype': 'cue',
      \ 'name': 'cue'})

" Register for syntastic tab completion:
if exists('g:syntastic_extra_filetypes')
  call add(g:syntastic_extra_filetypes, 'cue')
else
  let g:syntastic_extra_filetypes = ['cue']
endif

let &cpo = s:save_cpo
unlet s:save_cpo
