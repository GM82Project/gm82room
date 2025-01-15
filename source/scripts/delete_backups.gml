//spooky scary rmdir /s /q
if (directory_exists(savedir+"autosave")) {
    if (file_exists(savedir+"autosave\gm82room lockfile")) {
        execute_program_silent("cmd /C "+qt+"rmdir "+qt+savedir+"autosave"+qt+" /s /q"+qt)
    }
}
