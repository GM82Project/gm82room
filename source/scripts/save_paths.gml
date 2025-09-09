var f,f2,f3,i,path,pathname,j,str;

if (ds_list_size(path_index_list) || has_paths || paths_have_been_deleted) {
    if (!has_paths) {
        directory_create(root+"\paths")
        ds_map_set(project,"has_paths","1")
        ds_map_save_ini(project,root+pjfile)
        has_paths=1
    }

    f=file_text_open_write(root+"paths\index.yyd")
    f3=file_text_open_write(root+"paths\tree.yyd")

    if (f && f3) {
        str=""
        i=0 repeat (ds_list_size(path_index_list)) {
            str+=ds_list_find_value(path_index_list,i)+lf
        i+=1}
        file_text_write_string(f,str)

        str=""
        i=0 repeat (ds_list_size(path_tree_list)) {
            str+=ds_list_find_value(path_tree_list,i)+lf
        i+=1}
        file_text_write_string(f3,str)

        key=ds_map_find_first(pathmap_path) repeat (ds_map_size(pathmap_path)) {if (ds_map_find_value(pathmap_edited,key)) {
            pathname=key

            directory_create(root+"paths\"+pathname)

            f2=file_text_open_write(root+"paths\"+pathname+"\path.txt") if (f2) {
                path=ds_map_find_value(pathmap_path,key)
                file_text_write_string(f2,"connection="+string(path_get_kind(path))) file_text_writelf(f2)
                file_text_write_string(f2,"closed="+string(path_get_closed(path))) file_text_writelf(f2)
                file_text_write_string(f2,"precision="+string(path_get_precision(path))) file_text_writelf(f2)
                file_text_write_string(f2,"background="+roomname) file_text_writelf(f2)
                file_text_write_string(f2,"snap_x=16") file_text_writelf(f2)
                file_text_write_string(f2,"snap_y=16") file_text_writelf(f2)
                file_text_close(f2)

                f2=file_text_open_write(root+"paths\"+pathname+"\points.txt") if (f2) {
                    j=0 repeat (path_get_number(path)) {
                        file_text_write_string(f2,str_sep(",",path_get_point_x(path,j),path_get_point_y(path,j),path_get_point_speed(path,j)))
                        file_text_writelf(f2)
                    j+=1}
                file_text_close(f2)}
            }
        } key=ds_map_find_next(pathmap_path,key)}
    file_text_close(f) file_text_close(f3)} else show_error("Failed to write path index and tree.",1)
}
