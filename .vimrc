syntax on

set expandtab shiftwidth=2 tabstop=2 smarttab

"from http://vim.wikia.com/wiki/Highlight_unwanted_spaces
:highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
:match ExtraWhitespace /\s\+$/
:autocmd ColorScheme * highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen

set laststatus=2
set noshowmode
set t_Co=256
