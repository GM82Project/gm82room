///draw_backgrounds(foregrounds)
var i,bg,w,h,blend,alpha,offx,offy,l,r,t,b,u,v,u2,v2;

if (!argument0) {
    d3d_set_depth(12000)
    d3d_set_hidden(0)
    if (clearscreen) rect(roomleft,roomtop,roomwidth-roomleft,roomheight-roomtop,backgroundcolor,1)
    else rect(roomleft,roomtop,roomwidth-roomleft,roomheight-roomtop,fillcolor,1)
} else d3d_set_depth(-12000)

if ((view[2] && !argument0) || (view[3] && argument0)) for (i=0;i<8;i+=1) if (bg_source[i]!="" && bg_visible[i] && bg_is_foreground[i]==argument0) {
    if (window_focused && view[9]) {
        //preview background speed
        if (bg_tile_h[i]) bg_scrollx[i]+=bg_hspeed[i]*roomspeed/room_speed else bg_scrollx[i]=0
        if (bg_tile_v[i]) bg_scrolly[i]+=bg_vspeed[i]*roomspeed/room_speed else bg_scrolly[i]=0
    } else {
        bg_scrollx[i]=0
        bg_scrolly[i]=0
    }

    bg=bg_tex[i]
    w=background_get_width(bg)*bg_xscale[i]
    h=background_get_height(bg)*bg_yscale[i]

    blend=bg_blend[i]
    alpha=bg_alpha[i]

    offx=bg_xoffset[i]+bg_scrollx[i]
    offy=bg_yoffset[i]+bg_scrolly[i]

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
           u=-offx/r
           u2+=u
        } else {
            l+=offx
            r+=l
        }
        if (bg_tile_v[i]) {
           v=-offy/b
           v2+=v
        } else {
            t+=offy
            b+=t
        }
    } else {
        if (bg_tile_h[i]) {
            l=0
            r=roomwidth
            u=-offx/w
            u2=u+r/w
        } else if (cropbackgrounds) {
            l=max(0,offx)
            r=min(roomwidth,offx+w)
            u=(l-offx)/w
            u2=u+(r-l)/w
        } else {
            l=offx
            r=l+w
            u=0
            u2=1
        }
        if (bg_tile_v[i]) {
            t=0
            b=roomheight
            v=-offy/h
            v2=v+b/h
        } else if (cropbackgrounds) {
            t=max(0,offy)
            b=min(roomheight,offy+h)
            v=(t-offy)/h
            v2=v+(b-t)/h
        } else {
            t=offy
            b=t+h
            v=0
            v2=1
        }
    }

    texture_set_repeat(1)
    draw_primitive_begin_texture(pr_trianglestrip,background_get_texture(bg))
        draw_vertex_texture_color(l-0.5,t-0.5,u,v,blend,alpha)
        draw_vertex_texture_color(r-0.5,t-0.5,u2,v,blend,alpha)
        draw_vertex_texture_color(l-0.5,b-0.5,u,v2,blend,alpha)
        draw_vertex_texture_color(r-0.5,b-0.5,u2,v2,blend,alpha)
    draw_primitive_end()
}

d3d_set_hidden(1)
