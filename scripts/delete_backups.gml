//spooky scary rmdir /s /q
if (directory_exists(dir+"autosave")) {
    if (file_exists(dir+"autosave\gm82room lockfile")) {
        execute_program_silent("cmd /C "+qt+"rmdir "+qt+dir+"autosave"+qt+" /s /q"+qt)
    }
}
