if (tilebgpal!=noone) {
    tex=bg_background[tilebgpal]
    gx=bg_gridx[tilebgpal]
    gy=bg_gridy[tilebgpal]
    ox=bg_gridox[tilebgpal]
    oy=bg_gridoy[tilebgpal]
    sx=bg_gridsx[tilebgpal]
    sy=bg_gridsy[tilebgpal]

    bgw=background_get_width(tex)
    bgh=background_get_height(tex)
    left=0
    top=0
    dx=0
    dy=32

    drawing=0
    dragging=0

    scrollx=0
    scrolly=0

    startx=ox
    starty=oy
    endx=gx
    endy=gy

    finished=0

    while (mouse_check_direct(mb_left)) {
        sleep(16)
    }

    texture_set_interpolation(0)
    while (1) {
        draw_clear(global.col_main)
        draw_background_ext(tex,dx-scrollx,dy-scrolly,2,2,0,$ffffff,1)

        draw_set_color_sel()

        for (u=ox;u<bgw;u+=gx+sx)
            for (v=oy;v<bgh;v+=gy+sy)
                draw_rectangle(dx+u*2-scrollx,dy+v*2-scrolly,dx+(u+gx)*2-scrollx,dy+(v+gy)*2-scrolly,1)

        draw_set_color($ffffff)

        io_handle()
        mx=window_mouse_get_x()
        my=window_mouse_get_y()

        if (mouse_check_direct(mb_middle)) {
            if (!dragging) {
                dragging=1
                dragsx=mx+scrollx
                dragsy=my+scrolly
            }
        }
        if (dragging) {
            scrollx=max(0,min((dragsx-mx),bgw*2-(width-dx)))
            scrolly=max(0,min((dragsy-my),bgh*2-(height-dy)))
            if (!mouse_check_direct(mb_middle)) dragging=0
        }

        if (mouse_check_direct(mb_left)) {
            finished=0
            if (point_in_rectangle(mx,my,0,0,64,32)) {
                finished=-1
            }
            if (point_in_rectangle(mx,my,64,0,128,32)) {
                finished=-2
            }
            if (point_in_rectangle(mx,my,dx,dy,width-8,height-8) && !drawing) {
                drawing=1
                startx=floor((mx-dx+scrollx)/2)
                starty=floor((my-dy+scrolly)/2)
                if (!keyboard_check(vk_alt)) {
                    startx=floorto(startx-ox,gx+sx)+ox
                    starty=floorto(starty-oy,gy+sy)+oy
                }
            }
        } else {
            if (finished<0) finished=-finished
        }
        if (drawing) {
            endx=floor((mx-dx+scrollx)/2)
            endy=floor((my-dy+scrolly)/2)
            if (!keyboard_check(vk_alt)) {
                if (endx<startx) endx=floorto(endx-ox,gx+sx)+ox
                else endx=ceilto(endx-ox,gx+sx)+ox
                if (endy<starty) endy=floorto(endy-oy,gy+sy)+oy
                else endy=ceilto(endy-oy,gy+sy)+oy
                if (endx==startx) endx=startx-gx
                if (endy==starty) endy=starty-gy
            } else {
                if (endx==startx) endx=startx+1
                if (endy==starty) endy=starty+1
            }

            if (!mouse_check_direct(mb_left)) {
                drawing=0
                if (endx<startx) {temp=endx endx=startx startx=temp}
                if (endy<starty) {temp=endy endy=starty starty=temp}
            }
        }

        draw_set_color($ff8000)
        draw_set_alpha(0.5)
        draw_rectangle(dx-scrollx+startx*2,dy-scrolly+starty*2,dx-scrollx+endx*2,dy-scrolly+endy*2,0)
        draw_set_color($ffffff)
        draw_set_alpha(1)

        draw_button_ext(0,0,64,32,1-(finished==-1),global.col_main)
        draw_button_ext(64,0,64,32,1-(finished==-2),global.col_main)
        draw_sprite(sprMenuButtons,0,32,16)
        draw_sprite(sprMenuButtons,25,96,16)
        draw_button_ext(128,0,width-128,32,0,global.col_main)
        draw_set_color(global.col_text)
        draw_text(136,6,"Select tile region:")
        draw_set_color($ffffff)

        if (keyboard_check(vk_enter)) {
            finished=1
        }
        if (keyboard_check(vk_escape)) {
            finished=2
        }

        if (finished=1) {
            map=bg_tilemap[tilebgpal]
            tileid=string(startx)+","+string(starty)+","+string(endx-startx)+","+string(endy-starty)
            if (!ds_map_exists(map,tileid)) {
                //add this tile
                list=ds_list_create()
                ds_list_add(list,startx)
                ds_list_add(list,starty)
                ds_list_add(list,endx-startx)
                ds_list_add(list,endy-starty)
                ds_map_add(map,tileid,list)
            }
            tilepal=0
            key=ds_map_find_first(map)
            while (key!=tileid) {
                tilepal+=1
                key=ds_map_find_next(map,key)
            }
            curtile=ds_map_find_value(map,key)
        }
        if (finished) exit
        screen_refresh()
        sleep(16)
        io_clear()
    }
}
