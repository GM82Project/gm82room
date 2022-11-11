var dx,dy;

if (mode==1) {
    //tile palette
    with (tilepanel) {
        if (instance_position(mouse_wx,mouse_wy,id)) {
            if (mouse_wheel_down() || keyboard_check_pressed(vk_subtract) || keyboard_check_pressed(vk_minus)) zgo=roundto(min(8,zgo*2),1/8)
            if (mouse_wheel_up() || keyboard_check_pressed(vk_add) || (keyboard_check_pressed(vk_equals))) zgo=roundto(max(1/8,zgo/2),1/8)

            if (mouse_check_button_pressed(mb_left)) {
                if (point_in_rectangle(mouse_wx,mouse_wy,x+w-36,y,x+w,y+36)) {
                    grab=1
                    offx=x+w-mouse_wx
                    offy=y-mouse_wy
                }
            }
            if (mouse_check_button(mb_left)) {
                if (point_in_rectangle(mouse_wx,mouse_wy,x+8,y+32+8,x+8+w-8-8,y+32+8+h-32-16)) {
                    clickx=median(0,(mouse_wx-(x+8))*z+xgo-(w-16)*z/2,bgw)
                    clicky=median(0,(mouse_wy-(y+40))*z+ygo-(h-32-16)*z/2,bgh)
                    if (!keyboard_check(vk_alt)) {
                        if (keyboard_check(vk_shift) && tiling) {
                            clickx=min(bgw,ceilto(clickx-ox,gx+sx)+ox)
                            clicky=min(bgh,ceilto(clicky-oy,gy+sy)+oy)
                        } else {
                            clickx=floorto(min(clickx-ox,bgw-curtilew),gx+sx)+ox
                            clicky=floorto(min(clicky-oy,bgh-curtileh),gy+sy)+oy
                        }
                    } else {
                        if (keyboard_check(vk_shift)) {
                            curtilew=1
                            curtileh=1
                        } else {
                            clickx=min(clickx-ox,bgw-curtilew)
                            clicky=min(clicky-oy,bgh-curtileh)
                        }
                    }
                    if (keyboard_check(vk_shift) && tiling) {
                        if (sx==0) curtilew=ceil(max(0,clickx-curtilex))
                        if (sy==0) curtileh=ceil(max(0,clicky-curtiley))
                        if (curtilew==0) curtilew=gx
                        if (curtileh==0) curtileh=gx
                    } else {
                        curtilex=floor(clickx)
                        curtiley=floor(clicky)
                        tiling=1
                    }
                }
            } else {
                tiling=0
            }
        }
        if (grab) {
            ow=w
            w=max(248,min(width-160,mouse_wx+offx))
            if (w>width-160-16) w=width-160
            y=max(240,min(height-32-248,mouse_wy+offy))
            oh=h
            h=height-32-y
            image_xscale=w
            image_yscale=h
            if (!mouse_check_button(mb_left)) {
                grab=0
            }
            with (Button) {
                if (anchor==4) y=height-tilepanel.h-32-24
                if (anchor==5) y=height-tilepanel.h-32+4
            }
        }
        zo=z
        z=inch(z,zgo,z/8)

        if (z!=zo) {
            if (point_in_rectangle(mouse_wx,mouse_wy,x+8,y+32+8,x+8+w-8-8,y+32+8+h-32-16)) {
                //hell.
                xgo-=(((mouse_wx-(x+8))-((w-16)/2)))*(z-zo)
                ygo-=(((mouse_wy-(y+40))-((h-36-16)/2)))*(z-zo)
            }
        }

        if (panning) {
            xgo=(grabxgo+(grabx-mouse_wx)*z)
            ygo=(grabygo+(graby-mouse_wy)*z)

            if (!mouse_check_direct(mb_middle) && !keyboard_check(vk_space)) {
                panning=0
            }
        }

        if (tilebgpal!=noone) {
            tex=Controller.bg_background[tilebgpal]

            xgo=median(0,xgo,background_get_width(tex))
            ygo=median(0,ygo,background_get_height(tex))
        }
    }

    if (point_in_rectangle(mouse_wx,mouse_wy,0,120,160,tilepanel.y-24)) {
        posy=0
        if (backgrounds_length) {
            i=0 repeat (backgrounds_length) {
                if (bghastiles[i]) {
                    dx=0
                    dy=120+32*posy+tpalscroll
                    if (mouse_check_button_pressed(mb_left)) if (point_in_rectangle(mouse_wx,mouse_wy,dx,dy,dx+160,dy+32)) {
                        tilebgpal=i
                        update_newtilepanel()
                    }
                    posy+=1
                }
                i+=1
            }
            dx=0
            dy=120+32*posy+tpalscroll
            if (mouse_check_button_pressed(mb_left)) if (point_in_rectangle(mouse_wx,mouse_wy,dx,dy,dx+160,dy+32)) {
                N_Menu_ShowPopupMenu(window_handle(),bgmenu,window_get_x()+mouse_wx,window_get_y()+mouse_wy,0)
                Controller.menutype="tilebg"
            }
        }
        if (tilebgpal!=noone) {
            h=mouse_wheel_down()-mouse_wheel_up()
            tpalscrollgo-=h*96
        }
    }
    if (tilebgpal!=noone) {
        tpalscrollgo=clamp(tpalscrollgo,-(posy+1)*32+(tilepanel.y-24-120),0)
        tpalscroll=clamp(inch((tpalscroll*4+tpalscrollgo)/5,tpalscrollgo,2),-(posy+1)*32+(tilepanel.y-24-120),0)
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
    layerscrollgo=clamp(layerscrollgo,-(layersize+1)*32+(height-56-100),0)
    layerscroll=clamp(inch((layerscroll*4+layerscrollgo)/5,layerscrollgo,2),-(layersize+1)*32+(height-56-100),0)
}
