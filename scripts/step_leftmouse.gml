var yes,dx,dy,tex,l,t,r,b;

if (erasing) exit

if (mouse_check_modal_pressed(mb_left)) {
    with (TextField) textfield_actions()
    if (point_distance(mouse_wx,mouse_wy,width-48-160,48+32)<32 && !hide3dgizmo) {
        grabknob=1
        knoffmx=mouse_wx
        knoffmy=mouse_wy
        knoffx=knobx
        knoffy=knoby
    } else if (!mousein) {
        //click on menus
        with (Button) if (instance_position(mouse_wx,mouse_wy,id)) {
            event_user(2)
        }
    } else {
        //click on workspace
        if (selection && abs(global.mousex-(selleft+selwidth))<8*zm && abs(global.mousey-(seltop+selheight))<8*zm) {
            storex=selwidth
            storey=selheight
            with (instance) if (sel) {
                start_selection_resize()
            }
            with (tileholder) if (sel) {
                start_selection_resize()
            }
            selsize=1
        } else {
            objects_leftclick()
            tiles_leftclick()
        }
        backgrounds_leftclick()
        views_leftclick()
        settings_leftclick()
        paths_leftclick()
    }
}
if (selecting) {
    l=min(selx,global.mousex)
    t=min(sely,global.mousey)
    r=max(selx,global.mousex)
    b=max(sely,global.mousey)

    if (mode==0) {
        with (instance) {
            if (collision_rectangle(l,t,r,b,id,1,0)) sel=1
            else {
                if (bbox_left>=bbox_right || bbox_top>=bbox_bottom) {
                    if (point_in_rectangle(x,y,l,t,r,b)) sel=1
                    else sel=memsel
                } else sel=memsel
            }
        }
    }
    if (mode==1) {
        with (tileholder) {
            if (collision_rectangle(l,t,r,b,id,1,0)) sel=1
            else {
                if (bbox_left>=bbox_right || bbox_top>=bbox_bottom) {
                    if (point_in_rectangle(x,y,l,t,r,b)) sel=1
                    else sel=memsel
                } else sel=memsel
            }
        }
    }
    if (!direct_mbleft) {
        selecting=0
        selection=0
        sel=num_selected()
        if (sel==1) {
            if (mode==0) {
                with (instance) if (sel) {select=id update_inspector()}
            }
            if (mode==1) {
                with (tileholder) if (sel) {selectt=id update_inspector()}
            }
        } else update_inspector()
        if (sel>1) {
            selection=1
            update_selection_bounds()
        }
    }
}


//painting!  :3
if (paint) {
    step_painting()
}

if (selsize) {
    selection=1
    if (keyboard_check(vk_alt)) {
        selwidth=(global.mousex-selleft)
        selheight=(global.mousey-seltop)
    } else {
        selwidth=roundto_unbiased(global.mousex,gridx)-selleft
        selheight=roundto_unbiased(global.mousey,gridy)-seltop
    }

    if (abs(selwidth)<gridx) selwidth=esign(selwidth,1)*gridx
    if (abs(selheight)<gridy) selheight=esign(selheight,1)*gridy

    if (!direct_mbleft) {
        selsize=0
    }
}

if (grabknob) {
    knoby=knoffy+mouse_wx-knoffmx
    knobx=knoffx-(mouse_wy-knoffmy)
    knobz=(knobz*19+knobzgo)/20
    if (!direct_mbleft) {
        grabknob=0
    }
} else {
    knobx=approach(knobx*0.95,0,0.1)
    knoby=approach(knoby*0.95,0,0.1)
    knobz=approach(knobz*0.98,0,0.01)
}

if (grab_background) {
    if (keyboard_check(vk_alt)) {
        bg_xoffset[bg_current]=global.mousex+grab_bgoffx
        bg_yoffset[bg_current]=global.mousey+grab_bgoffy
    } else {
        bg_xoffset[bg_current]=roundto_unbiased(global.mousex+grab_bgoffx,gridx)
        bg_yoffset[bg_current]=roundto_unbiased(global.mousey+grab_bgoffy,gridy)
    }
    update_backgroundpanel()

    if (!direct_mbleft) grab_background=false
}

if (drag_point) {
    pxo=path_get_point_x(current_path,current_pathpoint)
    pyo=path_get_point_y(current_path,current_pathpoint)
    if (keyboard_check(vk_alt)) path_change_point(current_path,current_pathpoint,global.mousex,global.mousey,path_get_point_speed(current_path,current_pathpoint))
    else path_change_point(current_path,current_pathpoint,fmx,fmy,path_get_point_speed(current_path,current_pathpoint))

    if (pxo!=path_get_point_x(current_path,current_pathpoint) || pyo!=path_get_point_y(current_path,current_pathpoint)) {
        generate_path_model(current_pathname)
        dsmap(pathmap_edited,current_pathname,true)
        update_inspector()
        update_selection_bounds()
    }

    if (!mouse_check_direct(mb_left) && !mouse_check_button_pressed(mb_left)) {
        drag_point=0
    }
}
