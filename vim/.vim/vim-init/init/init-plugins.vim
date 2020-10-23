"======================================================================
"
" init-plugins.vim - 
"
" Created by skywind on 2018/05/31
" Last Modified: 2018/06/10 23:11
"
"======================================================================
" vim: set ts=4 sw=4 tw=78 noet :



"----------------------------------------------------------------------
" 默认情况下的分组，可以再前面覆盖之
"----------------------------------------------------------------------
if !exists('g:bundles')
	
	" let g:bundles = ['ycm']
	" let g:bundles += ['ale']
	" let g:bundles = ['neomake']
	let g:bundles = ['airline']
	let g:bundles += ['cppenhanced']
	" let g:bundles += ['echodoc']
	let g:bundles += ['clang-format']
	let g:bundles += ['gutentags']
	let g:bundles += ['LeaderF']
	let g:bundles += ['coc']
	let g:bundles += ['vim-go']
endif
"----------------------------------------------------------------------
" 计算当前 vim-init 的子路径
"----------------------------------------------------------------------
let s:home = fnamemodify(resolve(expand('<sfile>:p')), ':h:h')

function! s:path(path)
	let path = expand(s:home . '/' . a:path )
	return substitute(path, '\\', '/', 'g')
endfunc


"----------------------------------------------------------------------
" 在 ~/.vim/bundles 下安装插件
"----------------------------------------------------------------------
call plug#begin(get(g:, 'bundle_home', '~/.vim/bundles'))

" coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"auto complete {} () ... 
Plug 'Raimondi/delimitMate'

"ale
"Plug 'w0rp/ale'

"写C / C ++时函数忘了可以用上面的YCM补全，若是参数忘记了则可以使用echodoc插件。当用YCM的选项卡补全了一个函数名后，只要输入左括号，下面命令行就会显示出该函数的参数信息，并通过光标移动高亮出当前参数位置。
" Plug 'Shougo/echodoc.vim'

" Plug 'neomake/neomake'

" C++ 语法高亮增强，支持 11/14/17 标准
Plug 'octol/vim-cpp-enhanced-highlight', { 'for': ['c', 'cpp'] }


" 额外语法文件
Plug 'justinmk/vim-syntax-extra', { 'for': ['c', 'bison', 'flex', 'cpp'] }

" python 语法文件增强
" Plug 'vim-python/python-syntax', { 'for': ['python'] }

" go fmt支持
Plug 'fatih/vim-go'

Plug 'rhysd/vim-clang-format'

Plug 'mhinz/vim-signify'

" gutentags 自动索引
Plug 'ludovicchabant/vim-gutentags'
Plug 'skywind3000/gutentags_plus'

" LeaderF
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }

