///Path(name)
var f2,smooth,closed,precision,path;

//undefined field!
if (is_undefined(argument0)) return -1

//path doesn't exist!
if (!ds_list_find_index(path_index_list,argument0)) return -1

//path already loaded as project path
if (ds_map_exists(pathmap_path,argument0)) return dsmap(pathmap_path,argument0)

//path already loaded as field path
if (ds_map_exists(pathmap_fields,argument0)) return dsmap(pathmap_fields,argument0)

//sorry nothing
if (!has_paths) return -1

//load field path
f2=file_text_open_read_safe(root+"paths\"+argument0+"\path.txt") if (f2) {
    smooth=(string_delete(file_text_read_string(f2),1,11)=="1")
    file_text_readln(f2)
    closed=(string_delete(file_text_read_string(f2),1,7)=="1")
    file_text_readln(f2)
    precision=real((string_delete(file_text_read_string(f2),1,10)))
    file_text_close(f2)                            
    path=path_add()
    ds_map_add(pathmap_fields,argument0,path)
    path_set_closed(path,closed)
    path_set_precision(path,precision)
    path_set_kind(path,smooth)
    f2=file_text_open_read_safe(root+"paths\"+argument0+"\points.txt") if (f2) do {str=file_text_read_string(f2) file_text_readln(f2)
        string_token_start(str,",")
        path_add_point(path,real(string_token_next()),real(string_token_next()),real(string_token_next()))
    } until (file_text_eof(f2)) file_text_close(f2)
    
    return path
}

return -1
