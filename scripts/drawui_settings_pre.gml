if (mode==4) {
    rect(roomleft,roomtop,roomwidth-roomleft,roomheight-roomtop,0,0.5)
    d3d_transform_add_translation(-0.5,-0.5,0)
    draw_set_color_sel()
    draw_rectangle(roomleft,roomtop,roomwidth,roomheight,1)
    if (chunkcrop) {
        dx=chunkleft+chunkwidth
        dy=chunktop+chunkheight
        draw_set_color($ff8000)
        draw_set_alpha(0.5)
        draw_roundrect(chunkleft,chunktop,dx,dy,0)
        draw_set_alpha(1)
        draw_set_color_sel()
        draw_roundrect(chunkleft,chunktop,dx,dy,1)
        draw_resize_handle(dx,dy)
        if (chunkloaded) draw_text_transformed(chunkleft+8+0.5*zoom,chunktop+8+0.5*zoom,"Chunk loaded:#"+chunkname,zoom,zoom,0)
    } else {
        draw_resize_handle(roomleft,roomtop)
        draw_resize_handle(roomwidth,roomtop)
        draw_resize_handle(roomleft,roomheight)
        draw_resize_handle(roomwidth,roomheight)
    }
    draw_set_color($ffffff)
    d3d_transform_set_identity()
}
