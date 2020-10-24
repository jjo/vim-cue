" Options.

if !exists("g:cue_command")
  let g:cue_command = "cue"
endif

if !exists("g:cue_fmt_command")
  let g:cue_fmt_command = "fmt"
endif

if !exists('g:cue_fmt_options')
  let g:cue_fmt_options = ''
endif


" Format calls `cue fmt ... ` on the file and replaces the file with the auto
" formatted version.
function! cue#Format() abort
  " Save the view.
  let curw = winsaveview()

  " Make a fake change so that the undo point is right.
  normal! ix
  normal! "_x

  " Execute `terraform fmt`, redirecting stderr to a temporary file.
  let tmpfile = tempname()
  let shellredir_save = &shellredir
  let &shellredir = '>%s 2>'.tmpfile
  silent execute '%!' . g:cue_command . " " . g:cue_fmt_command . " " . g:cue_fmt_options . " -"
  let &shellredir = shellredir_save

  " If there was an error, undo any changes and show stderr.
  if v:shell_error != 0
    silent undo
    let output = readfile(tmpfile)
    echo join(output, "\n")
  endif

  " Delete the temporary file, and restore the view.
  call delete(tmpfile)
  call winrestview(curw)
endfunction
