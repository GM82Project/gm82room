var yes,cur,minselx,maxselx,minsely,maxsely,dx,dy;

if (resizecount<10) {
    if (window_get_width()!=width || window_get_height()!=height) {
        with (Button) {
            if (anchor==1 || anchor==3) offx=width-x
            if (anchor==2 || anchor==3) offy=height-y
        }
        width=max(min_width,window_get_width())
        height=max(min_height,window_get_height())
        window_set_size(width,height)
        window_set_region_size(width,height,0)
        window_resize_buffer(width,height)
        view_wport[0]=width
        view_hport[0]=height
        with (Button) {
            if (anchor==1 || anchor==3) x=width-offx
            if (anchor==2 || anchor==3) y=height-offy
        }
        resizecount+=1
        if (resizecount>=10) show_message("Resizing the window failed multiple times. Do you have some sort of weird DPI settings? Either way, I'm disabling resizing for now.")
    } else resizecount=0
}

mouse_wx=window_mouse_get_x()
mouse_wy=window_mouse_get_y()
mousein=(point_in_rectangle(mouse_wx,mouse_wy,160,32,width-160,height-32))


//clipboard!
if (keyboard_check(vk_control) && keyboard_check_pressed(ord("A"))) with (instance) sel=1
if (keyboard_check(vk_control) && keyboard_check_pressed(ord("C")) || keyboard_check_pressed(ord("X"))) {
    cur=0
    minselx=99999999
    minsely=99999999
    maxselx=-minselx
    maxsely=-minsely
    yes=(keyboard_check_pressed(ord("X")))
    with (instance) if (sel) {
        minselx=min(minselx,bbox_left)
        minsely=min(minsely,bbox_top)
        maxselx=max(maxselx,bbox_right+1)
        maxsely=max(maxsely,bbox_bottom+1)
        cur+=1
        copyvec[cur,0]=objname
        copyvec[cur,1]=obj
        copyvec[cur,2]=x
        copyvec[cur,3]=y
        copyvec[cur,4]=image_xscale
        copyvec[cur,5]=image_yscale
        copyvec[cur,6]=image_angle
        copyvec[cur,7]=image_blend
        copyvec[cur,8]=image_alpha
        copyvec[cur,9]=code
        if (yes) instance_destroy()
    }
    copyvec[0,0]=cur
    copyvec[0,1]=minselx
    copyvec[0,2]=minsely
    copyvec[0,3]=maxselx
    copyvec[0,4]=maxsely
}
if (keyboard_check(vk_control) && keyboard_check_pressed(ord("V"))) {
    yes=copyvec[0,0]
    with (TextField) if (active) yes=0
    if (yes) {
        with (instance) sel=0
        if (keyboard_check(vk_alt)) {
            dx=mouse_x-copyvec[0,1]
            dy=mouse_y-copyvec[0,2]
        } else {
            dx=floorto(mouse_x-copyvec[0,1],gridx)
            dy=floorto(mouse_y-copyvec[0,2],gridy)
        }

        cur=1
        repeat (copyvec[0,0]) {
            //note: if you have instances copied that would be invisible in the current view, they'l be visible anyway
            o=instance_create(copyvec[cur,2]+dx,copyvec[cur,3]+dy,instance)
            o.obj=copyvec[cur,1]
            o.objname=copyvec[cur,0]
            o.sprite_index=objspr[o.obj]
            o.sprw=sprite_get_width(o.sprite_index)
            o.sprh=sprite_get_height(o.sprite_index)
            o.sprox=sprite_get_xoffset(o.sprite_index)
            o.sproy=sprite_get_yoffset(o.sprite_index)
            o.image_xscale=copyvec[cur,4]
            o.image_yscale=copyvec[cur,5]
            o.image_angle=copyvec[cur,6]
            o.image_blend=copyvec[cur,7]
            o.image_alpha=copyvec[cur,8]
            o.code=copyvec[cur,9]
            o.sel=1
            select=o
            cur+=1
        }
    }
}


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
                } else if (point_distance(rothandx,rothandy,mouse_x,mouse_y)<10) {
                    rotato=1
                    yes=1
                } else if (abs(mouse_x-draghandx)<8 && abs(mouse_y-draghandy)<8) {
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
                        selx=mouse_x
                        sely=mouse_y
                    } else {
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
        }
    }
    if (!mouse_check_direct(mb_left)) selecting=0
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
                with (o) update_inspector()
            }
        }
    }
    if (!mouse_check_direct(mb_left)) paint=0
}


