var l,t,r,b;

endstep()

if (powersave) sel_alpha=0.5
else sel_alpha=0.5+0.25*sin(current_time/200)

draw_backgrounds(1)
draw_reference(1)

if (mode!=5) draw_paths()

d3d_transform_set_identity()
d3d_end()
d3d_set_projection_default()
d3d_set_depth(0)

if (mode==5) {
    fmx=roundto(global.mousex,gridx)
    fmy=roundto(global.mousey,gridy)
} else {
    fmx=floorto(global.mousex,gridx)
    fmy=floorto(global.mousey,gridy)
}
tty=0

focus=noone
if (mousein) {
    if (mode==0) focus=instance_position(global.mousex,global.mousey,instance)
    if (mode==1) focus=instance_position(global.mousex,global.mousey,tileholder)
}


//cursor for object, tile and path mode
if (mode==0 || mode==1 || mode==5) {
    if (keyboard_check_direct(vk_control)) window_set_cursor(cr_size_all)
    else if (keyboard_check_direct(vk_shift)) window_set_cursor(cr_cross)
    else window_set_cursor(current_cursor)
} else window_set_cursor(cr_default)


//draw grid
d3d_transform_add_translation(-0.5,-0.5,0)
draw_set_blend_mode_ext(10,1)
texture_set_interpolation(1)

d3d_primitive_begin(pr_linelist)
    if (grid) {
        if (mousein && outroomgrid) {
            x1=max(min(fmx,0),roundto(view_xview,gridx))
            y1=max(min(fmy,0),roundto(view_yview,gridy))
            x2=min(max(roomwidth,fmx+gridx),view_xview+view_wview)
            y2=min(max(roomheight,fmy+gridy),view_yview+view_hview)
        } else {
            x1=max(0,roundto(view_xview,gridx))
            y1=max(0,roundto(view_yview,gridy))
            x2=min(roomwidth,view_xview+view_wview)
            y2=min(roomheight,view_yview+view_hview)
        }
        vc=0
        for (i=x1;i<=x2;i+=gridx) {d3d_vertex(i,y1,0) d3d_vertex(i,y2,0) vc+=2 if (vc>31000) {vc=0 d3d_primitive_end() draw_set_blend_mode(bm_add) d3d_set_fog(1,$202020,0,0) d3d_primitive_end() d3d_set_fog(0,0,0,0) draw_set_blend_mode(0) d3d_primitive_begin(pr_linelist)}}
        for (i=y1;i<=y2;i+=gridy) {d3d_vertex(x1,i,0) d3d_vertex(x2,i,0) vc+=2 if (vc>31000) {vc=0 d3d_primitive_end() draw_set_blend_mode(bm_add) d3d_set_fog(1,$202020,0,0) d3d_primitive_end() d3d_set_fog(0,0,0,0) draw_set_blend_mode(0) d3d_primitive_begin(pr_linelist)}}
    }
    if (crosshair && mousein) {
        if (keyboard_check(vk_alt)) {
            d3d_vertex(global.mousex,min(0,global.mousey),0) d3d_vertex(global.mousex,max(roomheight,global.mousey),0)
            d3d_vertex(min(0,global.mousex),global.mousey,0) d3d_vertex(max(roomwidth,global.mousex),global.mousey,0)
            dx=global.mousex
            dy=global.mousey
        } else {
            d3d_vertex(fmx,fmy+gridy,0) d3d_vertex(fmx+gridx,fmy+gridy,0)
            d3d_vertex(fmx+gridx,fmy,0) d3d_vertex(fmx+gridx,fmy+gridy,0)
            d3d_vertex(fmx,min(0,fmy),0) d3d_vertex(fmx,max(roomheight,fmy),0)
            d3d_vertex(min(0,fmx),fmy,0) d3d_vertex(max(roomwidth,fmx),fmy,0)
            dx=fmx
            dy=fmy
        }
        if (dx>roomwidth) {
            d3d_vertex(dx,0,0) d3d_vertex(max(roomwidth,dx-gridx),0,0)
            d3d_vertex(dx,roomheight,0) d3d_vertex(max(roomwidth,dx-gridx),roomheight,0)
        }
        if (dx<0) {
            d3d_vertex(dx,0,0) d3d_vertex(min(0,dx+gridx),0,0)
            d3d_vertex(dx,roomheight,0) d3d_vertex(min(0,dx+gridx),roomheight,0)
        }
        if (dy>roomheight) {
            d3d_vertex(0,dy,0) d3d_vertex(0,max(roomheight,dy-gridy),0)
            d3d_vertex(roomwidth,dy,0) d3d_vertex(roomwidth,max(roomheight,dy-gridy),0)
        }
        if (dy<0) {
            d3d_vertex(0,dy,0) d3d_vertex(0,min(0,dy+gridy),0)
            d3d_vertex(roomwidth,dy,0) d3d_vertex(roomwidth,min(0,dy+gridy),0)
        }
    }
d3d_primitive_end()
draw_set_blend_mode(bm_add)
d3d_set_fog(1,$202020,0,0)
d3d_primitive_end()
d3d_set_fog(0,0,0,0)
draw_set_blend_mode(0)
d3d_transform_set_identity()

