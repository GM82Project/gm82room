var l,t,r,b;

endstep()

if (powersave) sel_alpha=0.5
else sel_alpha=0.5+0.25*sin(current_time/200)

draw_backgrounds(1)
draw_reference(1)

draw_paths()

d3d_transform_set_identity()
d3d_end()
d3d_set_projection_default()
d3d_set_depth(0)

fmx=floorto(global.mousex,gridx)
fmy=floorto(global.mousey,gridy)
tty=0

focus=noone
if (mousein) {
    if (mode==0) focus=instance_position(global.mousex,global.mousey,instance)
    if (mode==1) focus=instance_position(global.mousex,global.mousey,tileholder)
}

//grid and crosshair for object and tile mode
if (mode==0 || mode==1) {
    if (keyboard_check_direct(vk_control)) window_set_cursor(cr_size_all)
    else if (keyboard_check_direct(vk_shift)) window_set_cursor(cr_cross)
    else window_set_cursor(cr_default)

    d3d_transform_add_translation(-0.5,-0.5,0)
    texture_set_interpolation(1)

    draw_set_blend_mode_ext(10,1)
    draw_primitive_begin(pr_linelist)
        if (grid) {
            if (mousein) {
                x1=min(fmx,0)
                x2=max(roomwidth,fmx+gridx)
                y1=min(fmy,0)
                y2=max(roomheight,fmy+gridy)
            } else {
                x1=0
                y1=0
                x2=roomwidth
                y2=roomheight
            }
            vc=0
            for (i=x1;i<=x2;i+=gridx) {draw_vertex(i,y1) draw_vertex(i,y2) vc+=2 if (vc>998) {vc=0 draw_primitive_end() draw_primitive_begin(pr_linelist)}}
            for (i=y1;i<=y2;i+=gridy) {draw_vertex(x1,i) draw_vertex(x2,i) vc+=2 if (vc>998) {vc=0 draw_primitive_end() draw_primitive_begin(pr_linelist)}}
        }
        if (crosshair) {
            if (keyboard_check(vk_alt)) {
                draw_vertex(global.mousex,min(0,global.mousey)) draw_vertex(global.mousex,max(roomheight,global.mousey))
                draw_vertex(min(0,global.mousex),global.mousey) draw_vertex(max(roomwidth,global.mousex),global.mousey)
            } else {
                if (!grid) {
                    draw_vertex(fmx,fmy+gridy) draw_vertex(fmx+gridx,fmy+gridy)
                    draw_vertex(fmx+gridx,fmy) draw_vertex(fmx+gridx,fmy+gridy)
                    draw_vertex(fmx,min(0,fmy)) draw_vertex(fmx,max(roomheight,fmy))
                    draw_vertex(min(0,fmx),fmy) draw_vertex(max(roomwidth,fmx),fmy)
                }
            }
        }
    draw_primitive_end()
    draw_set_blend_mode(0)

    d3d_transform_set_identity()
} else window_set_cursor(cr_default)

drawui_object_pre()
drawui_tile_pre()

//selection rectangle
if (selecting) {
    draw_set_color($ff8000)
    draw_set_alpha(0.5)
    l=min(selx,global.mousex)-0.5
    t=min(sely,global.mousey)-0.5
    r=max(selx,global.mousex)+0.5
    b=max(sely,global.mousey)+0.5
    draw_rectangle(l,t,r,b,0)
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
draw_button_ext(160,32,width-320,height-64,0,noone)

drawui_statusbar()

//draw inspector rectangle after statusbar to hide any leaking text
rect(width-160,0,160,height,global.col_main,1)

drawui_object_post()
drawui_tile_post()
drawui_bg_post()
drawui_view_post()
drawui_settings_post()

drawui_top_layer()
