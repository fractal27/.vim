" --- projects file

fun! EnvSetup()
		exec '!git pull'
		let l:project_type = system('cat .project_type')
		if l:project_type == 'c_makefile'
				let l:entrypoint = 'main.c*'
		elseif l:project_type == 'c_cmake'
				let l:entrypoint = 'main.c*'
		elseif l:project_type == 'python'
				let l:entrypoint = '__main__.py'
		else
				let l:entrypoint = '.'
		endif

		exec 'e '.l:entrypoint
endfun

fun! UserInput(prompt)
		let curline = getline('.')
		call inputsave()
		let result = input(a:prompt)
		call inputrestore()
		return result
endfun

fun! Makeproj(project_type)
		if a:project_type != "c_automake" && a:project_type != "c_makefile" && a:project_type != "c_cmake" && a:project_type != "python"
				echoerr 'Project type not found:'.a:type
				return
		endif

		let l:project_name = UserInput('project name: ')
		exec '!mkdir '..g:project_directory..'/'..l:project_name
		exec 'cd '..g:project_directory..'/'..l:project_name
		exec '!echo '.a:project_type.'.project_type'

		if a:project_type == 'c_makefile'
				let l:entrypoint = 'main.c'
		elseif a:project_type == 'c_cmake'
				let l:entrypoint = 'main.c'
		elseif a:project_type == 'python'
				let l:entrypoint = '__main__.py'
		endif
		exec 'e '.l:entrypoint
		startinsert
endfun


fun! ProjectMenu()
		silent! source $VIMRUNTIME/menu.vim
		aunmenu *

		exec 'noremenu &New.&c-makefile <Esc>:call Makeproj("c_makefile")'
		exec 'noremenu &New.&c-automake <Esc>:call Makeproj("c_automake")'
		exec 'noremenu &New.&c-cmake    <Esc>:call Makeproj("c_cmake")'
		exec 'noremenu &New.&python     <Esc>:call Makeproj("python")'

		for project in split(system('ls --color=never -1 '.g:project_directory),'\n')
				let l:enviroment_setup	= '&'.."'".l:project."'.&Enviroment"
				let l:build_menu 		= '&'.."'".l:project."'.&Build"
				let l:reinstall_menu	= '&'.."'".l:project."'.&Reinstall"
				let l:project_path		= g:project_directory.'/'.project
				" noremenu &Project.&Build :echo<cr>
				" noremenu &Project.&Reinstall :echo<cr>
				exec 'noremenu '.l:enviroment_setup.' <Esc>:cd '..l:project_path..'<CR>:call EnvSetup()<CR><CR>'
				exec 'noremenu '.l:build_menu.' <Esc>:make -C '..l:project_path..'<CR><CR'
				exec 'noremenu '.l:reinstall_menu.' <Esc>:make install -C '..l:project_path..'<CR><CR>'
		endfor

		" let s:menu_vimscript = function(menu#Sid() . 'ParseMenuVimScript')('n')
		Menu
endfun

fun! FindReplace()
	let l:to_find = input("find:")
	let l:to_replace = input("replace:")
	exec ':%s/'..l:to_find..'/'..l:to_replace..'/g'
endfun

