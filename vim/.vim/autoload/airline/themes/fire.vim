" Color palette
let s:gui_dark_gray = '#1c1c1c'
let s:cterm_dark_gray = 234
let s:gui_med_gray = '#3E515A'
let s:cterm_med_gray = 8
let s:gui_light_gray = '#AAAAAA'
let s:cterm_light_gray = 7
let s:gui_yellow = '#BFBF60'
let s:cterm_yellow = 11
let s:gui_blue = '#87afd7'
let s:cterm_blue = 12
let s:gui_purple = '#A360BF'
let s:cterm_purple = 13
let s:gui_orange = '#BF8660'
let s:cterm_orange = 9
let s:gui_red = '#C06960'
let s:cterm_red = 1
let g:airline#themes#fire#palette = {}

" Normal mode
let s:N1 = [s:gui_dark_gray, s:gui_blue, s:cterm_dark_gray, s:cterm_blue]
let s:N2 = [s:gui_blue, s:gui_dark_gray, s:cterm_blue, s:cterm_dark_gray]
let s:N3 = [s:gui_blue, s:gui_med_gray, s:cterm_blue, s:cterm_med_gray]
let g:airline#themes#fire#palette.normal = airline#themes#generate_color_map(s:N1, s:N2, s:N3)
let g:airline#themes#fire#palette.normal_modified = {
      \ 'airline_c': [s:gui_orange, s:gui_med_gray, s:cterm_orange, s:cterm_med_gray, ''],
      \ }

" Insert mode
let s:I1 = [s:gui_dark_gray, s:gui_yellow, s:cterm_dark_gray, s:cterm_yellow]
let s:I2 = [s:gui_yellow, s:gui_dark_gray, s:cterm_yellow, s:cterm_dark_gray]
let s:I3 = [s:gui_yellow, s:gui_med_gray, s:cterm_yellow, s:cterm_med_gray]
let g:airline#themes#fire#palette.insert = airline#themes#generate_color_map(s:I1, s:I2, s:I3)
let g:airline#themes#fire#palette.insert_modified = copy(g:airline#themes#fire#palette.normal_modified)
let g:airline#themes#fire#palette.insert_paste = {
      \ 'airline_a': [s:gui_dark_gray, s:gui_orange, s:cterm_dark_gray, s:cterm_orange, ''],
      \ }

" Replace mode
let s:R1 = [s:gui_dark_gray, s:gui_red, s:cterm_dark_gray, s:cterm_red]
let s:R2 = [s:gui_red, s:gui_dark_gray, s:cterm_red, s:cterm_dark_gray]
let s:R3 = [s:gui_red, s:gui_med_gray, s:cterm_red, s:cterm_med_gray]
let g:airline#themes#fire#palette.replace = airline#themes#generate_color_map(s:R1, s:R2, s:R3)
let g:airline#themes#fire#palette.replace_modified = copy(g:airline#themes#fire#palette.insert_modified)

" Visual mode
let s:V1 = [s:gui_dark_gray, s:gui_purple, s:cterm_dark_gray, s:cterm_purple]
let s:V2 = [s:gui_purple, s:gui_dark_gray, s:cterm_purple, s:cterm_dark_gray]
let s:V3 = [s:gui_purple, s:gui_med_gray, s:cterm_purple, s:cterm_med_gray]
let g:airline#themes#fire#palette.visual = airline#themes#generate_color_map(s:V1, s:V2, s:V3)
let g:airline#themes#fire#palette.visual_modified = copy(g:airline#themes#fire#palette.insert_modified)

" Inactive window
let s:IA = [s:gui_light_gray, s:gui_med_gray, s:cterm_light_gray, s:cterm_med_gray, '']
let g:airline#themes#fire#palette.inactive = airline#themes#generate_color_map(s:IA, s:IA, s:IA)
let g:airline#themes#fire#palette.inactive_modified = {
      \ 'airline_c': [s:gui_orange, '', s:cterm_orange, '', ''],
      \ }

" CtrlP
if !get(g:, 'loaded_ctrlp', 0)
  finish
endif
let g:airline#themes#fire#palette.ctrlp = airline#extensions#ctrlp#generate_color_map(
      \ [ s:gui_orange, s:gui_med_gray, s:cterm_orange, s:cterm_med_gray, '' ] ,
      \ [ s:gui_orange, s:gui_med_gray, s:cterm_orange, s:cterm_med_gray, '' ] ,
      \ [ s:gui_dark_gray, s:gui_yellow, s:cterm_dark_gray, s:cterm_yellow, 'bold' ] )
