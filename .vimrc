" просматриваем ман-страницы в отдельном окне vim'a с подсвечиванием и т.п.
" Эта директива должна быть в начале файла .vimrc, иначе она перезапишет
" остальные настройки.
"-------------------------------------------------------------------------
" :Man man
"-------------------------------------------------------------------------
" Local mappings:
" CTRL-] Jump to the manual page for the word under the cursor.
" CTRL-T Jump back to the previous manual page.
"
:runtime! ftplugin/man.vim
:runtime! archlinux.vim

set history=50                          "сохранять 50 строк в истории командной строки
set ruler                               "постоянно показывать позицию курсора
set showcmd                             "показывать незавершенные команды
set incsearch                           "показывать первое совпадение при наборе шаблона
set mouse=a                             "используем мышку
set autoindent
set smartindent
set nu                                  "показывать номер строки
set ai                                  "при начале новой строки, отступ копируется из предыдущей
set ignorecase                          "игнорируем регистр символов при поиске
set background=dark                     "фон терминала - темный
set ttyfast                             "коннект с терминалом быстрый
set visualbell                          "мигаем вместо писка
set showmatch                           "показываем соответствующие скобки
set shortmess+=tToOI                    "убираем заставку при старте
set rulerformat=%{strftime(\"%H:%M\ \")}%(%l,%c\ %p%%%) "формат строки состояния
set wrap                                "не разрывать строку
set linebreak                           "разрываем строку только между словами
set tabstop=4                           "размер табуляции
set softtabstop=0
set shiftwidth=4                        "число пробелов, используемых при автоотступе
"set expandtab                           "Заменяем табуляции пробелами (use :retab dude)
set t_Co=256                            "включаем поддержку 256 цветов
"set wildmenu                            "красивое автодополнение
set wcm=<Tab>                           "?
set makeprg=make                        "программа для сборки - make
set whichwrap=<,>,[,],h,l               "не останавливаться курсору на конце строки
set autowrite                           "автоматом записывать изменения в файл при переходе
                                    "к другому файлу
set encoding=utf8
set termencoding=utf8                   "Кодировка вывода на терминал
set fileencodings=utf8,cp1251,koi8r     "Возможные кодировки файлов
set showcmd showmode                    "показывать незавершенные команды
set splitbelow                          "новое окно появляется снизу
set autochdir                           "текущий каталог всегда совпадает с содержимым активного окна
"set stal=2                              "постоянно выводим строку с табами
set tpm=100                             "максимальное количество открытых табов
set wak=yes                             "используем ALT как обычно, а не для вызова пункта мени
set ar                                  "перечитываем файл, если он изменился извне
set dir=~/.vim/swapfiles                "каталог для сохранения своп-файлов
set noex                                "не читаем файл конфигурации из текущей директории
set ssop+=resize                        "сохраняем в сессии размер окон Vim'а
set complete+=""                        "настраиваем complete options
set complete+=.
set complete+=w
set complete+=b
set complete+=u
set complete+=i
set complete+=t
set completeopt=menuone,longest         "показываем меню автодополнения, если есть только одно автодополнение
set list                                "Отображаем табуляции и начальные пробелы
set listchars=tab:⋅⋅,trail:⋅,nbsp:⋅

if has ("gui_running")
"если запущен GUI интерфейс:
"распахиваем окно на весь экран
"set lines=99999 columns=99999
"убираем меню и тулбар
set guioptions-=m
set guioptions-=T
"убираем скроллбары
set guioptions-=r
set guioptions-=l
"используем консольные диалоги вместо графических
set guioptions+=c
"антиалиасинг для шревтоф
set antialias
"прячем курсор
set mousehide
"Так не выводятся ненужные escape последовательности в :shell
set noguipty

colorscheme darkspectrum "используем эту цветовую схему
endif

"Don't use Ex mode, use Q for formatting
map Q gq

syntax on                               "включаем подсветку синтаксиса

filetype plugin indent on               "включаем автообнаружение типа файла

"autocmd FileType text setlocal textwidth=80 "устанавливаем ширину в 80 знаков для текстовых файлов
"au FileType c,cc,cpp,h,hpp au BufWinEnter * let w:m1=matchadd('ErrorMsg', '\%>80v.\+', -1) "Подсвечиваем 81 символ и т.д.

"При редактировании файла всегда переходить на последнюю известную
"позицию курсора. Если позиция ошибочная - не переходим.
autocmd BufReadPost *
\ if line("'\"") > 0 && line("'\"") <= line("$") |
\   exe "normal! g`\"" |
\ endif

autocmd CursorMovedI * if pumvisible() == 0|pclose|endif     " Автоматически открывать и закрывать
autocmd InsertLeave * if pumvisible() == 0|pclose|endif      " всплывающие меню и предыдущие окна

" Несколько удобных биндингов для С\С++
au FileType c,cc,cpp,h,hpp inoremap { {<CR>}<Esc>O
au FileType c,cc,cpp,h,hpp inoremap #m int main(int argc, char * argv[]) {<CR>return 0;<CR>}<CR><Esc>2kO
au FileType c,cc,cpp,h,hpp inoremap #d #define 
au FileType c,cc,cpp,h,hpp inoremap #e #endif /*  */<Esc>hhi
au FileType c,cc,cpp,h,hpp inoremap #" #include ""<Esc>i
au FileType c,cc,cpp,h,hpp inoremap #< #include <><Esc>i
au FileType c,cc,cpp,h,hpp inoremap #f /* FIXME:  */<Esc>hhi
au FileType c,cc,cpp,h,hpp inoremap #t /*TODO:  */<Esc>hhi

let &errorformat="%f:%l:%c: %t%*[^:]:%m,%f:%l: %t%*[^:]:%m," . &errorformat " формат строки с ошибкой для gcc

"----------------------------------------------------------------------------------------------"
"                                      KEY BINDINGS                                            "
"----------------------------------------------------------------------------------------------"

" Close sth without saving 
" map <Esc><Esc> :q!<CR>

" Auto adding by Tab (use Shift-TAB unstead)
" imap <Tab> <C-N>

" Открытие\закрытие новой вкладки
"imap <C-t> <Esc>:tabnew<CR>a
"nmap <C-t> :tabnew<CR>
imap <C-t> <Esc>:vne<CR>a
nmap <C-t> :vne<CR>

" Изменение размера вкладки
imap <F5> <Esc><C-w>>
nmap <F5> <C-w>>
imap <F6> <Esc><C-w><
nmap <F6> <C-w><
imap <C-e> <Esc>$i
nmap <C-e> $
" Перемещение между вкладками
imap <F2> <Esc><C-w>wi
nmap <F2> <C-w>w

" сохранить сессию в указанный файл
map <C-k> :mksession! ~/.vim/lastSession.vim<CR>
" восстановить ее из файла
map <C-l> :source ~/.vim/lastSession.vim<CR>

" Так получим более полную информацию
map <C-g> g<C-g>

" показать\спрятать номера строк
imap <C-c>n <Esc>:set<Space>nu!<CR>a
nmap <C-c>n :set<Space>nu!<CR>

" Выводим красиво оформленную man-страницу прямо в Vim
" в отдельном окне (см. начало этого файла)
nmap <S-k> :exe ":Man " expand("<cword>")<CR>

" Compile program using Makefile
au FileType c,cc,cpp,h,hpp,s imap <C-c>m <Esc>:make!<CR>a
au FileType c,cc,cpp,h,hpp,s nmap <C-c>m :make!<CR>

" List of errors
imap <C-c>l <Esc>:copen<CR>
nmap <C-c>l :copen<CR>
