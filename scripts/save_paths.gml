var f,f2,f3,i,path,pathname,j;

f=file_text_open_append_safe(root+"paths\index.yyd")
f3=file_text_open_append_safe(root+"paths\tree.yyd")
if (f && f3) {
    i=0 repeat (pathnum) {if (paths[i,4] || paths[i,5]) {
        pathname=paths[i,1]

        if (paths[i,4]) {
            //new path, add to index and tree
            file_text_write_string(f,paths[i,1]) file_text_writeln(f)
            file_text_write_string(f3,"|"+paths[i,1]) file_text_writeln(f3)
            directory_create(root+"paths\"+pathname)
        }

        f2=file_text_open_write(root+"paths\"+pathname+"\path.txt") if (f2) {
            path=paths[i,0]
            file_text_write_string(f2,"connection="+string(path_get_kind(path))) file_text_writeln(f2)
            file_text_write_string(f2,"closed="+string(path_get_closed(path))) file_text_writeln(f2)
            file_text_write_string(f2,"precision="+string(path_get_precision(path))) file_text_writeln(f2)
            file_text_write_string(f2,"background="+roomname) file_text_writeln(f2)
            file_text_write_string(f2,"snap_x=16") file_text_writeln(f2)
            file_text_write_string(f2,"snap_y=16") file_text_writeln(f2)
            file_text_close(f2)

            f2=file_text_open_write(root+"paths\"+pathname+"\points.txt") if (f2) {
                j=0 repeat (path_get_number(path)) {
                    file_text_write_string(f2,str_sep(",",path_get_point_x(path,j),path_get_point_y(path,j),path_get_point_speed(path,j)))
                    file_text_writeln(f2)
                j+=1}
            file_text_close(f2)}
        }
    }i+=1}
file_text_close(f) file_text_close(f3)}
