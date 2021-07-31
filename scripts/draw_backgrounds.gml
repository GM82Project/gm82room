///draw_backgrounds(foregrounds)
if (!argument0) {
    if (clearscreen) rect(0,0,roomwidth,roomheight,background_color,1)
    else rect(0,0,roomwidth,roomheight,fillcolor,1)
}

if ((view[2] && !argument0) || (view[3] && argument0)) for (i=0;i<8;i+=1) if (bg_source[i]!="" && bg_visible[i] && bg_is_foreground[i]==argument0) {
    bg=bg_tex[i]
    w=background_get_width(bg)
    h=background_get_height(bg)

    if (bg_stretch[i]) {
        l=0
        r=roomwidth
        t=0
        b=roomheight
        u=0
        u2=1
        v=0
        v2=1
        if (bg_tile_h[i]) {
           u=-bg_xoffset[i]/r
           u2+=u
        } else {
            l+=bg_xoffset[i]
            r+=l
        }
        if (bg_tile_v[i]) {
           v=-bg_yoffset[i]/b
           v2+=v
        } else {
            t+=bg_yoffset[i]
            b+=t
        }
    } else {
        if (bg_tile_h[i]) {
            l=0
            r=roomwidth
            u=-bg_xoffset[i]/w
            u2=u+r/w
        } else {
            l=bg_xoffset[i]
            r=l+w
            u=0
            u2=1
        }
        if (bg_tile_v[i]) {
            t=0
            b=roomheight
            v=-bg_yoffset[i]/h
            v2=v+b/h
        } else {
            t=bg_yoffset[i]
            b=t+h
            v=0
            v2=1
        }
    }

    texture_set_repeat(1)
    draw_primitive_begin_texture(pr_trianglestrip,background_get_texture(bg))
        draw_vertex_texture(l-0.5,t-0.5,u,v)
        draw_vertex_texture(r-0.5,t-0.5,u2,v)
        draw_vertex_texture(l-0.5,b-0.5,u,v2)
        draw_vertex_texture(r-0.5,b-0.5,u2,v2)
    draw_primitive_end()
}
