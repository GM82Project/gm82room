//spooky scary rmdir /s /q
if (directory_exists(dir+"autosave")) {
    if (file_exists(dir+"autosave\gm82room lockfile")) {
        execute_program_silent("cmd /C "+qt+"rmdir "+qt+dir+"autosave"+qt+" /s /q"+qt)
    }
}

for (f=file_find_first(dir+"*.gml",0);f!="";f=file_find_next()) {
    file_delete(dir+f)
} file_find_close()
for (f=file_find_first(dir+"*.txt",0);f!="";f=file_find_next()) {
    file_delete(dir+f)
} file_find_close()
