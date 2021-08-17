var yes,dx,dy,tex;

if (mouse_check_button_pressed(mb_left)) {
    with (TextField) textfield_actions()
    if (!mousein) {
        //click on menus
        with (Button) if (instance_position(mouse_wx,mouse_wy,id)) {
            event_user(2)
        }
    } else {
        //click on workspace
        yes=0
        if (mode==0) {
            //if something's already selected, operate on it
            if (!keyboard_check(vk_shift)) with (select) {
                if (position_meeting(mouse_x,mouse_y,id) && keyboard_check(vk_control)) {
                    grab=1
                    offx=mouse_x-x
                    offy=mouse_y-y
                    yes=1
                } else if (point_distance(rothandx,rothandy,mouse_x,mouse_y)<10*zm) {
                    rotato=1
                    yes=1
                } else if (abs(mouse_x-draghandx)<8*zm && abs(mouse_y-draghandy)<8*zm) {
                    draggatto=1
                    yes=1
                }
            }
            if (yes) {with (instance) sel=0 select.sel=1}
            if (!instance_exists(select) || !yes) {
                clear_inspector()
                if (!keyboard_check(vk_shift)) with (instance) sel=0
                select=noone
                with (instance) {
                    if (position_meeting(mouse_x,mouse_y,id)) {
                        sel=1
                        update_inspector()
                        //ctrl+left = move
                        if (keyboard_check(vk_control)) {
                            grab=1
                            offx=mouse_x-x
                            offy=mouse_y-y
                            focus_object(obj)
                            //group operation
                            with (instance) if (sel) {
                                grab=1
                                offx=mouse_x-x
                                offy=mouse_y-y
                            }
                        } else with (other.select) sel=0
                        other.select=id
                    }
                }
                if (!select) {
                    //if not holding control, reset selection
                    if (!keyboard_check(vk_control)) {with (instance) sel=0 with (select) sel=1}
                    if (keyboard_check(vk_shift)) {
                        //selection rectangle
                        selecting=1
                        with (instance) memsel=sel
                        selx=mouse_x
                        sely=mouse_y
                    } else if (!keyboard_check(vk_control)) {
                        //paint
                        paint=2
                        paintx=0
                        painty=0
                    }
                }
            }
        }
        if (mode==1) {
            //if something's already selected, operate on it
            if (!keyboard_check(vk_shift)) with (selectt) {
                if (position_meeting(mouse_x,mouse_y,id) && keyboard_check(vk_control)) {
                    grab=1
                    offx=mouse_x-x
                    offy=mouse_y-y
                    yes=1
                } else if (extended_instancedata) if (abs(mouse_x-draghandx)<8*zm && abs(mouse_y-draghandy)<8*zm) {
                    draggatto=1
                    yes=1
                }
            }
            if (yes) {with (tileholder) sel=0 selectt.sel=1}
            if (!instance_exists(selectt) || !yes) {
                clear_inspector()
                if (!keyboard_check(vk_shift)) with (tileholder) sel=0
                selectt=noone
                with (tileholder) {
                    if (position_meeting(mouse_x,mouse_y,id)) {
                        sel=1
                        update_inspector()
                        //ctrl+left = move
                        if (keyboard_check(vk_control)) {
                            grab=1
                            offx=mouse_x-x
                            offy=mouse_y-y
                            focus_tile(tile)
                            //group operation
                            with (tileholder) if (sel) {
                                grab=1
                                offx=mouse_x-x
                                offy=mouse_y-y
                            }
                        } else with (other.selectt) sel=0
                        other.selectt=id
                    }
                }
                if (!selectt) {
                    //if not holding control, reset selection
                    if (!keyboard_check(vk_control)) {with (tileholder) sel=0 with (selectt) sel=1}
                    if (keyboard_check(vk_shift)) {
                        //selection rectangle
                        selecting=1
                        with (tileholder) memsel=sel
                        selx=mouse_x
                        sely=mouse_y
                    } else if (!keyboard_check(vk_control)) {
                        //paint
                        paint=2
                        paintx=0
                        painty=0
                    }
                }
            }
        }
        if (mode==3) {
            if (abs(mouse_x-(vw_x[vw_current]+vw_w[vw_current]))<8 && abs(mouse_y-(vw_y[vw_current]+vw_h[vw_current]))<8) {
                sizeview=1
            } else if (point_in_rectangle(mouse_x,mouse_y,vw_x[vw_current],vw_y[vw_current],vw_x[vw_current]+vw_w[vw_current],vw_y[vw_current]+vw_h[vw_current])) {
                grabview=1
                offx=mouse_x-vw_x[vw_current]
                offy=mouse_y-vw_y[vw_current]
            } else {
                for (i=0;i<8;i+=1) if (vw_visible[i]) if (point_in_rectangle(mouse_x,mouse_y,vw_x[i],vw_y[i],vw_x[i]+vw_w[i],vw_y[i]+vw_h[i])) {
                    vw_current=i
                }
            }
        }
    }
}
if (selecting) {
    if (mode==0) {
        with (instance) {
            if (collision_rectangle(other.selx,other.sely,mouse_x,mouse_y,id,1,0)) sel=1
            else sel=memsel
        }
    }
    if (mode==1) {
        with (tileholder) {
            if (collision_rectangle(other.selx,other.sely,mouse_x,mouse_y,id,1,0)) sel=1
            else sel=memsel
        }
    }
    if (!mouse_check_direct(mb_left)) {
        selecting=0
        update_inspector()
    }
}


