if (mode==5) {
    begin_trim(0,120,160,height-328-120)
        draw_set_color(global.col_text)

        dy=pathscroll i=0 repeat (pathnum) {
            if (dy>-32 && dy<height-328-120) {
                draw_button_ext(0,dy,160,32,(current_path!=paths[i,0]),noone)
                str=paths[i,1]
                if (string_length(str)>14) str=string_copy(str,1,11)+"..."
                draw_text(12,dy+6,str)
            }
        i+=1 dy+=32}

        draw_button_ext(0,dy,160,32,1,noone)
        draw_sprite(sprMenuButtons,39,16,dy+16)
        draw_text(32,dy+6,"Add path")

        draw_set_color($ffffff)
    end_trim()

    draw_button_ext(0,height-100-172,160,100,1,noone)

    draw_text(12,height-164+128-172,"Precision")


    draw_button_ext(0,height-276+4+100,160,172,1,noone)
    draw_text(12,height-276+16+100,"Point:")
    if (current_path!=noone) draw_text(18,height-276+76+100,"of "+string(path_get_number(current_path)))

    draw_text(12,height-180+46+100,"Speed")

    //inspector
    draw_button_ext(width-160,0,160,236,1,noone)
}
