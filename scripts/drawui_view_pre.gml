if (view[4] || mode==3) {
    if (mode==3) rect(0,0,roomwidth,roomheight,0,0.5)
    d3d_transform_add_translation(-0.5,-0.5,0)
    for (i=0;i<8;i+=1) {
        if (vw_visible[i] || (vw_current==i && mode==3)) {
            dx=vw_x[i]+vw_w[i]
            dy=vw_y[i]+vw_h[i]
            if (vw_current==i && vw_visible[i] && mode==3) {
                draw_set_color($ff8000)
                draw_set_alpha(0.5)
                draw_roundrect(vw_x[i],vw_y[i],dx,dy,0)
                draw_set_alpha(1)
                draw_set_color_sel()
            }
            draw_roundrect(vw_x[i],vw_y[i],dx,dy,1)
            if (vw_current==i && mode==3) {
                draw_rectangle(dx-8*zm,dy-8*zm,dx+8*zm,dy+8*zm,1)
                draw_rectangle(dx-4*zm,dy-4*zm,dx+4*zm,dy+4*zm,1)
            }
            draw_set_color($ffffff)
            draw_text_transformed(vw_x[i]+8+0.5*zoom,vw_y[i]+8+0.5*zoom,"View "+string(i),zoom,zoom,0)
        }
    }
    d3d_transform_set_identity()
}