if (keyboard_check_pressed(vk_escape)) {
    with (TextField) textfield_actions()
    clear_inspector()
    select=noone
    if (mode==0) with (instance) sel=0
}

if (keyboard_check_pressed(vk_delete)) {
    clear_inspector()
    select=noone
    if (mode==0) with (instance) if (sel) instance_destroy()
}


if (mouse_check_direct(mb_right)) {
    //cancel selection
    if (selecting) selecting=0
    clear_inspector()
    select=noone
    if (mode==0) with (instance) sel=0

    //delete instances
    if (!mouse_check_direct(mb_left)) {
        if (mode==0) instance_destroy_id(instance_position(mouse_x,mouse_y,instance))
    }
}


//object mode
if (mode==0) {
    //palette controls
    if (mouse_wx<160 && mouse_wy>=120 && mouse_wy<height-100) {
        if (mouse_check_button_pressed(mb_left)) {
            posx=0
            posy=0
            for (i=0;i<objects_length;i+=1) if (objloaded[i]) {
                dx=20+40*posx
                dy=140+40*posy+palettescroll
                if (point_in_rectangle(mouse_wx,mouse_wy,dx-16,dy-16,dx+16,dy+16)) {
                    objpal=i
                    change_mode(mode)
                    textfield_set("palette name",ds_list_find_value(objects,objpal))
                }
                posx+=1 if (posx=4) {posx=0 posy+=1}
            }
            dx=20+40*posx
            dy=140+40*posy+palettescroll
            if (point_in_rectangle(mouse_wx,mouse_wy,dx-16,dy-16,dx+16,dy+16)) {
                //clicked on add object button
                paladdbuttondown=1
                screen_redraw()
                paladdbuttondown=0
                N_Menu_ShowPopupMenu(window_handle(),objmenu,window_get_x()+mouse_wx,window_get_y()+mouse_wy,0)
                menutype="object"
            }
        }
        h=mouse_wheel_down()-mouse_wheel_up()
        palettescrollgo-=h*80
    }
    palettescrollgo=clamp(palettescrollgo,-(palettesize div 4+1)*40+(height-120-100),0)
    palettescroll=clamp(inch((palettescroll*4+palettescrollgo)/5,palettescrollgo,2),-(palettesize div 4+1)*40+(height-120-100),0)
}


//tile mode
if (mode==1) {
    //tile palette
    if (mouse_wx<160 && mouse_wy>=152 && mouse_wy<height-216) {
        if (mouse_check_button_pressed(mb_left)) {
            //click on tile palette
            map=bg_tilemap[tilebgpal]
            len=ds_map_size(map)
            posx=0
            posy=0
            for (i=0;i<len;i+=1) {
                dx=20+40*posx
                dy=172+40*posy+tpalscroll
                if (point_in_rectangle(mouse_wx,mouse_wy,dx-16,dy-16,dx+16,dy+16)) {
                    tilepal=i
                    key=ds_map_find_first(map)
                    repeat (tilepal) key=ds_map_find_next(map,key)
                    curtile=ds_map_find_value(map,key)
                }
                posx+=1 if (posx=4) {posx=0 posy+=1}
            }
            dx=20+40*posx
            dy=172+40*posy+tpalscroll
            if (point_in_rectangle(mouse_wx,mouse_wy,dx-16,dy-16,dx+16,dy+16)) {
                //clicked on add tile button
                show_message("add tile")
            }
        }
        h=mouse_wheel_down()-mouse_wheel_up()
        tpalscrollgo-=h*80
    }
    tpalscrollgo=clamp(tpalscrollgo,-(tpalsize+1)*32+(height-152-216),0)
    tpalscroll=clamp(inch((tpalscroll*4+tpalscrollgo)/5,tpalscrollgo,2),-(tpalsize+1)*32+(height-152-216),0)

    //layer inspector
    if (mouse_wx>=width-160 && mouse_wy>=56 && mouse_wy<height-100) {
        if (mouse_check_button_pressed(mb_left)) {
            //click on layer bar
            mem=ly_current
            ly_current=median(0,floor((mouse_wy-56-layerscroll)/32),layersize+1)
            if (ly_current==layersize+1) {
                //clicked ahead of the list
                ly_current=mem
            } else {
                if (ly_current==layersize) {
                    add_tile_layer()
                }
                change_mode(mode)
            }
        }
        h=mouse_wheel_down()-mouse_wheel_up()
        layerscrollgo-=h*80
    }
    layerscrollgo=clamp(layerscrollgo,-(layersize+1)*32+(height-56-100),0)
    layerscroll=clamp(inch((layerscroll*4+layerscrollgo)/5,layerscrollgo,2),-(layersize+1)*32+(height-56-100),0)
}


