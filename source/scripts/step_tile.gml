var dx,dy,yes;

if (mode==1) {
    //tile palette
    with (Tilepanel) step_tile_panel()

    if (point_in_rectangle(mouse_wx,mouse_wy,0,120,160,Tilepanel.y-24)) {
        //background list
        posy=0
        if (backgrounds_length) {
            i=0 repeat (backgrounds_length) {
                if (bghastiles[i]) {
                    dx=0
                    dy=120+32*posy+tpalscroll
                    if (mouse_check_button_pressed(mb_left)) if (point_in_rectangle(mouse_wx,mouse_wy,dx,dy,dx+160,dy+32)) {
                        reset=(tilebgpal!=i)
                        tilebgpal=i
                        tilebgname=ds_list_find_value(backgrounds,tilebgpal)
                        update_newtilepanel(reset)
                    }
                    posy+=1
                }
                i+=1
            }
            dx=0
            dy=120+32*posy+tpalscroll
            if (mouse_check_button_pressed(mb_left)) if (point_in_rectangle(mouse_wx,mouse_wy,dx,dy,dx+160,dy+32)) {
                call_nmenu("tilebg",bgmenu)
            }
        }
        if (tilebgpal!=noone) {
            h=mouse_wheel_down()-mouse_wheel_up()
            tpalscrollgo-=h*96
        }
    }
    if (tilebgpal!=noone) {
        tpalscrollgo=clamp(tpalscrollgo,-(posy+1)*32+(Tilepanel.y-24-120),0)
        tpalscroll=clamp(approach((tpalscroll*4+tpalscrollgo)/5,tpalscrollgo,2),-(posy+1)*32+(Tilepanel.y-24-120),0)
    }

    //layer inspector
    if (mouse_wx>=width-160 && mouse_wy>=360 && mouse_wy<height-100) {
        if (mouse_check_button_pressed(mb_left)) {
            //click on layer bar
            mem=ly_current
            ly_current=median(0,floor((mouse_wy-360-layerscroll)/32),layersize+1)
            if (ly_current==layersize+1) {
                //clicked ahead of the list
                ly_current=mem
            } else {
                deselect()
                if (ly_current==layersize) {
                    add_tile_layer()
                }
                change_mode(mode)
                update_tilepanel()
            }
        }
        h=mouse_wheel_down()-mouse_wheel_up()
        layerscrollgo-=h*120
    }
    layerscrollgo=clamp(layerscrollgo,-(layersize+1)*32+(height-100-360),0)
    layerscroll=clamp(approach((layerscroll*4+layerscrollgo)/5,layerscrollgo,2),-(layersize+1)*32+(height-100-360),0)

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
