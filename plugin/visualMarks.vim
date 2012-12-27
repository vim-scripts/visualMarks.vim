" Documentation {{{1
" Name: visualMarks.vim
" Version: 1.1
" Description: Simple plugin to show file marks visually
" Author: Alexandre Viau (alexandreviau@gmail.com)
" Installation: Copy the plugin to the vim plugin directory.
"
" Usage: {{{2
" Simply use vim marks like usually doing
" ma, mb, mc...mz
" or
" mA, mB, mC...mZ
" to marks positions in files.
"
" NOTE: Only new marks are shown visually, this means that the marks already in the viminfo file will not be showned visually.
"
" History:
" 1.0 Initial release
" 1.1 Removed the space in the mappings that where moving the cursor to the right after execution

" Add mappings {{{1
" Uses nnoremap not to have a recursive mapping
" Letters
for n in range(1, 26)
    " Uppercase (A-Z)
    let l = nr2char(n + 64)
    exe 'nnoremap <silent> m' . l . ' m' . l . ':cal g:VmAddSignToMark("' . l . '")<cr>'
    " Lowercase (a-z)
    let l = nr2char(n + 96)
    exe 'nnoremap <silent> m' . l . ' m' . l . ':cal g:VmAddSignToMark("' . l . '")<cr>'
endfor

" Remove all signs {{{1
sign unplace *

" Functions {{{1
" g:VmAddSignToMark(m) {{{2
" Show the marks visually on a column at the left of the screen
fu! g:VmAddSignToMark(m)
    " Create an id {{{3
    " Uppercase (A-Z) {{{4
    if char2nr(a:m) >= 65 && char2nr(a:m) <= 90
        " The id is global to all buffers like the marks using uppercase letters are global to all buffers
        let id = char2nr(a:m)
    " Lowercase (a-z) {{{4
    else
        " The id is local to the current buffer like the marks using lowercase letters and numbers are local to the current buffer
        let id = bufnr('%') . char2nr(a:m)
    endif
    " Remove sign if already added {{{3
	exe 'sign unplace ' . id
    " Define the sign {{{3
    exe 'sign define ' . a:m . ' text=' . a:m . ' texthl=Search'
    " Add the sign {{{3
    exe 'sign place ' . id . ' line=' . line('.') . ' name=' . a:m . ' file=' . expand('%:p')
endfu
