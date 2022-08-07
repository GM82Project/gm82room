//remove any unused code files from the room folder on save
for (f=file_find_first(dir+"*.gml",0);f!="";f=file_find_next()) {
    file_delete(dir+f)
} file_find_close()
