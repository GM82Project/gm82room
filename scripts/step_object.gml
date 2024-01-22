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
                    objpal=i
                    change_mode(mode)
                    textfield_set("palette name",ds_list_find_value(objects,objpal))
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
}
