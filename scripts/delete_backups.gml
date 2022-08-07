if (directory_exists(dir+"autosave")) {
    if (file_exists(dir+"autosave\gm82room lockfile")) {
        execute_shell("cmd","/C "+qt+"rmdir "+qt+dir+"autosave"+qt+" /s /q"+qt)
    }
}
