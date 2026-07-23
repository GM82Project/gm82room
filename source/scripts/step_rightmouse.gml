var menued;

if (selecting || paint || selsize || grabknob || grab_background) exit

if (direct_mbleft) exit

if (mode==1 and tilebgpal!=noone and (mousein or autotiler_rectangle) and window_focused and tilemap_complete and bg_tilemode[tilebgpal]) {
    //smart mode
    if (mouse_check_modal_pressed(mb_right)) {
        autotiler_last_click=noone
        if (keyboard_check(vk_shift)) {
            autotiler_rectangle=2
            autotiler_rectangle_x=floor(global.mousex/gridx)
            autotiler_rectangle_y=floor(global.mousey/gridy)
        }
    }
    if (mouse_check_modal(mb_right)) {
        if (direct_mbleft and autotiler_rectangle==2) {autotiler_rectangle=0 exit}
        if (!autotiler_rectangle) bresenham(
            floor(global.mousex_old/gridx),floor(global.mousey_old/gridy),
            floor(global.mousex/gridx),floor(global.mousey/gridy),
            draw_tilesmart_brush,0
        )
    } else {
        if (autotiler_rectangle==2) {
            left=min(floor(global.mousex/gridx),autotiler_rectangle_x)
            right=max(floor(global.mousex/gridx),autotiler_rectangle_x)
            top=min(floor(global.mousey/gridy),autotiler_rectangle_y)
            bottom=max(floor(global.mousey/gridy),autotiler_rectangle_y)
            ur=(right-left)+1
            vr=(bottom-top)+1
            v=top repeat (vr) {u=left repeat (ur) {
                draw_tilesmart_brush(u,v,0)
            u+=1}v+=1}
            autotiler_rectangle=0
            update_tilesmart_tiles()
        }
    }
    exit
}

if (mousein && mode==0 && mouse_check_modal_pressed(mb_right)) {
    with (select) if (fieldactive) {
        edit_instance_fields(1)
        exit
    }
}

if (mouse_check_modal_pressed(mb_right)) {
    if (!mousein) {
        //click on menus
        with (Button) if (instance_position(mouse_wx,mouse_wy,id)) {
            event_user(3)
        }
    } else if ((!swaprmb && keyboard_check(vk_control)) or (swaprmb && !keyboard_check(vk_control) && !keyboard_check(vk_shift))) and (mode!=5) {
        //stack menu
        menued=false
        if (mode==0) {
            if (fill_click_priority()) {
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
                if (!menued) with (select) {fieldactive=1 fieldtarget_keepactive=id}
            } else deselect()
        }
        if (mode==1) {
            if (fill_click_priority()) {
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
            } else deselect()
        }
    } else {
        //delete
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
                    //delete point
                    current_pathpoint=max(0,point-1)
                    path_delete_point(current_path,point)
                    dsmap(pathmap_edited,current_pathname,true)
                    generate_path_model(current_pathname)
                    select_path_point(current_pathpoint,1)
                }
            }
        }
    }
}

if (erasing) {
    //delete instances or tiles
    var find,justone;
    justone=((swaprmb && keyboard_check(vk_control)) || (!swaprmb && !keyboard_check(vk_shift))) && !(rmbalwaysdel && !swaprmb)
    do {
        find=false
        if (mode==0) with (instance_position(global.mousex,global.mousey,instance)) {add_undo_instance() instance_destroy() find=true}
        if (mode==1) with (instance_position(global.mousex,global.mousey,tileholder)) {add_undo_tile() instance_destroy() find=true}
    } until (!find || justone)

    if (!direct_mbright || justone) {erasing=0 push_undo()}
}
