bgnametooltip=""

if (mode==1) {
    //palette
    posx=0
    posy=0
    paltooltip=0
    i=0 repeat (backgrounds_length) {
        if (bghastiles[i]) {
            tex=bg_background[i]
            dx=0
            dy=120+32*posy+tpalscroll
            draw_button_ext(dx,dy,160,32,tilebgpal!=i,global.col_main)
            draw_background(bgsmallicon[i],dx+8,dy+8)
            draw_set_color(global.col_text)
            str=ds_list_find_value(backgrounds,i)
            if (string_length(str)>12) {
                if (point_in_rectangle(mouse_wx,mouse_wy,dx,dy,dx+160,dy+32))
                bgnametooltip=str
                str=string_copy(str,1,9)+"..."
            }
            draw_text(dx+32,dy+6,str)
            draw_set_color($ffffff)
            posy+=1
        }
        i+=1
    }
    if (backgrounds_length) {
        dx=0
        dy=120+32*posy+tpalscroll
        draw_button_ext(dx,dy,160,32,1,global.col_main)
        draw_sprite(sprMenuButtons,23,dx+16,dy+16)
        draw_set_color(global.col_text)
        draw_text(dx+32,dy+6,"Add tileset")
        draw_set_color($ffffff)
    } else {
        draw_set_color(global.col_text)
        draw_text(8,158,"Project#contains no#backgrounds.")
        draw_set_color($ffffff)
    }

    with (tilepanel) draw_tile_panel()

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
    dy=360+i*32+layerscroll
    draw_button_ext(dx,dy,160,32,ly_current!=i,global.col_main)
    draw_sprite(sprMenuButtons,23,dx+16,dy+16)
    draw_set_color(global.col_text)
    draw_text(dx+32,dy+6,"Add layer")
    draw_set_color($ffffff)

    draw_button_ext(dx,304,160,32,1,global.col_main)
    draw_set_color(global.col_text)
    draw_text(dx+12,310,"Layers")
    draw_set_color($ffffff)

    draw_button_ext(dx,height-76,160,76,1,global.col_main)
    draw_set_color(global.col_text)
    draw_text(dx+12,height-64,"Depth")
    draw_set_color($ffffff)
}
