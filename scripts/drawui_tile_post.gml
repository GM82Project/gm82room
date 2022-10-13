if (mode==1) {
    //palette
    posx=0
    posy=0
    paltooltip=0
    if (tilebgpal!=noone) {
        tex=bg_background[tilebgpal]
        map=bg_tilemap[tilebgpal]
        len=ds_map_size(map)

        key=ds_map_find_first(map)
        for (i=0;i<len;i+=1) {
            tile=ds_map_find_value(map,key)
            key=ds_map_find_next(map,key)
            dx=20+40*posx
            dy=172+40*posy+tpalscroll
            if (dy>132 && dy<height-196) {
                u=ds_list_find_value(tile,0)
                v=ds_list_find_value(tile,1)
                tw=ds_list_find_value(tile,2)
                th=ds_list_find_value(tile,3)
                draw_button_ext(dx-20,dy-20,40,40,tilepal!=i,pick(tilepal==i,global.col_main,$c0c0c0))
                if (tilepal==i) {
                    draw_set_color_sel()
                    draw_rectangle(dx-20,dy-20,dx+19,dy+19,1)
                    draw_set_color($ffffff)
                }
                if (!point_in_rectangle(mouse_wx,mouse_wy,dx-20,dy-20,dx+20,dy+20)) {
                    w=tw
                    h=th
                    if (w>h) {h=h/w*32 w=32} else {w=w/h*32 h=32}
                    draw_background_part_ext(tex,u,v,tw,th,dx-w/2,dy-h/2,w/tw,h/th,$ffffff,1)
                }
            }
            posx+=1 if (posx=4) {posx=0 posy+=1}
        }
    }
    if (backgrounds_length) {
        dx=20+40*posx
        dy=172+40*posy+tpalscroll
        draw_button_ext(dx-20,dy-20,40,40,1,global.col_main)
        draw_sprite(sprMenuButtons,24,dx,dy)
        if (mouse_wx<160 && mouse_wy>=152 && mouse_wy<height-216) {
            if (point_in_rectangle(mouse_wx,mouse_wy,dx-20,dy-20,dx+20,dy+20)) {
                paltooltip=1
            }
        }
    } else {
        draw_set_color(global.col_text)
        draw_text(8,158,"Project#contains no#backgrounds.")
        draw_set_color($ffffff)
    }

    draw_button_ext(0,height-192,160,192,1,global.col_main)
    draw_button_ext(4,height-160-28,152,152,0,global.col_main)

    if (tilebgpal!=noone && curtile!=noone) {
        u=ds_list_find_value(curtile,0)
        v=ds_list_find_value(curtile,1)
        tw=ds_list_find_value(curtile,2)
        th=ds_list_find_value(curtile,3)

        //cut up a preview rectangle around the selected tile
        bw=background_get_width(tex)
        bh=background_get_height(tex)

        nw=max(min(bw,144),tw)
        nh=max(min(bh,144),th)

        left=max(0,min(u+tw/2-nw/2,bw-nw))
        top=max(0,min(v+th/2-nh/2,bh-nh))
        lewidth=min(nw,bw-left)
        leheight=min(nh,bh-top)

        scale=min(1,144/max(lewidth,leheight))

        dx=8+72-lewidth/2*scale
        dy=height-184+72-leheight/2*scale
        draw_background_part_ext(tex,left,top,lewidth,leheight,dx,dy,scale,scale,$ffffff,1)
        draw_set_color_sel()
        draw_rectangle(dx+(u-left),dy+(v-top),dx+(u-left)+tw*scale-1,dy+(v-top)+th*scale-1,1)
        draw_set_color($ffffff)
    }

    //inspector

    dx=width-160

    draw_button_ext(dx,32,160,100,1,global.col_main)
    draw_button_ext(dx,128+4,160,100,1,global.col_main)
    draw_button_ext(dx,228+4,160,72,1,global.col_main)
    draw_set_color(global.col_text)
    draw_text(dx+12,32+8,"Position")
    draw_text(dx+12,128+12,"Scale")
    draw_text(dx+12,228+12,"Blend")
    draw_set_color($ffffff)

    for (i=0;i<layersize;i+=1) {
        dy=360+i*32+layerscroll
        if (dy>360-32 && dy<height-100+32) {
            draw_button_ext(dx,dy,160,32,ly_current!=i,global.col_main)
            draw_set_color(global.col_text)
            draw_text(dx+12,dy+6,ds_list_find_value(layers,i))
            draw_set_color($ffffff)
        }
    }
    draw_button_ext(dx,360+i*32+layerscroll,160,32,ly_current!=i,global.col_main)
    draw_sprite(sprMenuButtons,23,dx+80,360+i*32+layerscroll+16)

    draw_button_ext(dx,304,160,32,1,global.col_main)
    draw_set_color(global.col_text)
    draw_text(dx+12,310,"Layers")
    draw_set_color($ffffff)

    draw_button_ext(dx,height-76,160,76,1,global.col_main)
    draw_set_color(global.col_text)
    draw_text(dx+12,height-64,"Depth")
    draw_set_color($ffffff)
}