//draw screen grid
if (screen_grid_draw) {
    d3d_transform_add_translation(-0.5,-0.5,0)

    d3d_primitive_begin(pr_linelist)
    x1=max(0,roundto(view_xview,screen_grid_width))
    y1=max(0,roundto(view_yview,screen_grid_height))
    x2=min(roomwidth,view_xview+view_wview)
    y2=min(roomheight,view_yview+view_hview)

    vc=0
    for (i=screen_grid_width;i<=x2;i+=screen_grid_width) {d3d_vertex(i,y1,0) d3d_vertex(i,y2,0) vc+=2 if (vc>31000) {vc=0
        d3d_set_fog(1,0,0,0)
        d3d_transform_add_translation(-zm,-zm,0)
        d3d_primitive_end()
        d3d_transform_add_translation(2*zm,2*zm,0)
        d3d_primitive_end()
        d3d_transform_add_translation(-zm,-zm,0)
        d3d_set_fog(1,$ffffff,0,0)
        d3d_primitive_end()
        d3d_primitive_begin(pr_linelist)
    }}
    for (i=screen_grid_height;i<=y2;i+=screen_grid_height) {d3d_vertex(x1,i,0) d3d_vertex(x2,i,0) vc+=2 if (vc>31000) {vc=0
        d3d_set_fog(1,0,0,0)
        d3d_transform_add_translation(-zm,-zm,0)
        d3d_primitive_end()
        d3d_transform_add_translation(2*zm,2*zm,0)
        d3d_primitive_end()
        d3d_transform_add_translation(-zm,-zm,0)
        d3d_set_fog(1,$ffffff,0,0)
        d3d_primitive_end()
        d3d_primitive_begin(pr_linelist)
    }}

    d3d_set_fog(1,0,0,0)
    d3d_transform_add_translation(-zm,-zm,0)
    d3d_primitive_end()
    d3d_transform_add_translation(2*zm,2*zm,0)
    d3d_primitive_end()
    d3d_transform_add_translation(-zm,-zm,0)
    d3d_set_fog(1,$ffffff,0,0)
    d3d_primitive_end()
    d3d_set_fog(0,0,0,0)
    d3d_transform_set_identity()
}

drawui_object_pre()
drawui_tile_pre()
if (mode==5) draw_paths()
drawui_path_pre()

//selection rectangle
if (selecting) {
    draw_set_color($ff8000)
    draw_set_alpha(0.5)
    l=min(selx,global.mousex)-0.5
    t=min(sely,global.mousey)-0.5
    r=max(selx,global.mousex)+0.5
    b=max(sely,global.mousey)+0.5
    draw_rectangle(l,t,r,b,0)
    draw_set_color_sel()
    draw_rectangle(l,t,r,b,1)
    draw_set_alpha(1)
    draw_set_color($ffffff)
}


//draw clipboard dimensions
if (keyboard_check(vk_control) && !keyboard_check(vk_shift) && copyvec[0,0]) {
    draw_set_color($ff8000)
    draw_set_alpha(0.5)
    if (keyboard_check(vk_alt)) draw_rectangle(global.mousex-0.5,global.mousey-0.5,global.mousex+copyvec[0,3]-copyvec[0,1]-0.5,global.mousey+copyvec[0,4]-copyvec[0,2]-0.5,1)
    else draw_rectangle(fmx+copyvec[0,5]-0.5,fmy+copyvec[0,6]-0.5,fmx+copyvec[0,5]+copyvec[0,3]-copyvec[0,1]-0.5,fmy+copyvec[0,6]+copyvec[0,4]-copyvec[0,2]-0.5,1)
    draw_set_alpha(1)
    draw_set_color($ffffff)
}


//draw bounding selection rectangle
if (selection) {
    dx=selleft+selwidth-0.5
    dy=seltop+selheight-0.5
    draw_set_alpha(1)
    draw_set_color_sel()
    draw_roundrect(min(selleft-0.5,dx),min(seltop-0.5,dy),max(selleft-0.5,dx),max(seltop-0.5,dy),1)
    draw_rectangle(dx-8*zm,dy-8*zm,dx+8*zm,dy+8*zm,1)
    draw_rectangle(dx-4*zm,dy-4*zm,dx+4*zm,dy+4*zm,1)
}

drawui_view_pre()
drawui_settings_pre()

//this is where the room space ends and the hud space starts================================================
d3d_set_projection_ortho(0,0,width,height,0)
shader_reset()

if (messagetime>0) {
    draw_set_alpha(messagetime)
    draw_set_halign(2)
    draw_text_outline(width-160-16,48,messagestr,$ffff)
    draw_set_halign(0)
    draw_set_alpha(1)
}

actionx=160
actiony=0
actionw=width-320
actionh=32

rect(0,0,160,height,global.col_main,1)
rect(160,0,width-320,32,global.col_main,1)
var left;left=160+Instancepanel.w*Instancepanel.open
draw_button_ext(left,32,width-160-left,height-64,0,noone)

drawui_statusbar()

//draw inspector rectangle after statusbar to hide any leaking text
rect(width-160,0,160,height,global.col_main,1)

drawui_object_post()
drawui_tile_post()
drawui_bg_post()
drawui_view_post()
drawui_settings_post()
drawui_path()

drawui_top_layer()
