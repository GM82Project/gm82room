///file_text_read_list(filename,map,keep empty)
var f,l,str,i;

l=ds_list_create()

if (file_exists(argument0)) {
    i=0
    f=file_text_open_read_safe(argument0) if (f) do {
        str=file_text_read_string(f)
        file_text_readln(f)
        if (str!="" || argument2) ds_list_add(l,str)
        if (str!="" && argument1!=noone) ds_map_add(argument1,str,i)
        i+=1
    } until (file_text_eof(f)) file_text_close(f)
}

return l
