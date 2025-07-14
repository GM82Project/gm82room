if (mode==4) {
    rect(roomleft,roomtop,roomwidth-roomleft,roomheight-roomtop,0,0.5)
    d3d_transform_add_translation(-0.5,-0.5,0)
    draw_set_color_sel()
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
    } else if (ref_moving) {
        if (ref_loaded) {
            draw_circle(ref_x,ref_y,4*zm,1)
            draw_line(ref_x,ref_y-4*zm,ref_x,ref_y+4*zm)
            draw_line(ref_x-4*zm,ref_y,ref_x+4*zm,ref_y)

            draghandx=ref_x+pivot_pos_x(ref_w,ref_h,ref_angle)
            draghandy=ref_y+pivot_pos_y(ref_w,ref_h,ref_angle)

            if (grabref==1) w=point_distance(ref_x,ref_y,global.mousex,global.mousey)*sign(ref_w)
            else w=ref_w
            rothandx=ref_x+lengthdir_x(w,ref_angle)
            rothandy=ref_y+lengthdir_y(w,ref_angle)
            if (point_distance(rothandx,rothandy,draghandx,draghandy)<20*zm) {
                w=point_distance(ref_x,ref_y,draghandx,draghandy)+20*zm
                rothandx=ref_x+lengthdir_x(w,ref_angle)
                rothandy=ref_y+lengthdir_y(w,ref_angle)
            }

            if (grabref==1) draw_line(ref_x,ref_y,rothandx,rothandy)
            draw_circle(rothandx,rothandy,10*zm,1)
            draw_circle(rothandx,rothandy,5*zm,1)

            draw_quad_outline(ref_x,ref_y,ref_x+lengthdir_x(ref_w,ref_angle),ref_y+lengthdir_y(ref_w,ref_angle),draghandx,draghandy,ref_x+lengthdir_x(ref_h,ref_angle-90),ref_y+lengthdir_y(ref_h,ref_angle-90))
            draw_resize_handle(draghandx,draghandy)
        }
    } else {
        draw_rectangle(roomleft,roomtop,roomwidth,roomheight,1)

        draw_resize_handle(roomleft,roomtop)
        draw_resize_handle(roomwidth,roomtop)
        draw_resize_handle(roomleft,roomheight)
        draw_resize_handle(roomwidth,roomheight)
    }
    draw_set_color($ffffff)
    d3d_transform_set_identity()
}
