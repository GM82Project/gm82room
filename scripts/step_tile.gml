var dx,dy;

if (mode==1 && tilebgpal!=noone) {
    //tile palette
    map=bg_tilemap[tilebgpal]
    tpalsize=ds_map_size(map)
    if (mouse_wx<160 && mouse_wy>=152 && mouse_wy<height-216) {
        if (mouse_check_button_pressed(mb_left)) {
            //click on tile palette
            posx=0
            posy=0
            for (i=0;i<tpalsize;i+=1) {
                dx=20+40*posx
                dy=172+40*posy+tpalscroll
                if (point_in_rectangle(mouse_wx,mouse_wy,dx-20,dy-20,dx+20,dy+20)) {
                    tilepal=i
                    key=ds_map_find_first(map)
                    repeat (tilepal) key=ds_map_find_next(map,key)
                    curtile=ds_map_find_value(map,key)
                }
                posx+=1 if (posx=4) {posx=0 posy+=1}
            }
            dx=20+40*posx
            dy=172+40*posy+tpalscroll
            if (point_in_rectangle(mouse_wx,mouse_wy,dx-20,dy-20,dx+20,dy+20)) {
                add_tile()
            }
        }
        h=mouse_wheel_down()-mouse_wheel_up()
        tpalscrollgo-=h*120
    }
    tpalscrollgo=clamp(tpalscrollgo,-(tpalsize div 4+1)*40+(height-152-216),0)
    tpalscroll=clamp(inch((tpalscroll*4+tpalscrollgo)/5,tpalscrollgo,2),-(tpalsize div 4+1)*40+(height-152-216),0)

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
    layerscrollgo=clamp(layerscrollgo,-(layersize+1)*32+(height-56-100),0)
    layerscroll=clamp(inch((layerscroll*4+layerscrollgo)/5,layerscrollgo,2),-(layersize+1)*32+(height-56-100),0)
}
