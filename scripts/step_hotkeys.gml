var yes;

if (keyboard_check(vk_control) && !keyboard_check(vk_shift) && keyboard_check_pressed(ord("Z"))) {
    yes=1 with (TextField) if (active) {yes=0 text=oldtext textfield_actions() active=0} if (yes) {
        keyboard_clear(ord("Z"))
        pop_undo()
    }
}
if (keyboard_check_pressed(vk_tab)) {
    if (keyboard_check(vk_shift)) change_mode(modwrap(mode-1,0,5))
    else change_mode((mode+1) mod 6)
}
if (keyboard_check_pressed(vk_escape)) {
    with (TextField) textfield_actions()
    clear_inspector()
    deselect()
}
if (keyboard_check(vk_control) && keyboard_check_pressed(ord("G"))) {
    grid=!grid
}
if (keyboard_check(vk_control) && keyboard_check_pressed(ord("A"))) {
    if (mode==0) with (instance) sel=1
    if (mode==1) with (tileholder) sel=1
    if (mode==5) {
        if (current_path) {
            ds_list_clear(path_sel)
            i=0 repeat (path_get_number(current_path)) {ds_list_add(path_sel,i) i+=1}
        }
    }
    selection=1
    update_inspector()
    update_selection_bounds()
}

if (mode==0 || mode==1) {
    if (keyboard_check_pressed(vk_insert)) overmode=!overmode

    if (keyboard_check_pressed(vk_delete)) {
        yes=1 with (TextField) if (active) yes=0 if (yes) {
            clear_inspector()
            select=noone
            selectt=noone
            if (num_selected()) begin_undo(act_create,"deleting "+pick(mode,"instances","tiles"),0)
            if (mode==0) with (instance) if (sel) {add_undo_instance() instance_destroy()}
            if (mode==1) with (tileholder) if (sel) {add_undo_tile() instance_destroy()}
            push_undo()
            selection=0
        }
    }
}

if (keyboard_check(vk_control) && keyboard_check_pressed(ord("F"))) {
    if (mode==0) {
        search_for_objects(get_string("Object name:",""))
    }
}

var h,v;

h=keyboard_check_pressed(vk_right)-keyboard_check_pressed(vk_left)
v=keyboard_check_pressed(vk_down)-keyboard_check_pressed(vk_up)

if ((h!=0 || v!=0) && !paint) {
    yes=1 with (TextField) if (active) yes=0 if (yes) {
        keyboard_clear(vk_left)
        keyboard_clear(vk_right)
        keyboard_clear(vk_up)
        keyboard_clear(vk_down)
        if (keyboard_check(vk_shift)) {h*=gridx v*=gridy}
        if (mode==0) {
            begin_undo(act_change,"moving instances",0)
            with (instance) if (sel) {x+=h y+=v add_undo_instance_props()}
            push_undo()
            with (select) update_inspector()
            update_instance_memory()
            update_selection_bounds()
        }
        if (mode==1) {
            begin_undo(act_change,"moving tiles",0)
            with (tileholder) if (sel) {x+=h y+=v tile_set_position(tile,x,y) add_undo_tile_props()}
            push_undo()
            with (selectt) update_inspector()
            update_instance_memory()
            update_selection_bounds()
        }
        if (mode==5 && current_path!=noone) {
            if (ds_list_size(path_sel)==0) {
                path_change_point(
                    current_path,current_pathpoint,
                    path_get_point_x(current_path,current_pathpoint)+h,
                    path_get_point_y(current_path,current_pathpoint)+v,
                    path_get_point_speed(current_path,current_pathpoint)
                )
            } else {
                i=0 repeat (ds_list_size(path_sel)) {
                    point=ds_list_find_value(path_sel,i)
                    path_change_point(
                        current_path,point,
                        path_get_point_x(current_path,point)+h,
                        path_get_point_y(current_path,point)+v,
                        path_get_point_speed(current_path,point)
                    )
                i+=1}
            }
            generate_path_model(current_pathname)
            dsmap(pathmap_edited,current_pathname,true)
            update_inspector()
            update_selection_bounds()
        }
    }
}

if (mode==5) {
    if (keyboard_check_pressed(vk_pageup)) button_actions("path point-")
    if (keyboard_check_pressed(vk_pagedown)) button_actions("path point+")
    if (keyboard_check_pressed(vk_insert)) button_actions("path point add")
    if (keyboard_check_pressed(vk_delete)) button_actions("path point del")
}
