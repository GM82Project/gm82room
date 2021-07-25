var f,l;

l=ds_list_create()

f=file_text_open_read(argument0) do {
    ds_list_add(l,file_text_read_string(f))
    file_text_readln(f)
} until (file_text_eof(f)) file_text_close(f)

return l