//view mode
if (mode==3) {
    //grabbed a view
    if (grabview) {
        if (keyboard_check(vk_alt)) {
            vw_x[vw_current]=mouse_x-offx
            vw_y[vw_current]=mouse_y-offy
        } else {
            vw_x[vw_current]=floorto(mouse_x-offx,gridx)
            vw_y[vw_current]=floorto(mouse_y-offy,gridy)
        }
        update_viewpanel()
        if (!mouse_check_direct(mb_left)) grabview=0
    }

    //resized a view
    if (sizeview) {
        if (keyboard_check(vk_alt)) {
            vw_w[vw_current]=max(1,mouse_x-vw_x[vw_current])
            vw_h[vw_current]=max(1,mouse_y-vw_y[vw_current])
        } else {
            vw_w[vw_current]=max(gridx,roundto(mouse_x,gridx)-vw_x[vw_current])
            vw_h[vw_current]=max(gridy,roundto(mouse_y,gridy)-vw_y[vw_current])
        }
        update_viewpanel()
        if (!mouse_check_direct(mb_left)) sizeview=0
    }
}


//context menu processing
click=N_Menu_CheckMenus()
if (click) {
    if (menutype=="object") {
        str=ds_map_find_value(objmenuitems,click)
        if (mode==0) {
            if (str!="<undefined>") {
                get_object(str)
                textfield_set("palette name",ds_list_find_value(objects,objpal))
            }
        }
        if (mode==3) {
            if (str=="<undefined>") {
                vw_follow[vw_current]=noone
                textfield_set("view follow","")
            } else {
                vw_follow[vw_current]=ds_map_find_value(objmenuitems,click)
                textfield_set("view follow",vw_follow[vw_current])
            }
        }
    }
    if (menutype=="background") {
        str=ds_map_find_value(bgmenuitems,click)
        if (str=="<undefined>") {
            bg_tex[bg_current]=bgDefault
            bg_source[bg_current]=""
            bg_visible[bg_current]=0
        } else {
            bg_tex[bg_current]=get_background(str)
            bg_source[bg_current]=str
            bg_visible[bg_current]=1
        }
        update_backgroundpanel()
    }
    if (menutype=="tilebg") {
        str=ds_map_find_value(bgmenuitems,click)
        if (str!="<undefined>") {
            get_background(str)
            tilebgpal=micro_optimization_bgid
            update_tilepanel()
        }
    }
}


//panning
if (mouse_check_button_pressed(mb_middle) || keyboard_check_pressed(vk_space)) {
    //yeah i know i called pan zooming but ok just think like youre zooming around im sorry
    zooming=1
    grabx=mouse_x
    graby=mouse_y
}
if (!mouse_check_direct(mb_middle) && !keyboard_check(vk_space)) {
    zooming=0
}
if (zooming) {
    xgo+=grabx-mouse_x
    ygo+=graby-mouse_y
}


//zooming

if (mousein) {
    if (mouse_wheel_down() || keyboard_check_pressed(vk_subtract) || keyboard_check_pressed(vk_minus)) {
        zoomgo*=1.2
        keyboard_clear(vk_subtract)
        keyboard_clear(vk_minus)
        zoomcenter=0
    }
    if (mouse_wheel_up() || keyboard_check_pressed(vk_add) || (keyboard_check_pressed(vk_equals))) {
        zoomgo/=1.2
        keyboard_clear(vk_add)
        keyboard_clear(vk_equals)
        zoomcenter=0
    }
}
if (keyboard_check_pressed(ord("0"))) {
    xgo=roomwidth/2
    ygo=roomheight/2
    zoomgo=1
    zoomcenter=1
}


zoomold=zoom
if (abs(zoom-1)<0.1) {
    if ((zoomgo>1 && zoom<1) || (zoomgo<1 && zoom>1) || (zoom==1 && zoomgo==1)) {
        zoomgo=1
        zoom=1
    }
}

zoomgo=median(1/8,zoomgo,32)
zoom=inch((zoom*9+zoomgo)/10,zoomgo,0.02)

if (!zoomcenter) {
    xgo-=(mouse_wx-width*0.5)*(zoom-zoomold)
    ygo-=(mouse_wy-height*0.5)*(zoom-zoomold)
}


update_view()
