var h,oldpath;

if (mode==5) {
    pathfocus=""
    if (point_in_rectangle(mouse_wx,mouse_wy,0,120,160,height-328)) {
        dy=pathscroll key=ds_map_find_first(pathmap_path) repeat (ds_map_size(pathmap_path)) {
            if (mouse_wy-120==median(dy,mouse_wy-120,dy+31)) {
                pathfocus=key
            }
        dy+=32 key=ds_map_find_next(pathmap_path,key)}

        if (mouse_check_modal_pressed(mb_left)) {
            //select a different path
            dy=pathscroll key=ds_map_find_first(pathmap_path) repeat (ds_map_size(pathmap_path)) {
                if (mouse_wy-120==median(dy,mouse_wy-120,dy+31)) {
                    oldpath=current_pathname
                    current_pathname=key
                    current_path=ds_map_find_value(pathmap_path,key)
                    current_pathpoint=path_get_number(current_path)-1
                    if (oldpath!="") generate_path_model(oldpath)
                    generate_path_model(current_pathname)
                    ds_list_clear(path_sel)
                    selection=0
                    update_inspector()
                    update_selection_bounds()
                }
            dy+=32 key=ds_map_find_next(pathmap_path,key)}

            if (mouse_wy-120==median(dy,mouse_wy-120,dy+31)) {
                //create a new path
                current_path=path_add()
                pathname=get_new_path_name("path"+string(ds_list_size(path_index_list)))
                ds_map_add(pathmap_model,pathname,d3d_model_create())
                ds_map_add(pathmap_path,pathname,current_path)
                ds_map_add(pathmap_edited,pathname,true)
                item=N_Menu_AddItem(pathmenu,pathname,"")
                N_Menu_ItemSetBitmap(pathmenu,item,path_menuicon)
                ds_map_add(pathmenuitems,item,pathname)
                path_set_closed(current_path,0)
                path_set_precision(current_path,4)
                path_set_kind(current_path,0)
                path_add_point(current_path,round(xgo),round(ygo),100)
                oldpath=current_pathname
                current_pathname=pathname
                current_pathpoint=0
                if (oldpath!="") generate_path_model(oldpath)

                ds_list_add(path_index_list,pathname)
                ds_list_add(path_tree_list,"|"+pathname)
                ds_map_add(path_tree_map,pathname,"|"+pathname)

                generate_path_model(current_pathname)
                ds_list_clear(path_sel)
                selection=0
                update_inspector()
                update_selection_bounds()
            }
        }
        h=mouse_wheel_down()-mouse_wheel_up()
        pathscrollgo-=h*120
    }

    if (mouse_check_modal_pressed(mb_left) && mousein && current_path==noone) {
        dist=1000000
        key=ds_map_find_first(pathmap_path) repeat (ds_map_size(pathmap_path)) {
            path=ds_map_find_value(pathmap_path,key)
            d=distance_to_path(global.mousex,global.mousey,path)
            if (d<8*zm && d<dist) {dist=d current_path=path current_pathname=key}
        key=ds_map_find_next(pathmap_path,key)}
        if (current_path!=noone) {
            current_pathpoint=path_get_number(current_path)-1
            generate_path_model(current_pathname)
            ds_list_clear(path_sel)
            selection=0
            update_inspector()
            update_selection_bounds()
        }
    }

    pathnum=ds_map_size(pathmap_path)
    pathscrollgo=clamp(pathscrollgo,-(pathnum+1)*32+(height-328-120),0)
    pathscroll=clamp(approach((pathscroll*4+pathscrollgo)/5,pathscrollgo,2),-(pathnum+1)*32+(height-328-120),0)
}
