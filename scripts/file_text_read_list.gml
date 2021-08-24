var f,l,str;

l=ds_list_create()

if (file_exists(argument0)) {
    f=file_text_open_read_safe(argument0) if (f) do {
        str=file_text_read_string(f)
        file_text_readln(f)
        if (str!="") {
            ds_list_add(l,str)
        }
    } until (file_text_eof(f)) file_text_close(f)
}

return l
