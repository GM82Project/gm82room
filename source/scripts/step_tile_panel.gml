if (instance_position(mouse_wx,mouse_wy,id)) {
    yes=1 with (TextField) if (active) {yes=0}
    if (yes) {
        if (mouse_wheel_down() || keyboard_check_pressed(vk_subtract) || keyboard_check_pressed(vk_minus)) zgo=roundto(min(8,zgo*2),1/8)
        if (mouse_wheel_up() || keyboard_check_pressed(vk_add) || (keyboard_check_pressed(vk_equals))) zgo=roundto(max(1/8,zgo/2),1/8)
    }

    if (mouse_check_button_pressed(mb_left)) {
        //resize corner
        if (point_in_rectangle(mouse_wx,mouse_wy,x+w-36,y,x+w,y+36)) {
            grab=1
            offx=x+w-mouse_wx
            offy=y-mouse_wy
        }
    }
    if (tilebgpal!=noone) {
        if (point_in_rectangle(mouse_wx,mouse_wy,x+8,y+32+8,x+8+w-8-8,y+32+8+h-32-16)) {
            clickx=(mouse_wx-(x+8))*z+xgo-(w-16)*z/2
            clicky=(mouse_wy-(y+40))*z+ygo-(h-32-16)*z/2

            if ((clickx>=0 and clickx<bgw) and (clicky>=0 and clicky<bgh)) or (tiling) {
                //inside the background
                clickx=median(0,clickx,bgw)+0.5
                clicky=median(0,clicky,bgh)+0.5

                if (mouse_check_button(mb_left)) {
                    if (bg_tilemode[tilebgpal]) {
                        //smart mode
                        if (bg_tilemode[tilebgpal]!=6) if (mouse_check_button_pressed(mb_left) or tilemap_complete) {
                            clickx=floorto(min(clickx-ox,bgw-curtilew),gx+sx)+ox
                            clicky=floorto(min(clicky-oy,bgh-curtileh),gy+sy)+oy
                            tw=pick(bg_tilemode[tilebgpal]-1,1,2,3,4,7)
                            index=atcx+atcy*tw
                            if (index>27) index-=1 if (index>35) index-=1
                            ds_grid_set(bg_tilemap[tilebgpal],index,0,clickx)
                            ds_grid_set(bg_tilemap[tilebgpal],index,1,clicky)
                            check_tilemap_complete()
                            if (!tilemap_complete) {
                                atcx+=1 if (atcx>=tw) {atcx=0 atcy+=1}
                            }
                        }
                    } else {
                        //manual mode
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
                            if (curtileh==0) curtileh=gy
                        } else {
                            curtilex=floor(clickx)
                            curtiley=floor(clicky)
                            tiling=1
                        }
                    }
                } else {
                    tiling=0
                }
            } else {
                //outside the bg
                tiling=0
                hide_smartmap=0
                ref=pick(bg_tilemode[tilebgpal]-1,bgTiler2,bgTiler4,bgTiler9,bgTiler16,bgTiler47)
                mw=max(176,background_get_width(bg_background[tilebgpal])+32)
                if (mouse_check_button_pressed(mb_left)) {
                    //manual
                    if (point_in_rectangle(clickx,clicky,0,-64,80,-32)) {
                        bg_tilemode[tilebgpal]=-abs(bg_tilemode[tilebgpal])
                    }
                    //smart
                    if (point_in_rectangle(clickx,clicky,88,-64,88+80,-32)) {
                        bg_tilemode[tilebgpal]=max(1,abs(bg_tilemode[tilebgpal]))
                        clear_inspector()
                        deselect()
                    }
                    if (bg_tilemode[tilebgpal]) {
                        //modes
                        dx=mw if (point_in_rectangle(clickx,clicky,dx,-64,dx+40,-32)) change_tilesmart_mode(1)
                        dx=mw+48 if (point_in_rectangle(clickx,clicky,dx,-64,dx+40,-32)) change_tilesmart_mode(2)
                        dx=mw+96 if (point_in_rectangle(clickx,clicky,dx,-64,dx+40,-32)) change_tilesmart_mode(3)
                        dx=mw+144 if (point_in_rectangle(clickx,clicky,dx,-64,dx+40,-32)) change_tilesmart_mode(4)
                        dx=mw+192 if (point_in_rectangle(clickx,clicky,dx,-64,dx+40,-32)) change_tilesmart_mode(5)
                        dx=mw+240 if (point_in_rectangle(clickx,clicky,dx,-64,dx+40,-32)) change_tilesmart_mode(6)
                    }
                }
                if (mouse_check_button(mb_left) and bg_tilemode[tilebgpal]) {
                    dx=mw dy=background_get_height(ref)*(gy/32)+32
                    if (bg_tilemode[tilebgpal]!=6) {
                        if (point_in_rectangle(clickx,clicky,dx,dy,dx+64,dy+32)) hide_smartmap=1
                        dx=mw+72 if (mouse_check_button_pressed(mb_left)) if (point_in_rectangle(clickx,clicky,dx,dy,dx+64,dy+32)) fill_tilesmart_copy()
                        dx=mw+144 if (mouse_check_button_pressed(mb_left)) if (point_in_rectangle(clickx,clicky,dx,dy,dx+64,dy+32)) {
                            if (show_question("Are you sure you want to clear the tile map?")) {
                                ds_grid_set_region(bg_tilemap[tilebgpal],0,0,46,1,noone)
                                tilemap_complete=0
                                atcx=0
                                atcy=0
                            }
                        }

                        //sheet click
                        if (point_in_rectangle(clickx,clicky,mw,0,mw+background_get_width(ref),background_get_height(ref))) {
                            px=atcx py=atcy
                            atcx=(clickx-mw) div gx
                            atcy=clicky div gy
                            //forbid the holes in a 47tile
                            if (atcx==6 and atcy==3) {atcx=px atcy=py}
                            if (atcx==1 and atcy==5) {atcx=px atcy=py}
                        }
                    }
                }
            }
        }
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
    if (!direct_mbleft) {
        grab=0
    }
    with (Button) {
        if (anchor==4) y=height-Tilepanel.h-32-24
        if (anchor==5) y=height-Tilepanel.h-32+4
    }
}
zo=z
z=approach(z,zgo,z/8)

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
    tex=bg_background[tilebgpal]

    if (bg_tilemode[tilebgpal]) {
        xgo=median(0,xgo,max(176,background_get_width(tex)+32)+224)
        ygo=median(-64,ygo,max(background_get_height(tex),224))
    } else {
        xgo=median(0,xgo,background_get_width(tex))
        ygo=median(0,ygo,background_get_height(tex))
    }

    if (bg_tilemode[tilebgpal] and mousein) {
        if (tilemap_complete) current_cursor=cr_uparrow
        else current_cursor=cr_no
    }
}
