var yes;yes=0

if (mode==0) {
    //if something's already selected, operate on it
    if (!keyboard_check(vk_shift)) {
        if (keyboard_check(ord("C"))) {
            with (instance) if (abs(global.mousex-fieldhandx)<9*zm && abs(global.mousey-fieldhandy)<9*zm) {
                fieldactive=1
                deselect()
                sel=1
                select=id
                update_inspector()
            }
        }
        with (select) {
            if (fieldactive) {
                edit_instance_fields(0)
                yes=1
            } else if (abs(global.mousex-fieldhandx)<9*zm && abs(global.mousey-fieldhandy)<9*zm) {
                fieldactive=1
                yes=1
            } else if (point_distance(rothandx,rothandy,global.mousex,global.mousey)<10*zm) {
                rotato=1
                yes=1
            } else if (abs(global.mousex-draghandx)<8*zm && abs(global.mousey-draghandy)<8*zm) {
                draggatto=1
                yes=1
            } else if (instance_position(global.mousex,global.mousey,id) && !keyboard_check(vk_control)) {
                start_dragging()
                yes=1
            }
        }
    }
    if (yes) {with (instance) sel=0 select.sel=1}
    if (!instance_exists(select) || !yes) {
        clear_inspector()
        select=noone
        if (!keyboard_check(vk_shift)) {
            if (!overmode || keyboard_check(vk_control)) {
                with (instance) {
                    if (instance_position(global.mousex,global.mousey,id)) {
                        //sort by reverse scale
                        ds_priority_add(click_priority,id,(max_int-depth)/abs(sprite_width*sprite_height))
                    }
                }
                if (ds_priority_size(click_priority)) {
                    with (ds_priority_find_max(click_priority)) {
                        sel=1
                        update_inspector()
                        //ctrl+left = move
                        if (keyboard_check(vk_control)) {
                            focus_object(obj)                        
                            //group operation
                            if (selection) {
                                grabselection=1
                            } else selection=(num_selected()>1)
                            with (instance) if (sel) {
                                start_dragging()
                            }                                
                        } else {
                            deselect()
                            sel=1
                            select=id
                            start_dragging()
                        }
                        update_selection_bounds()
                    }
                    ds_priority_clear(click_priority)
                }
            }
        }
        if (!select) {
            //if not holding control, reset selection
            //if (!keyboard_check(vk_control)) {with (instance) sel=0 with (select) sel=1}
            if (keyboard_check(vk_shift)) {
                //selection rectangle
                selecting=1
                with (instance) memsel=sel
                selx=global.mousex
                sely=global.mousey
            } else if (!keyboard_check(vk_control)) {
                //paint
                deselect()
                paint=2
                paintx=0
                painty=0
            }
        }
    }
}
