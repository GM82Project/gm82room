if (mode=0) {
    //palette
    posx=0
    posy=0
    paltooltip=0
    for (i=0;i<objects_length;i+=1) if (objloaded[i]) {
        dx=20+40*posx
        dy=140+40*posy+palettescroll
        if (dy>100 && dy<height-80) {
            draw_button_ext(dx-20,dy-20,40,40,objpal!=i,pick(objpal==i,global.col_main,$c0c0c0))
            if (objpal==i) {
                draw_set_color_sel()
                draw_rectangle(dx-20,dy-20,dx+19,dy+19,1)
                draw_set_color($ffffff)
            }
            if (!point_in_rectangle(mouse_wx,mouse_wy,dx-20,dy-20,dx+20,dy+20)) {
                w=sprite_get_width(objspr[i])
                h=sprite_get_height(objspr[i])
                if (w>h) {h=h/w*32 w=32} else {w=w/h*32 h=32}
                draw_sprite_stretched(objspr[i],0,dx-w/2,dy-h/2,w,h)
            }
        }
        posx+=1 if (posx=4) {posx=0 posy+=1}
    }

    if (objects_length) {
        dx=20+40*posx
        dy=140+40*posy+palettescroll
        draw_button_ext(dx-20,dy-20,40,40,1,global.col_main)
        draw_sprite(sprMenuButtons,18,dx,dy)
        if (mouse_wx<160 && mouse_wy>120 && mouse_wy<height-136) {
            if (point_in_rectangle(mouse_wx,mouse_wy,dx-20,dy-20,dx+20,dy+20)) {
                paltooltip=1
            }
        }
    } else {
        draw_set_color(global.col_text)
        draw_text(8,126,"Project#contains no#objects.")
        draw_set_color($ffffff)
    }

    //inspector
    dx=width-160
    draw_button_ext(dx,32,160,100,1,global.col_main)
    draw_button_ext(dx,128+4,160,100,1,global.col_main)
    draw_button_ext(dx,228+4,160,72,1,global.col_main)
    draw_button_ext(dx,304,160,72,1,global.col_main)
    draw_set_color(global.col_text)
    draw_text(dx+12,32+8,"Position")
    draw_text(dx+12,128+12,"Scale")
    draw_text(dx+12,228+12,"Rotation")
    draw_text(dx+12,304+8,"Blend")
    draw_set_color($ffffff)

    //hotbar
    dx=width div 2 -40*4.5
    dy=height-32-32
    i=1 repeat (9) {
        obj=objhotbar[i]
        draw_button_ext(dx-20,dy-20,40,40,objpal!=obj,global.col_main)
        if (obj>=0) {
            w=sprite_get_width(objspr[obj])
            h=sprite_get_height(objspr[obj])
            if (w>h) {h=h/w*32 w=32} else {w=w/h*32 h=32}
            draw_sprite_stretched(objspr[obj],0,dx-w/2,dy-h/2,w,h)
        }
        dx+=40
    i+=1}
}
