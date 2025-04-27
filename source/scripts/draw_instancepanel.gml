if (open) {
    if (update_scheduled) event_user(0)

    draw_button_ext(x,y,w-32,32,1,global.col_main)
    draw_button_ext(x+w-32,y,32,32,!grab,global.col_main)
    draw_button_ext(x,y+56,w,h-148,0,global.col_main)
    draw_sprite(sprMenuButtons,36,x+w-16,y+16)

    draw_set_color(global.col_text)
    draw_set_valign(1)
    draw_text(x+8,y+16,"Instance List")

    begin_trim(x+8-2,y+56+8-2,w-8-8+4,h-148-8-8+4)

    dx=2
    dy=2
    i=scroll repeat (showlength) {
        sw=sprite_get_width(sprite[i])
        sh=sprite_get_height(sprite[i])
        if (sw>sh) {sh=sh/sw*16 sw=16} else {sw=sw/sh*16 sh=16}
        if (inst[i].sel) draw_rect(dx-2,dy-2,w,20,$ff8000)
        draw_sprite_stretched(sprite[i],0,dx+8-sw/2,dy+8-sh/2,sw,sh)
        draw_text(dx+20,dy+8,name[i])
        dy+=20
    i+=1}

    end_trim()

    draw_set_valign(0)
    draw_set_color($ffffff)

    draw_button_ext(x,y+h-68,w,68,1,global.col_main)
}
