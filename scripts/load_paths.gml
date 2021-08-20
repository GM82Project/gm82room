var f,f2,str,path,closed,precision,smooth,p;

f=file_text_open_read(root+"paths\index.yyd") do {pathname=file_text_read_string(f) file_text_readln(f)
    f2=file_text_open_read(root+"paths\"+pathname+"\path.txt")
    smooth=(string_delete(file_text_read_string(f2),1,11)=="1")
    file_text_readln(f2)
    closed=(string_delete(file_text_read_string(f2),1,7)=="1")
    file_text_readln(f2)
    precision=real((string_delete(file_text_read_string(f2),1,10)))
    file_text_readln(f2)
    str=string_delete(file_text_read_string(f2),1,11)
    file_text_close(f2)
    if (str==roomname) {
        path=path_add()
        model=d3d_model_create()
        paths[pathnum,0]=path
        paths[pathnum,1]=pathname
        paths[pathnum,2]=smooth
        pathnum+=1
        path_set_closed(path,closed)
        path_set_precision(path,precision)
        path_set_kind(path,smooth)
        f2=file_text_open_read(root+"paths\"+pathname+"\points.txt") do {str=file_text_read_string(f2) file_text_readln(f2)
            string_token_start(str,",")
            path_add_point(path,real(string_token_next()),real(string_token_next()),real(string_token_next()))
        } until (file_text_eof(f2)) file_text_close(f2)
    }
} until (file_text_eof(f)) file_text_close(f)