call plug#end()
"--------------------------------------------------------------------
" coc配置项
"--------------------------------------------------------------------
if index(g:bundles, 'coc') >= 0
	" TextEdit might fail if hidden is not set.
	set hidden

	" Some servers have issues with backup files, see #649.
	set nobackup
	set nowritebackup

	" Give more space for displaying messages.
	set cmdheight=2

	" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
	" delays and poor user experience.
	set updatetime=300

	" Don't pass messages to |ins-completion-menu|.
	set shortmess+=c

	" Always show the signcolumn, otherwise it would shift the text each time
	" diagnostics appear/become resolved.
	set signcolumn=yes

	" Use tab for trigger completion with characters ahead and navigate.
	" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
	" other plugin before putting this into your config.
	inoremap <silent><expr> <TAB>
		\ pumvisible() ? "\<C-n>" :
		\ <SID>check_back_space() ? "\<TAB>" :
		\ coc#refresh()
	inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

	function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
	endfunction

	" Use <c-space> to trigger completion.
	inoremap <silent><expr> <c-space> coc#refresh()

	" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
	" position. Coc only does snippet and additional edit on confirm.
	if exists('*complete_info')
	inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
	else
	imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
	endif

	" Use `[g` and `]g` to navigate diagnostics
	nmap <silent> [g <Plug>(coc-diagnostic-prev)
	nmap <silent> ]g <Plug>(coc-diagnostic-next)

	" GoTo code navigation.
	nmap <silent> gd <Plug>(coc-definition)
	nmap <silent> gy <Plug>(coc-type-definition)
	nmap <silent> gi <Plug>(coc-implementation)
	nmap <silent> gr <Plug>(coc-references)

	" Use K to show documentation in preview window.
	nnoremap <silent> K :call <SID>show_documentation()<CR>

	function! s:show_documentation()
	if (index(['vim','help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	else
		call CocAction('doHover')
	endif
	endfunction

	" Highlight the symbol and its references when holding the cursor.
	autocmd CursorHold * silent call CocActionAsync('highlight')

	" Symbol renaming.
	nmap <leader>rn <Plug>(coc-rename)

	" Formatting selected code.
	xmap <leader>f  <Plug>(coc-format-selected)
	nmap <leader>f  <Plug>(coc-format-selected)

	augroup mygroup
	autocmd!
	" Setup formatexpr specified filetype(s).
	autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
	" Update signature help on jump placeholder.
	autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
	augroup end

	" Applying codeAction to the selected region.
	" Example: `<leader>aap` for current paragraph
	xmap <leader>a  <Plug>(coc-codeaction-selected)
	nmap <leader>a  <Plug>(coc-codeaction-selected)

	" Remap keys for applying codeAction to the current line.
	nmap <leader>ac  <Plug>(coc-codeaction)
	" Apply AutoFix to problem on the current line.
	nmap <leader>qf  <Plug>(coc-fix-current)

	" Introduce function text object
	" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
	xmap if <Plug>(coc-funcobj-i)
	xmap af <Plug>(coc-funcobj-a)
	omap if <Plug>(coc-funcobj-i)
	omap af <Plug>(coc-funcobj-a)

	" Use <TAB> for selections ranges.
	" NOTE: Requires 'textDocument/selectionRange' support from the language server.
	" coc-tsserver, coc-python are the examples of servers that support it.
	nmap <silent> <TAB> <Plug>(coc-range-select)
	xmap <silent> <TAB> <Plug>(coc-range-select)

	" Add `:Format` command to format current buffer.
	command! -nargs=0 Format :call CocAction('format')

	" Add `:Fold` command to fold current buffer.
	command! -nargs=? Fold :call     CocAction('fold', <f-args>)

	" Add `:OR` command for organize imports of the current buffer.
	command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

	" Add (Neo)Vim's native statusline support.
	" NOTE: Please see `:h coc-status` for integrations with external plugins that
	" provide custom statusline: lightline.vim, vim-airline.
	set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

	" Mappings using CoCList:
	" Show all diagnostics.
	nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
	" Manage extensions.
	nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
	" Show commands.
	nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
	" Find symbol of current document.
	nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
	" Search workspace symbols.
	nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
	" Do default action for next item.
	nnoremap <silent> <space>j  :<C-u>CocNext<CR>
	" Do default action for previous item.
	nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
	" Resume latest coc list.
	nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
endif

"--------------------------------------------------------------------
" vim-cpp-enhanced-highlight配置项
"--------------------------------------------------------------------
if index(g:bundles, 'cppenhanced') >= 0
	let c_no_curly_error = 1
endif

"--------------------------------------------------------------------
" ariline配置项
"--------------------------------------------------------------------
"
if index(g:bundles, 'airline') >= 0
	let g:airline_left_sep = ''
	let g:airline_left_alt_sep = ''
	let g:airline_right_sep = ''
	let g:airline_right_alt_sep = ''
	let g:airline_powerline_fonts = 0
	let g:airline_exclude_preview = 1
	let g:airline_section_b = '%n'
	let g:airline_theme='deus'
	let g:airline#extensions#branch#enabled = 0
	let g:airline#extensions#syntastic#enabled = 0
	let g:airline#extensions#fugitiveline#enabled = 0
	let g:airline#extensions#csv#enabled = 0
	let g:airline#extensions#vimagit#enabled = 0
	if index(g:bundles, 'coc') >= 0
        " enable/disable coc integration
        let g:airline#extensions#coc#enabled = 1
    
        " change error symbol:  
        let airline#extensions#coc#error_symbol = 'E:'
    
        " change warning symbol:
        let airline#extensions#coc#warning_symbol = 'W:'
    
        " change error format:
        let airline#extensions#coc#stl_format_err = '%E{[%e(#%fe)]}'
                                                    
        " change warning format:                      
        let airline#extensions#coc#stl_format_warn = '%W{[%w(#%fw)]}'
    endif
endif
"--------------------------------------------------------------------
" neomake配置项
"--------------------------------------------------------------------
"	
if index(g:bundles, 'neomake') >= 0
	function! MyOnBattery()
		if has('macunix')
			return match(system('pmset -g batt'), "Now drawing from 'Battery Power'") != -1
		elseif has('unix')
			return readfile('/sys/class/power_supply/AC/online') == ['0']
		endif
		return 0
	endfunction

	if MyOnBattery()
		call neomake#configure#automake('w')
	else
		call neomake#configure#automake('nw', 1000)
		endif
endif
"--------------------------------------------------------------------
" echodoc配置项
"--------------------------------------------------------------------
"	
if index(g:bundles, 'echodoc') >= 0
	" Or, you could disable showmode alltogether.
	set noshowmode
	let g:echodoc_enable_at_startup = 1
endif

"--------------------------------------------------------------------
" LeaderF配置项
"--------------------------------------------------------------------
"	
if index(g:bundles, 'LeaderF') >= 0
    let g:Lf_GtagsAutoGenerate = 0
    let g:Lf_PreviewInPopup = 1
    " CTRL+p 打开文件模糊匹配
    let g:Lf_ShortcutF = '<C-P>'
    
    " 最大历史文件保存 2048 个
    let g:Lf_MruMaxFiles = 2048
    
    let g:Lf_RootMarkers = ['.project', '.root', '.svn', '.git']
    let g:Lf_WorkingDirectoryMode = 'Ac'
    let g:Lf_WindowHeight = 0.30
    let g:Lf_CacheDirectory = expand('~/.vim/cache')
    
    " 显示绝对路径
    let g:Lf_ShowRelativePath = 0

    " 隐藏帮助
    let g:Lf_HideHelp = 1
    
    " 模糊匹配忽略扩展名
    let g:Lf_WildIgnore = {
                \ 'dir': ['.svn','.git','.hg'],
                \ 'file': ['*.sw?','~$*','*.bak','*.exe','*.o','*.so','*.py[co]']
                \ }

    " MRU 文件忽略扩展名
    let g:Lf_MruFileExclude = ['*.so', '*.exe', '*.py[co]', '*.sw?', '~$*', '*.bak', '*.tmp', '*.dll']
    
    let g:Lf_StlColorscheme = 'powerline'

    " 禁用 function/buftag 的预览功能，可以手动用 p 预览
    let g:Lf_PreviewResult = {'Function':0, 'BufTag':0}
endif
"--------------------------------------------------------------------
" gutentags
"--------------------------------------------------------------------
"	
if index(g:bundles, 'gutentags') >= 0

    " gutentags 搜索工程目录的标志，当前文件路径向上递归直到碰到这些文件/目录名
    let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']

    " 所生成的数据文件的名称
    let g:gutentags_ctags_tagfile = '.tags'

    " 同时开启 ctags 和 gtags 支持：
    let g:gutentags_modules = []
    if executable('ctags')
        let g:gutentags_modules += ['ctags']
    endif
    if executable('gtags-cscope') && executable('gtags')
        let g:gutentags_modules += ['gtags_cscope']
    endif

    " 将自动生成的 ctags/gtags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
    let g:gutentags_cache_dir = expand('~/.cache/tags')

    " 配置 ctags 的参数，老的 Exuberant-ctags 不能有 --extra=+q，注意
    let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
    let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
    let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

    " 如果使用 universal ctags 需要增加下面一行，老的 Exuberant-ctags 不能加下一行
    let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']

    " 禁用 gutentags 自动加载 gtags 数据库的行为
    let g:gutentags_auto_add_gtags_cscope = 0
endif
"----------------------------------------------------------------------
" ale配置项
"----------------------------------------------------------------------
if index(g:bundles, 'ale') >= 0
	" 设定延迟和提示信息
	let g:ale_completion_delay = 500
	let g:ale_echo_delay = 20
	let g:ale_lint_delay = 500
	let g:ale_echo_msg_format = '[%linter%] %code: %%s'
	
	" 允许 airline 集成
	let g:airline#extensions#ale#enabled = 1
	
	let g:ale_sign_error = '>>'
	let g:ale_sign_warning = '>'
	
	" 设定检测的时机：normal 模式文字改变，或者离开 insert模式
	" 禁用默认 INSERT 模式下改变文字也触发的设置，太频繁外，还会让补全窗闪烁
	let g:ale_lint_on_text_changed = 'normal'
	let g:ale_lint_on_insert_leave = 1
	
	"始终开启标志列
	let g:ale_sig_column_always = 1
	let g:ale_set_highlights = 1
	

	" 编辑不同文件类型需要的语法检查器
	let g:ale_linters = {
				\ 'c': ['gcc',], 
				\ 'cpp': ['gcc',], 
				\ 'python': ['flake8', 'pylint'], 
				\ 'java': ['javac'],
				\ }


	let g:ale_c_gcc_options = '-Wall -O2 -std=c11'
	let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++14'
	let g:ale_c_cppcheck_options = ''
	let g:ale_cpp_cppcheck_options = ''

endif
"----------------------------------------------------------------------
" clang-format配置项
"----------------------------------------------------------------------
if index(g:bundles, 'clang-format') >= 0
	let g:clang_format#command = 'clang-format'
	"nmap <F4> :ClangFormat<cr>
	autocmd FileType c ClangFormatAutoEnable
	let g:clang_format#detect_style_file = 0

	let g:clang_format#style_options = {
			\ "Language" : "Cpp",
			\ "BasedOnStyle" : "Google",
			\ "AccessModifierOffset" : -1,
			\ "AlignConsecutiveMacros " : "true",
			\ "AlignEscapedNewlinesLeft" : "true",
			\ "AlignOperands" : "true",
			\ "AlignTrailingComments" : "true",
			\ "AllowAllParametersOfDeclarationOnNextLine" : "true",
			\ "AllowShortBlocksOnASingleLine" : "false",
			\ "AllowShortCaseLabelsOnASingleLine" : "false",
			\ "AllowShortIfStatementsOnASingleLine" : "true",
			\ "AllowShortLoopsOnASingleLine" : "true",
			\ "AllowShortFunctionsOnASingleLine" : "All",
			\ "AlwaysBreakAfterDefinitionReturnType" : "false",
			\ "AlwaysBreakTemplateDeclarations" : "true",
			\ "AlwaysBreakBeforeMultilineStrings" : "true",
			\ "BreakBeforeBinaryOperators" : "None",
			\ "BreakBeforeTernaryOperators" : "true",
			\ "BreakConstructorInitializersBeforeComma" : "false",
			\ "BinPackParameters" : "true",
			\ "BinPackArguments" : "true",
			\ "ColumnLimit" : 80,
			\ "ConstructorInitializerAllOnOneLineOrOnePerLine" : "true",
			\ "ConstructorInitializerIndentWidth" : 4,
			\ "DerivePointerAlignment" : "true",
			\ "ExperimentalAutoDetectBinPacking" : "false",
			\ "IndentCaseLabels" : "true",
			\ "IndentWrappedFunctionNames" : "false",
			\ "IndentFunctionDeclarationAfterType" : "false",
			\ "MaxEmptyLinesToKeep" : 1,
			\ "KeepEmptyLinesAtTheStartOfBlocks" : "false",
			\ "NamespaceIndentation" : "None",
			\ "ObjCBlockIndentWidth" : 4,
			\ "ObjCSpaceAfterProperty" : "false",
			\ "ObjCSpaceBeforeProtocolList" : "false",
			\ "PenaltyBreakBeforeFirstCallParameter" : 1,
			\ "PenaltyBreakComment" : 300,
			\ "PenaltyBreakString" : 1000,
			\ "PenaltyBreakFirstLessLess" : 120,
			\ "PenaltyExcessCharacter" : 1000000,
			\ "PenaltyReturnTypeOnItsOwnLine" : 200,
			\ "PointerAlignment" : "Left",
			\ "SpacesBeforeTrailingComments" : 4,
			\ "Cpp11BracedListStyle" : "true",
			\ "Standard" : "Auto",
			\ "IndentWidth" : 4,
			\ "TabWidth" : 4,
			\ "UseTab" : "Always",
			\ "BreakBeforeBraces" : "Attach",
			\ "SpacesInParentheses" : "false",
			\ "SpacesInSquareBrackets" : "false",
			\ "SpacesInAngles" : "false",
			\ "SpaceInEmptyParentheses" : "false",
			\ "SpacesInCStyleCastParentheses" : "false",
			\ "SpaceAfterCStyleCast" : "false",
			\ "SpacesInContainerLiterals" : "true",
			\ "SpaceBeforeAssignmentOperators" : "true",
			\ "ContinuationIndentWidth" : 4 }
endif
"----------------------------------------------------------------------
" YouCompleteMe 默认设置：YCM 需要你另外手动编译安装
"----------------------------------------------------------------------
if index(g:bundles, 'ycm') >= 0
	let g:ycm_global_ycm_extra_conf = '/home/andy/.ycm_extra_conf.py'
	let g:ycm_server_python_interpreter='/usr/bin/python3'
	" 启用预览功能
	let g:ycm_add_preview_to_completeopt = 0


	" 禁用诊断功能：我们用前面更好用的 ALE 代替
	let g:ycm_show_diagnostics_ui = 0

	let g:ycm_min_num_identifier_candidate_chars = 2
	let g:ycm_collect_identifiers_from_comments_and_strings = 1
	let g:ycm_complete_in_strings=1
	let g:ycm_key_invoke_completion = '<c-z>'
	set completeopt=menu,menuone,noselect

	" noremap <c-z> <NOP>

	" 两个字符自动触发语义补全
	let g:ycm_semantic_triggers =  {
			\ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
			\ 'cs,lua,javascript': ['re!\w{2}'],
			\ }


	"----------------------------------------------------------------------
	" Ycm 白名单（非名单内文件不启用 YCM），避免打开个 1MB 的 txt 分析半天
	"----------------------------------------------------------------------
	let g:ycm_filetype_whitelist = { 
			\ "c":1,
			\ "cpp":1, 
			\ "objc":1,
			\ "objcpp":1,
			\ "python":1,
			\ "java":1,
			\ "javascript":1,
			\ "coffee":1,
			\ "vim":1, 
			\ "go":1,
			\ "cs":1,
			\ "lua":1,
			\ "perl":1,
			\ "perl6":1,
			\ "php":1,
			\ "ruby":1,
			\ "rust":1,
			\ "erlang":1,
			\ "asm":1,
			\ "nasm":1,
			\ "masm":1,
			\ "tasm":1,
			\ "asm68k":1,
			\ "asmh8300":1,
			\ "asciidoc":1,
			\ "basic":1,
			\ "vb":1,
			\ "make":1,
			\ "cmake":1,
			\ "html":1,
			\ "css":1,
			\ "less":1,
			\ "json":1,
			\ "cson":1,
			\ "typedscript":1,
			\ "haskell":1,
			\ "lhaskell":1,
			\ "lisp":1,
			\ "scheme":1,
			\ "sdl":1,
			\ "sh":1,
			\ "zsh":1,
			\ "bash":1,
			\ "man":1,
			\ "markdown":1,
			\ "matlab":1,
			\ "maxima":1,
			\ "dosini":1,
			\ "conf":1,
			\ "config":1,
			\ "zimbu":1,
			\ "ps1":1,
			\ }
endif

