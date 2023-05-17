var map,fn,key,str,f;

map=argument0
fn=argument1

str=""

key=ds_map_find_first(map)
repeat (ds_map_size(map)) {
    str+=key+"="+string(ds_map_find_value(map,key))+crlf
key=ds_map_find_next(map,key)}

file_text_write_all(fn,str)
