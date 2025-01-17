" Key mappings
"
" My personal mappings for various commands and key combinations

" Write files as the root user
" This command will automatically reload the file if the sudo-write was
" successfull - Which is nice as it avoids the reload prompt.
command SudoWrite
  \ :execute ':silent write !sudo tee % > /dev/null'<Bar>
  \ :execute v:shell_error == 0 ? ':edit!' : ''

" Smart save: Attempt to use SudoWrite if the file isn't writeable
nnoremap <expr> <C-s>
  \ expand('%') != '' && !filewritable(expand('%')) ?
  \ ':SudoWrite<CR>' : ':write<CR>'

" Remap Ctrl+C to be the same as escape without telling us to use :q to quit
nnoremap  <C-c> <NOP>
nnoremap r<C-c> <NOP>

" Disable EX mode
map Q <Nop>

""" Buffer Managment
nnoremap <silent>       <Tab>   :bnext<CR>
nnoremap <silent>       <S-Tab> :bprev<CR>
nnoremap <silent><expr> <C-q>   ':confirm '.(NoBuffersOpen() ? 'quit' : 'bdelete').'<CR>'

""" Tabularizatins
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a> :Tabularize /=><CR>
vmap <Leader>a> :Tabularize /=><CR>
nmap <Leader>a: :Tabularize /:\zs<CR>
vmap <Leader>a: :Tabularize /:\zs<CR>

" Don't move on *
nnoremap <silent> *
  \ :let stay_star_view = winsaveview()<CR>*
  \ :call winrestview(stay_star_view)<CR>

" Search for selected text
vnoremap <silent> * :<C-U>
 \ let old_reg = getreg('"')<Bar>
 \ let old_regtype = getregtype('"')<Bar>
 \ let stay_star_view = winsaveview()<CR>
 \ gvy/<C-R><C-R>=substitute(
 \ escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
 \ gV:call setreg('"', old_reg, old_regtype)<CR>
 \ :call winrestview(stay_star_view)<CR>

" Source line and selection in vim
vnoremap <leader>S y:execute @@<CR>:echo 'Sourced selection'<CR>
nnoremap <leader>S ^vg_y:execute @@<CR>:echo 'Sourced line'<CR>

" Repeat the lmast executed macro
nnoremap , @@
