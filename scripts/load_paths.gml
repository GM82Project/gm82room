var f,f2,str,path,closed,precision,smooth;
var p,i,l,d,px,py,dx,dy,opx,opy,odx,ody;

path_indexsize=0

f=file_text_open_read_safe(root+"paths\index.yyd") if (f) {do {pathname=file_text_read_string(f) file_text_readln(f) path_indexsize+=1 if (pathname!="") {
    f2=file_text_open_read_safe(root+"paths\"+pathname+"\path.txt") if (f2) {
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
            paths[pathnum,3]=model
            paths[pathnum,4]=false //new to this session
            paths[pathnum,5]=false //modified
            path_set_closed(path,closed)
            path_set_precision(path,precision)
            path_set_kind(path,smooth)
            f2=file_text_open_read_safe(root+"paths\"+pathname+"\points.txt") if (f2) do {str=file_text_read_string(f2) file_text_readln(f2)
                string_token_start(str,",")
                path_add_point(path,real(string_token_next()),real(string_token_next()),real(string_token_next()))
            } until (file_text_eof(f2)) file_text_close(f2)

            generate_path_model(pathnum)

            pathnum+=1
        }}
    }
} until (file_text_eof(f)) file_text_close(f)}
