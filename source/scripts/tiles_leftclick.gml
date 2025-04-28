var yes;yes=0

if (mode==1) {
    //if something's already selected, operate on it
    if (!keyboard_check(vk_shift)) with (selectt) {
        if (abs(global.mousex-draghandx)<8*zm && abs(global.mousey-draghandy)<8*zm) {
            scaling=1
            yes=1
        } else if (instance_position(global.mousex,global.mousey,id) && !keyboard_check(vk_control)) {
            start_dragging()
            yes=1
        }
    }
    if (yes) {with (tileholder) sel=0 selectt.sel=1}
    if (!instance_exists(selectt) || !yes) {
        clear_inspector()
        selectt=noone
        if (!keyboard_check(vk_shift)) {
            if (!overmode || keyboard_check(vk_control)) {
                if (fill_click_priority()) {
                    with (ds_priority_delete_max(click_priority)) {
                        sel=1
                        update_inspector()
                        //ctrl+left = move
                        if (keyboard_check(vk_control)) {
                            focus_tile(tile)      
                            //group operation
                            if (selection) {
                                grabselection=1
                            } else selection=(num_selected()>1)
                            with (tileholder) if (sel) {
                                start_dragging()
                            }                                 
                        } else {
                            deselect()
                            sel=1
                            selectt=id
                            start_dragging()
                        }
                        update_selection_bounds()
                    }
                }
            }
        }
        if (!selectt) {
            //if not holding control, reset selection
            //if (!keyboard_check(vk_control)) {with (tileholder) sel=0 with (selectt) sel=1}
            if (keyboard_check(vk_shift)) {
                //selection rectangle
                selecting=1
                with (tileholder) memsel=sel
                selx=global.mousex
                sely=global.mousey
            } else if (!keyboard_check(vk_control)) {
                if (tilebgpal!=noone) {
                    //paint
                    deselect()
                    paint=2
                    paintx=0
                    painty=0
                }
            }
        }
    }
}
