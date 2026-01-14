var dx,dy;

if (mode==0 && objects_length) {
    with (Instancepanel) if (open) {
        if (instance_position(mouse_wx,mouse_wy,id)) {
            yes=1 with (TextField) if (active) {yes=0}
            if (yes) {
                if (mouse_wheel_down()) {scroll=min(scroll+3,length-showlength)}
                if (mouse_wheel_up()) {scroll=max(0,scroll-3)}
            }

            if (mouse_check_button_pressed(mb_left)) {
                if (point_in_rectangle(mouse_wx,mouse_wy,x+w-32,y,x+w,y+32)) {
                    grab=1
                    offx=x+w-mouse_wx
                }
            }
            if (direct_mbleft) {
                if (point_in_rectangle(mouse_wx,mouse_wy,x+8-2,y+56+8-2,x+w-8+2,y+h-90-8+2)) {
                    click=((mouse_wy-(y+56+8-2)) div 20)+scroll
                    if (!selecting and not keyboard_check(vk_control)) deselect()
                    if (click>=0 and click<length and click-scroll<showlength) {
                        inst[click].sel=1
                        if (selecting) {
                            i=lastclick do {inst[i].sel=1 i=approach(i,click,1)} until i==click
                        } else lastclick=click
                    }

                    sel=num_selected()
                    if (sel==1) {
                        with (instance) if (sel) {select=id update_inspector()}
                    } else update_inspector()
                    if (sel>1) {
                        selection=1
                        update_selection_bounds()
                    }
                    focus_view_around_selection()

                    selecting=keyboard_check(vk_shift) or keyboard_check(vk_control)
                }
            } else selecting=false
        }
        if (grab) {
            w=mouse_wx+offx-x
            update_instancepanel()

            if (!direct_mbleft) {
                grab=0
            }
        }
    }

    //palette controls
    if (mouse_wx<160 && mouse_wy>=120 && mouse_wy<height-136) {
        if (mouse_check_button_pressed(mb_left) && !instance_exists(modal)) {
            posx=0
            posy=0
            for (i=0;i<objects_length;i+=1) if (objloaded[i]) {
                dx=20+40*posx
                dy=140+40*posy+palettescroll
                if (point_in_rectangle(mouse_wx,mouse_wy,dx-20,dy-20,dx+20,dy+20)) {
                    //clicked on object
                    fieldtarget_keepactive=noone
                    if (point_in_rectangle(mouse_wx,mouse_wy,dx,dy,dx+20,dy+20) && keyboard_check(vk_alt)) {
                        //hide/show object
                        objshow[i]=!objshow[i]
                    } else {
                        set_objpal(i)
                    }
                    change_mode(mode)
                }
                posx+=1 if (posx=4) {posx=0 posy+=1}
            }
            dx=20+40*posx
            dy=140+40*posy+palettescroll
            if (point_in_rectangle(mouse_wx,mouse_wy,dx-20,dy-20,dx+20,dy+20)) {
                //clicked on add object button
                draw_button_ext(dx-20,dy-20,40,40,0,global.col_main)
                draw_sprite(sprMenuButtons,18,dx,dy)
                screen_refresh()
                call_nmenu("object",objmenu)
            }
        }
        h=mouse_wheel_down()-mouse_wheel_up()
        palettescrollgo-=h*120
    }
    palettescrollgo=clamp(palettescrollgo,-(palettesize div 4+1)*40+(height-120-136),0)
    palettescroll=clamp(approach((palettescroll*4+palettescrollgo)/5,palettescrollgo,2),-(palettesize div 4+1)*40+(height-120-136),0)

    //"object sweeper"
    if (!textfield_active()) {
        j=1 repeat (9) {
            if (keyboard_check_pressed(ord("0")+j)) {
                //check if hovering on the palette first
                yes=1
                posx=0
                posy=0
                for (i=0;i<objects_length;i+=1) if (objloaded[i]) {
                    dx=20+40*posx
                    dy=140+40*posy+palettescroll
                    if (point_in_rectangle(mouse_wx,mouse_wy,dx-20,dy-20,dx+20,dy+20)) {
                        //clicked on object
                        k=0 repeat (9) {
                            if (objhotbar[k]==i) objhotbar[k]=noone
                        k+=1}
                        objhotbar[j]=i
                        yes=0
                        break
                    }
                    posx+=1 if (posx=4) {posx=0 posy+=1}
                }
                //select object instead
                if (yes) if (objhotbar[j]!=noone) {
                    focus_object(objhotbar[j])
                }
            }
        j+=1}
    }

    dx=width div 2 -40*4.5-20
    dy=height-32-32-20

    //next selection
    if (keyboard_check_pressed(ord("N"))) {
        if (ds_priority_size(click_priority)) {
            with (ds_priority_delete_max(click_priority)) {
                deselect()
                sel=1
                select=id
                update_inspector()
                update_selection_bounds()
            }
        }
    }

    //glue hotkey
    if (keyboard_check_pressed(ord("G")) and !keyboard_check(vk_control)) {
        if (num_selected()>1) {
            var object;object=noone
            with (instance) if (sel) {
                if (object==noone) object=obj
                else if (object!=obj) {object=noone break}
            }

            if (object!=noone) {
                previous=objpal
                o=skipwarnings
                skipwarnings=true
                set_objpal(object)
                cement_instances()
                skipwarnings=o
                set_objpal(previous)
            }
        }
    }


    //gigaknife hotkey
    if (keyboard_check_pressed(ord("K"))) {
        if (num_selected()) {
            o=skipwarnings
            skipwarnings=true
            subdivide_instances()
            skipwarnings=o
        }
    }
}