//painting!  :3
if (paint) {
    if (keyboard_check(vk_alt)) {
        dx=mouse_x
        dy=mouse_y
    } else {
        dx=floorto(mouse_x,gridx)
        dy=floorto(mouse_y,gridy)
    }
    if (dx!=paintx || dy!=painty || paint=2) {
        paint=1
        paintx=dx
        painty=dy
        yes=1
        if (mode==0) {
            if (overlap_check) {
                sprite_index=objspr[objpal]
                x=paintx
                y=painty
                with (instance) if (obj=objpal) if (place_meeting(x,y,Controller)) {
                    yes=0
                }
            }
            if (yes) {
                o=instance_create(dx,dy,instance)
                o.obj=objpal
                o.objname=ds_list_find_value(objects,o.obj)
                o.sprite_index=objspr[o.obj]
                o.sprw=sprite_get_width(o.sprite_index)
                o.sprh=sprite_get_height(o.sprite_index)
                o.sprox=sprite_get_xoffset(o.sprite_index)
                o.sproy=sprite_get_yoffset(o.sprite_index)
                select=o
                o.sel=1
                o.modified=1
                with (o) update_inspector()
            }
        }
        if (mode==1) {
            if (tilebgpal!=noone) {
                tex=bg_background[tilebgpal]
                if (overlap_check) {
                    sprite_index=spr1x1
                    image_xscale=ds_list_find_value(curtile,2)
                    image_yscale=ds_list_find_value(curtile,3)
                    x=paintx
                    y=painty
                    with (tileholder) if (bg=tex) if (place_meeting(x,y,Controller)) {
                        yes=0
                    }
                    image_xscale=1
                    image_yscale=1
                }
                if (yes) {
                    o=instance_create(dx,dy,tileholder)
                    o.bgname=tilebgname
                    o.bg=tex
                    o.tilew=ds_list_find_value(curtile,2)
                    o.tileh=ds_list_find_value(curtile,3)
                    o.image_xscale=o.tilew
                    o.image_yscale=o.tileh
                    o.tile=tile_add(tex,ds_list_find_value(curtile,0),ds_list_find_value(curtile,1),o.tilew,o.tileh,paintx,painty,ly_depth)
                    o.tlayer=ly_depth
                    selectt=o
                    o.sel=1
                    o.modified=1
                    with (o) update_inspector()
                }
            }
        }
    }
    if (!mouse_check_direct(mb_left)) {
        paint=0
        begin_undo(act_destroy)
        if (mode==0) {
            with (instance) if (modified) {add_undo(id) modified=0}
        }
        if (mode==1) {
            with (tileholder) if (modified) {add_undo(id) modified=0}
        }
        push_undo()
    }
}
