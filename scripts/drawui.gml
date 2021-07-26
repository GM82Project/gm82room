fmx=floorto(mouse_x,gridx)
fmy=floorto(mouse_y,gridy)
tty=0

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
            draw_vertex(mouse_x,min(0,mouse_y)) draw_vertex(mouse_x,max(roomheight,mouse_y))
            draw_vertex(min(0,mouse_x),mouse_y) draw_vertex(max(roomwidth,mouse_x),mouse_y)
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

with (instance) if (sel) {
    event_user(2)
}

with (Controller.select) {
    event_user(0)
}

focus=noone

if (keyboard_check(ord("C"))) with (instance) if (code!="") {
    rect(x-sprox,y-sproy,sprw,sprh,$ff,0.5)
}

if (selecting) {
    draw_set_color($ff8000)
    draw_set_alpha(0.5)
    draw_rectangle(selx,sely,mouse_x,mouse_y,0)
    draw_set_alpha(0.5)
    draw_rectangle(selx,sely,mouse_x,mouse_y,1)
    draw_set_color($ffffff)
}

d3d_set_projection_ortho(0,0,width,height,0)

with (instance) if (instance_position(mouse_x,mouse_y,id)) {
    other.focus=id
    if (code!="") {
        drawtooltip(code)
    }
}

actionx=160
actiony=0
actionw=width-320
actionh=32

statusx=160
statusy=height-32
statusw=width-320
statush=32

rect(0,0,160,height,global.col_main,1)
rect(160,0,width-320,32,global.col_main,1)
rect(width-160,0,160,height,global.col_main,1)
rect(160,height-32,width-320,32,global.col_main,1)

rect(160,32,4,height-64,global.col_low,1)
rect(160,32,width-320,4,global.col_low,1)

rect(width-160-4,32+4,4,height-64-4,global.col_high,1)
rect(160+4,height-32-4,width-320-4,4,global.col_high,1)

draw_triangle_color(160+4,height-32-4,160,height-32,160+4,height-32,global.col_high,global.col_high,global.col_high,0)
draw_triangle_color(width-160-4,32+4,width-160,32,width-160,32+4,global.col_high,global.col_high,global.col_high,0)

//draw statusbar
buttoncol=global.col_main
draw_button(statusx,height-32,144,32,0)
draw_button(statusx+144,height-32,168,32,0)
draw_button(statusx+312,height-32,width-320-312,32,0)
if (keyboard_check(vk_alt)) draw_text(statusx+8,statusy+6,string(mouse_x)+","+string(mouse_y))
else draw_text(statusx+8,statusy+6,string(fmx)+","+string(floorto(mouse_y,gridx)))
draw_text(statusx+152,statusy+6,string(instance_number(instance))+" instances")
if (focus) draw_text(statusx+320,statusy+6,focus.objname+" "+string(focus.x)+","+string(focus.y))

//draw object tab
if (mode=0) {
    //draw palette
    posx=0
    posy=0
    l=ds_list_size(objects)
    for (i=0;i<l;i+=1) if (objloaded[i]) {
        dx=40+40*posx
        dy=136+40*posy+palettescroll
        draw_button(dx-20,dy-20,40,40,objpal!=i)
        draw_sprite_stretched(objspr[i],0,dx-16,dy-16,32,32)
        if (posx=0) posx=1
        else if (posx=1) posx=2
        else {posx=0 posy+=1}
    }
    //bottom panel
    draw_button(0,height-160,160,160,0)
}

//draw inspector
dx=width-160
draw_button(dx,32,160,100,0)
draw_button(dx,128+4,160,100,0)
draw_button(dx,228+4,160,72,0)
draw_button(dx,304,160,72,0)

draw_text(dx+8,32+8,"Position")
draw_text(dx+8,128+12,"Scale")
draw_text(dx+8,228+12,"Rotation")
draw_text(dx+8,304+8,"Blend")


with (Button) event_user(0)
with (Button) if (focus && alt!="") drawtooltip(alt)

if (mode==0) {
    //object tab tooltips
    posx=0
    posy=0
    if (mouse_wy>96 && mouse_wy<height-160)for (i=0;i<l;i+=1) if (objloaded[i]) {
        dx=40+40*posx
        dy=136+40*posy+palettescroll
        if (point_in_rectangle(mouse_wx,mouse_wy,dx-16,dy-16,dx+16,dy+16)) {
            drawtooltip(ds_list_find_value(objects,i))
        }
        if (posx=0) posx=1
        else if (posx=1) posx=2
        else {posx=0 posy+=1}
    }
}
