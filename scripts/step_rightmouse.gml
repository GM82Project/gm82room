if (selecting || paint || selsize || grabknob || grab_background) exit

if (mousein && mode==0 && mouse_check_button_pressed(mb_right)) {
    with (select) if (fieldactive) {
        edit_instance_fields(1)
        exit
    }
}

if (mouse_check_button_pressed(mb_right)) {
    if (keyboard_check(vk_control)) {
        if (mode==0) {
            with (instance) {
                if (instance_position(global.mousex,global.mousey,id)) {
                    //sort by reverse scale
                    ds_priority_add(click_priority,id,(max_int-depth)/abs(sprite_width*sprite_height))
                }
            }
            if (ds_priority_size(click_priority)) {
                str="Stacked instances:|-"
                i=-1
                do {
                   i+=1
                   prio=ds_priority_find_priority(click_priority,ds_priority_find_max(click_priority))
                   inst[i]=ds_priority_delete_max(click_priority)
                   if (inst[i].sel) str+="|[" else str+="|"
                   str+=inst[i].objname+" ("+inst[i].uid+")"
                   if (inst[i].sel) str+="]"
                } until (!ds_priority_size(click_priority))

                if (i>0) {menued=true i=show_menu(str,0)-1}

                if (i!=-1) with (inst[i]) {
                    deselect()
                    sel=1
                    update_inspector()
                    select=id
                    update_selection_bounds()
                }
                ds_priority_clear(click_priority)
            }
        }
        if (mode==1) {
            with (tileholder) {
                if (instance_position(global.mousex,global.mousey,id)) {
                    //sort by reverse scale
                    ds_priority_add(click_priority,id,(max_int-depth)/abs(tilesx*tilew*tilesy*tileh))
                }
            }
            if (ds_priority_size(click_priority)) {
                str="Stacked tiles:|-"
                i=-1
                do {
                   i+=1
                   prio=ds_priority_find_priority(click_priority,ds_priority_find_max(click_priority))
                   inst[i]=ds_priority_delete_max(click_priority)
                   if (inst[i].sel) str+="|[" else str+="|"
                   str+=inst[i].bgname+" ("+string(tile_get_left(inst[i].tile))+","+string(tile_get_top(inst[i].tile))+","+string(tile_get_width(inst[i].tile))+","+string(tile_get_height(inst[i].tile))+")"
                   if (inst[i].sel) str+="]"
                } until (!ds_priority_size(click_priority))

                if (i>0) {menued=true i=show_menu(str,0)-1}

                if (i!=-1) with (inst[i]) {
                    deselect()
                    sel=1
                    update_inspector()
                    selectt=id
                }
                ds_priority_clear(click_priority)
            }
        }
    } else {
        if (mousein) {
            if (selecting) selecting=0
            with (TextField) textfield_actions()
            clear_inspector()
            if (mode==0 || mode==1) {
                deselect()
                begin_undo(act_create,"erasing "+pick(mode,"instances","tiles"),0)
                erasing=1
            }
            if (mode==5) {
                var maxd,point,p;

                maxd=8*zm point=-1
                pointnum=path_get_number(current_path)

                if (pointnum>1) {
                    for (p=0;p<pointnum;p+=1) {
                        px=path_get_point_x(current_path,p)
                        py=path_get_point_y(current_path,p)
                        d=point_distance(global.mousex,global.mousey,px,py)
                        if (d<=maxd) {point=p maxd=d}
                    }

                    if (point>=0) {
                        current_pathpoint=max(0,point-1)
                        path_delete_point(current_path,point)
                        paths[current_pathindex,5]=true
                        generate_path_model(current_pathindex)
                        update_inspector()
                    }
                }
            }
        }
    }
}

if (erasing) {
    //delete instances
    if (mode==0) with (instance_position(global.mousex,global.mousey,instance)) {add_undo_instance() instance_destroy()}
    if (mode==1) with (instance_position(global.mousex,global.mousey,tileholder)) {add_undo_tile() instance_destroy()}

    if (!direct_mbright) {erasing=0 push_undo()}
}
