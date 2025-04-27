draw_button_ext(x,y,w,h,1,global.col_main)
draw_button_ext(x+w-36,y+4,32,32,!grab,global.col_main)
draw_sprite(sprMenuButtons,36,x+w-20,y+20)
draw_button_ext(x+4,y+36,w-8,h-36-4,0,global.col_main)

if (tilebgpal!=noone) {
    tex=bg_background[tilebgpal]
    bgw=background_get_width(tex)
    bgh=background_get_height(tex)
    d3d_set_viewport(x+8,y+32+8,w-16,h-32-16)
    d3d_set_projection_ortho(round(xgo-(w-16)*z/2),round(ygo-(h-32-16)*z/2),(w-16)*z,(h-32-16)*z,0)
    texture_set_interpolation(0)
    draw_set_color(global.col_text)
    draw_set_halign(1)
    draw_text(bgw/2,-24,ds_list_find_value(backgrounds,tilebgpal)+" - "+string(bgw)+"x"+string(bgh))
    draw_set_halign(0)
    draw_set_color($ffffff)
    draw_background(tex,0,0)
    texture_set_interpolation(1)

    //grid
    draw_set_blend_mode_ext(10,1)
    x1=ox
    y1=oy
    x2=background_get_width(tex)
    y2=background_get_height(tex)
    if (sx || sy) {
        for (u=x1;u<x2-gx;u+=gx+sx) for (v=y1;v<y2-gy;v+=gy+sy) {
            draw_rectangle(u-0.5,v-0.5,u+gx-0.5,v+gy-0.5,1)
        }
    } else {
        draw_primitive_begin(pr_linelist)
        if (tilepickgrid) {
            vc=0
            for (i=x1;i<=x2;i+=gx) {draw_vertex(i-0.5,y1-0.5) draw_vertex(i-0.5,y2-0.5) vc+=2 if (vc>998) {vc=0 draw_primitive_end() draw_primitive_begin(pr_linelist)}}
            for (i=y1;i<=y2;i+=gy) {draw_vertex(x1-0.5,i-0.5) draw_vertex(x2-0.5,i-0.5) vc+=2 if (vc>998) {vc=0 draw_primitive_end() draw_primitive_begin(pr_linelist)}}
        }
        draw_primitive_end()
    }
    draw_set_blend_mode(0)

    //current
    draw_set_color_sel()
    draw_rectangle(curtilex-0.5,curtiley-0.5,curtilex+curtilew-0.5,curtiley+curtileh-0.5,1)
    draw_set_color($ffffff)

    end_trim()
}
