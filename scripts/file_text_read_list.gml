///file_text_read_list(filename,[map])
var f,l,str,i;

l=ds_list_create()

if (file_exists(argument[0])) {
    i=0
    f=file_text_open_read_safe(argument[0]) if (f) do {
        str=file_text_read_string(f)
        file_text_readln(f)
        ds_list_add(l,str)
        if (str!="") {
            if (argument_count==2) ds_map_add(argument[1],str,i)
        }
        i+=1
    } until (file_text_eof(f)) file_text_close(f)
}

return l
