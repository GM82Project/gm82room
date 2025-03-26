var dx,dy;

if (mode==0 && objects_length) {
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

    //hotbar
    if (!textfield_active()) {
        i=1 repeat (9) {
            if (keyboard_check_pressed(ord("0")+i)) if (objhotbar[i]!=noone) objpal=objhotbar[i]
        i+=1}
    }

    dx=width div 2 -40*4.5-20
    dy=height-32-32-20

    if (mouse_check_button_pressed(mb_left)) if (point_in_rectangle(mouse_wx,mouse_wy,dx,dy,dx+9*40,dy+40)) {
        i=median(1,(mouse_wx-dx) div 40+1,9)
        if (objhotbar[i]!=noone) objpal=objhotbar[i]
        objhotbarhold=i
    }
    if (objhotbarhold) {
        i=median(1,(mouse_wx-dx) div 40+1,9)
        j=1 repeat (9) {
            if (objpal==objhotbar[j]) break
        j+=1}
        if (i!=j) {tmp=objhotbar[i] objhotbar[i]=objhotbar[j] objhotbar[j]=tmp}
        if (!mouse_check_direct(mb_left)) objhotbarhold=0
    }

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
}
