var yes,dx,dy,tex,l,t,r,b,zm,menued;

//give priority to right click
if (mouse_check_button(mb_right)) exit

if (mouse_check_button_pressed(mb_left)) {
    menued=false
    zm=max(0.5,zoom)
    with (TextField) textfield_actions()
    if (point_distance(mouse_wx,mouse_wy,width-48-160,height-48-32)<32) {
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
        yes=0

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
            if (mode==0) {
                //if something's already selected, operate on it
                if (!keyboard_check(vk_shift)) {
                    if (keyboard_check(ord("C"))) {
                        with (instance) if (abs(global.mousex-fieldhandx)<9*zm && abs(global.mousey-fieldhandy)<9*zm && objfields[obj]) {
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
                        } else if (abs(global.mousex-fieldhandx)<9*zm && abs(global.mousey-fieldhandy)<9*zm && objfields[obj]) {
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
                               str+="|"+inst[i].objname+" ("+inst[i].uid+")"

                               //as long as the next instance has the same dimensions, keep going
                               next=ds_priority_find_max(click_priority)
                               if (next) if (next.bbox_left==inst[i].bbox_left && next.bbox_top==inst[i].bbox_top && next.bbox_right==inst[i].bbox_right && next.bbox_bottom==inst[i].bbox_bottom) continue

                               //stop when the next instance has a lower priority
                               if (prio!=ds_priority_find_priority(click_priority,next)) break
                            } until (!ds_priority_size(click_priority))

                            if (i>0 && !keyboard_check(vk_control)) {menued=true i=show_menu(str,0)-1}

                            if (i!=-1) with (inst[i]) {
                                sel=1
                                update_inspector()
                                //ctrl+left = move
                                if (keyboard_check(vk_control)) {
                                    focus_object(obj)
                                    if (!menued) {
                                        //group operation
                                        if (selection) {
                                            grabselection=1
                                        } else selection=(num_selected()>1)
                                        with (instance) if (sel) {
                                            start_dragging()
                                        }
                                    }
                                } else {
                                    deselect()
                                    sel=1
                                    select=id
                                    if (!menued) start_dragging()
                                }
                                update_selection_bounds()
                            }
                            ds_priority_clear(click_priority)
                        }
                    }
                    if (!select && !menued) {
                        //if not holding control, reset selection
                        if (!keyboard_check(vk_control)) {with (instance) sel=0 with (select) sel=1}
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
            if (mode==1) {
                //if something's already selected, operate on it
                if (!keyboard_check(vk_shift)) with (selectt) {
                    if (abs(global.mousex-draghandx)<8*zm && abs(global.mousey-draghandy)<8*zm) {
                        draggatto=1
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
                               str+="|"+inst[i].bgname+" ("+string(tile_get_left(inst[i].tile))+","+string(tile_get_top(inst[i].tile))+","+string(tile_get_width(inst[i].tile))+","+string(tile_get_height(inst[i].tile))+")"

                               //as long as the next instance has the same dimensions, keep going
                               next=ds_priority_find_max(click_priority)
                               if (next) if (!(next.bbox_left==inst[i].bbox_left && next.bbox_top==inst[i].bbox_top && next.bbox_right==inst[i].bbox_right && next.bbox_bottom==inst[i].bbox_bottom)) break
                            } until (!ds_priority_size(click_priority))

                            if (i>0 && !keyboard_check(vk_control)) {menued=true i=show_menu(str,0)-1}

                            if (i!=-1) with (inst[i]) {
                                sel=1
                                update_inspector()
                                //ctrl+left = move
                                if (keyboard_check(vk_control)) {
                                    focus_tile(tile)
                                    if (!menued) {
                                        //group operation
                                        if (selection) {
                                            grabselection=1
                                        } else selection=(num_selected()>1)
                                        with (tileholder) if (sel) {
                                            start_dragging()
                                        }
                                    }
                                } else {
                                    deselect()
                                    sel=1
                                    selectt=id
                                    if (!menued) start_dragging()
                                }
                                update_selection_bounds()
                            }
                            ds_priority_clear(click_priority)
                        }
                    }
                    if (!selectt) {
                        //if not holding control, reset selection
                        if (!keyboard_check(vk_control)) {with (tileholder) sel=0 with (selectt) sel=1}
                        if (keyboard_check(vk_shift)) {
                            //selection rectangle
                            selecting=1
                            with (tileholder) memsel=sel
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
        }
        if (mode==2) {
            if (bg_visible[bg_current]) {
                begin_undo(act_globalvec,"background "+string(bg_current)+" options",0)
                add_undo("bg_xoffset") add_undo(bg_current)
                add_undo(bg_xoffset[bg_current])
                push_undo()
                begin_undo(act_globalvec,"background "+string(bg_current)+" options",1)
                add_undo("bg_yoffset") add_undo(bg_current)
                add_undo(bg_yoffset[bg_current])
                push_undo()
                grab_background=true
                grab_bgoffx=bg_xoffset[bg_current]-global.mousex
                grab_bgoffy=bg_yoffset[bg_current]-global.mousey
            }
        }
        if (mode==3) {
            if (abs(global.mousex-(vw_x[vw_current]+vw_w[vw_current]))<8*zm && abs(global.mousey-(vw_y[vw_current]+vw_h[vw_current]))<8*zm) {
                sizeview=1
                storex=vw_w[vw_current]
                storey=vw_h[vw_current]
            } else if (point_in_rectangle(global.mousex,global.mousey,vw_x[vw_current],vw_y[vw_current],vw_x[vw_current]+vw_w[vw_current],vw_y[vw_current]+vw_h[vw_current])) {
                grabview=1
                storex=vw_x[vw_current]
                storey=vw_y[vw_current]
                offx=global.mousex-vw_x[vw_current]
                offy=global.mousey-vw_y[vw_current]
            } else {
                for (i=0;i<8;i+=1) if (vw_visible[i]) if (point_in_rectangle(global.mousex,global.mousey,vw_x[i],vw_y[i],vw_x[i]+vw_w[i],vw_y[i]+vw_h[i])) {
                    vw_current=i
                }
            }
        }
        if (mode==4) {
            if (chunkcrop) {
                if (abs(global.mousex-(chunkleft+chunkwidth))<8*zm && abs(global.mousey-(chunktop+chunkheight))<8*zm) {
                    sizechunk=1
                    storex=chunkwidth
                    storey=chunkheight
                    with (instance) if (sel) {
                        start_selection_resize()
                    }
                    with (tileholder) if (sel) {
                        start_selection_resize()
                    }
                } else if (point_in_rectangle(global.mousex,global.mousey,chunkleft,chunktop,chunkleft+chunkwidth,chunktop+chunkheight)) {
                    grabchunk=1
                    storex=chunkleft
                    storey=chunktop
                    offx=global.mousex-chunkleft
                    offy=global.mousey-chunktop
                    with (instance) if (sel) {
                        start_dragging()
                    }
                    with (tileholder) if (sel) {
                        start_dragging()
                    }
                } else {
                    deselect()
                }
            }
        }
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
    if (!mouse_check_direct(mb_left)) {
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
    if (keyboard_check(vk_alt)) {
        dx=global.mousex
        dy=global.mousey
    } else {
        dx=floorto(global.mousex,gridx)
        dy=floorto(global.mousey,gridy)
    }
    if (dx!=paintx || dy!=painty || paint=2) {
        paint=1
        paintx=dx
        painty=dy
        yes=1
        if (mode==0) {
            if (objpal!=noone) {
                if (overlap_check) {
                    sprite_index=objspr[objpal]
                    x=paintx
                    y=painty
                    reduce_collision()
                    with (instance) if (obj=objpal) if (instance_place(x,y,Controller)) {
                        yes=0
                    }
                    restore_collision()
                }
                if (yes) {
                    o=instance_create(dx,dy,instance) get_uid(o)
                    o.obj=objpal
                    o.objname=ds_list_find_value(objects,o.obj)
                    o.depth=objdepth[o.obj]
                    o.sprite_index=objspr[o.obj]
                    o.sprw=sprite_get_width(o.sprite_index)
                    o.sprh=sprite_get_height(o.sprite_index)
                    o.sprox=sprite_get_xoffset(o.sprite_index)
                    o.sproy=sprite_get_yoffset(o.sprite_index)
                    parse_code_into_fields(o)
                    select=o
                    o.sel=1
                    o.modified=1
                    with (o) update_inspector()
                }
            }
        }
        if (mode==1) {
            if (tilebgpal!=noone) {
                tex=bg_background[tilebgpal]
                if (tile_overlap_check) {
                    sprite_index=spr1x1
                    image_xscale=ds_list_find_value(curtile,2)
                    image_yscale=ds_list_find_value(curtile,3)
                    x=paintx
                    y=painty
                    reduce_collision()
                    with (tileholder) if (bg=tex) if (instance_place(x,y,Controller)) {
                        yes=0
                    }
                    restore_collision()
                }
                if (yes) {
                    o=instance_create(dx,dy,tileholder) get_uid(o)
                    o.bgname=tilebgname
                    o.bg=tex
                    o.tilew=ds_list_find_value(curtile,2)
                    o.tileh=ds_list_find_value(curtile,3)
                    o.image_xscale=o.tilew
                    o.image_yscale=o.tileh
                    o.tile=tile_add(tex,ds_list_find_value(curtile,0),ds_list_find_value(curtile,1),o.tilew,o.tileh,paintx,painty,ly_depth)
                    o.tlayer=ly_depth o.depth=ly_depth-0.01
                    selectt=o
                    o.sel=1
                    o.modified=1
                    with (o) update_inspector()
                }
            }
        }
        update_instance_memory()
    }
    if (!mouse_check_direct(mb_left) || !mouse_check_button(mb_left)) {
        paint=0
        begin_undo(act_destroy,"drawing "+pick(mode,"instances","tiles"),0)
        if (mode==0) {
            with (instance) if (modified) {add_undo(uid) modified=0}
        }
        if (mode==1) {
            with (tileholder) if (modified) {add_undo(uid) modified=0}
        }
        push_undo()
    }
}

if (selsize) {
    selection=1
    if (keyboard_check(vk_alt)) {
        selwidth=(global.mousex-selleft)
        selheight=(global.mousey-seltop)
    } else {
        selwidth=roundto(global.mousex,gridx)-selleft
        selheight=roundto(global.mousey,gridy)-seltop
    }

    if (abs(selwidth)<gridx) selwidth=esign(selwidth,1)*gridx
    if (abs(selheight)<gridy) selheight=esign(selheight,1)*gridy

    if (!mouse_check_direct(mb_left) || !mouse_check_button(mb_left)) {
        selsize=0
    }
}

if (grabselection) {
    update_selection_bounds()
    if (!mouse_check_direct(mb_left) || !mouse_check_button(mb_left)) {
        grabselection=0
    }
}

if (grabknob) {
    knoby=knoffy+mouse_wx-knoffmx
    knobx=knoffx-(mouse_wy-knoffmy)
    knobz=(knobz*19+knobzgo)/20
    if (!mouse_check_direct(mb_left) || !mouse_check_button(mb_left)) {
        grabknob=0
    }
} else {
    knobx=inch(knobx*0.95,0,0.1)
    knoby=inch(knoby*0.95,0,0.1)
    knobz=inch(knobz*0.98,0,0.01)
}

if (grab_background) {
    if (keyboard_check(vk_alt)) {
        bg_xoffset[bg_current]=global.mousex+grab_bgoffx
        bg_yoffset[bg_current]=global.mousey+grab_bgoffy
    } else {
        bg_xoffset[bg_current]=roundto(global.mousex+grab_bgoffx,gridx)
        bg_yoffset[bg_current]=roundto(global.mousey+grab_bgoffy,gridy)
    }
    update_backgroundpanel()

    if (!mouse_check_direct(mb_left)) grab_background=false
}
