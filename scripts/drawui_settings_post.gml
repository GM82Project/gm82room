if (mode==4) {
    draw_button_ext(0,128,160,72,1,global.col_main)
    draw_button_ext(0,200,160,200,1,global.col_main)
    draw_button_ext(0,400,160,268,1,global.col_main)
    draw_set_color(global.col_text)
    draw_text(12,136,"Caption")
    draw_text(12,208,"Size")
    draw_text(12,273,"Speed")
    draw_text(12,408,"Reference")
    draw_text(12,505,"Angle")
    draw_text(12,473,"Alpha")
    draw_text(12,537,"Scale")
    draw_set_color($ffffff)

    dx=width-160
    draw_button_ext(dx,0,160,32,1,global.col_main)
    draw_button_ext(dx,32,160,148,1,global.col_main)
    draw_set_color(global.col_text)
    draw_text(dx+12,6,"Chunk tools")
    draw_set_color($ffffff)
}
