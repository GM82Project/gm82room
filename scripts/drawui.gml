var yes;

draw_backgrounds(1)

fmx=floorto(mouse_x,gridx)
fmy=floorto(mouse_y,gridy)
tty=0

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
} else window_set_cursor(cr_default)

if (mode==0) {
    texture_set_interpolation(interpolation)
    with (instance) if (sel) {
        event_user(2)
    }
    texture_set_interpolation(1)

    with (Controller.select) {
        event_user(0)
    }

    if (keyboard_check(ord("C"))) with (instance) if (code!="") {
        d3d_set_fog(1,$ff,0,0)
        draw_rectangle(bbox_left,bbox_top,bbox_right+1,bbox_bottom+1,1)
        draw_sprite_ext(sprite_index,0,x,y,image_xscale,image_yscale,image_angle,image_blend,0.5)
        d3d_set_fog(0,0,0,0)
    }

    if (!keyboard_check(vk_control) && !keyboard_check(vk_shift)) {
        texture_set_interpolation(interpolation)
        if (keyboard_check(vk_alt)) draw_sprite_ext(objspr[objpal],0,mouse_x,mouse_y,1,1,0,$ffffff,0.25)
        else draw_sprite_ext(objspr[objpal],0,fmx,fmy,1,1,0,$ffffff,0.25)
        texture_set_interpolation(1)
    }
}

//selection rectangle
if (selecting) {
    draw_set_color($ff8000)
    draw_set_alpha(0.5)
    draw_rectangle(selx,sely,mouse_x,mouse_y,0)
    draw_rectangle(selx,sely,mouse_x,mouse_y,1)
    draw_set_alpha(1)
    draw_set_color($ffffff)
}

//draw clipboard dimensions
if (keyboard_check(vk_control) && !keyboard_check(vk_shift) && copyvec[0,0]) {
    draw_set_color($ff8000)
    draw_set_alpha(0.5)
    if (keyboard_check(vk_alt)) draw_rectangle(mouse_x,mouse_y,mouse_x+copyvec[0,3]-copyvec[0,1],mouse_y+copyvec[0,4]-copyvec[0,2],1)
    else draw_rectangle(fmx,fmy,fmx+copyvec[0,3]-copyvec[0,1],fmy+copyvec[0,4]-copyvec[0,2],1)
    draw_set_alpha(1)
    draw_set_color($ffffff)
}

//draw views
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
                draw_rectangle(dx-8,dy-8,dx+8,dy+8,1)
                draw_rectangle(dx-4,dy-4,dx+4,dy+4,1)
            }
            draw_set_color($ffffff)
            draw_text(vw_x[i]+8.5,vw_y[i]+8.5,"View "+string(i))
        }
    }
    d3d_transform_set_identity()
}

//this is where the room space ends and the hud space starts================================================
d3d_set_projection_ortho(0,0,width,height,0)

focus=noone
if (mode==0) with (instance) if (instance_position(mouse_x,mouse_y,id)) {
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
if (mode==0) {
    draw_text(statusx+152,statusy+6,string(instance_number(instance))+" instances")
    if (focus) draw_text(statusx+320,statusy+6,focus.objname+" "+string(focus.x)+","+string(focus.y)+pick(focus.code!="",""," Code"))
}

//draw object tab
if (mode=0) {
    //palette
    posx=0
    posy=0
    paltooltip=0
    for (i=0;i<objects_length;i+=1) if (objloaded[i]) {
        dx=40+40*posx
        dy=160+40*posy+palettescroll
        draw_button(dx-20,dy-20,40,40,objpal!=i)
        draw_sprite_stretched(objspr[i],0,dx-16,dy-16,32,32)
        if (posx=0) posx=1
        else if (posx=1) posx=2
        else {posx=0 posy+=1}
    }
    dx=40+40*posx
    dy=160+40*posy+palettescroll
    draw_button(dx-20,dy-20,40,40,!paladdbuttondown)
    draw_sprite(sprMenuButtons,18,dx,dy)
    if (mouse_wx<160 && mouse_wy>120 && mouse_wy<height-100) {
        if (point_in_rectangle(mouse_wx,mouse_wy,dx-16,dy-16,dx+16,dy+16)) {
            paltooltip=1
        }
    }

    //bottom panel
    draw_button(0,height-76,160,76,1)

    //draw inspector
    dx=width-160
    draw_button(dx,32,160,100,1)
    draw_button(dx,128+4,160,100,1)
    draw_button(dx,228+4,160,72,1)
    draw_button(dx,304,160,72,1)
    draw_text(dx+12,32+8,"Position")
    draw_text(dx+12,128+12,"Scale")
    draw_text(dx+12,228+12,"Rotation")
    draw_text(dx+12,304+8,"Blend")
}

//draw backgrounds tab
if (mode==2) {
    draw_button(0,96,160,40,1)
    draw_button(0,200,160,308,1)
    draw_text(12,384,"Position")
    draw_text(12,444,"Speed")
}

//draw views tab
if (mode==3) {
    draw_button(0,96,160,40,1)
    draw_button(0,200,160,348,1)
    draw_text(12,236,"Room")
    draw_text(12,328,"Window")
    draw_text(12,420,"Following")

    draw_button(width-160,0,160,216,1)
    draw_text(width-160+12,8,"Window")
    buttoncol=0
    draw_button(width-160+4,32,160-8,160-8,0)

    yes=0
    if (vw_enabled) {
        //first we calculate the total view bounding box
        l=max_int
        t=max_int
        r=0
        b=0
        for (i=0;i<8;i+=1) if (vw_visible[i]) {
            yes=1
            l=min(l,vw_xp[i])
            t=min(t,vw_yp[i])
            r=max(r,vw_xp[i]+vw_wp[i])
            b=max(b,vw_yp[i]+vw_hp[i])
        }
        w=r-l
        h=b-t
    } else {
        w=roomwidth
        h=roomheight
        yes=1
    }

    //viewport preview box
    draw_set_halign(1)
    draw_set_valign(1)
    if (yes) {
        if (w>h) {dh=h*144/w dw=144}
        else {dw=w*144/h dh=144}
        dx=width-80-dw/2
        dy=32+76-dh/2
        rect(dx,dy,dw,dh,$808080,1)
        if (vw_enabled) {
            //draw each view
            for (i=0;i<8;i+=1) if (vw_visible[i]) {
                draw_set_color(pick(vw_current==i,$ffffff,$ff8000))
                x1=dx+(vw_xp[i]-l)/w*dw
                y1=dy+(vw_yp[i]-t)/h*dh
                x2=dx+(vw_xp[i]+vw_wp[i]-l)/w*dw
                y2=dy+(vw_yp[i]+vw_hp[i]-t)/h*dh
                draw_rectangle(x1,y1,x2,y2,0)
                draw_set_color(0)
                draw_rectangle(x1,y1,x2,y2,1)
                draw_text(mean(x1,x2),mean(y1,y2),i)
                draw_set_color($ffffff)
            }
        } else {
            draw_text(width-80,32+76,"Whole Room")
        }
    } else {
        draw_text(width-80,32+76,"No views are#visible.##Game will#not display#correctly.")
    }
    draw_set_halign(0)
    draw_set_valign(0)
    if (yes) draw_text(width-160+12,188,string(w)+" x "+string(h))
}

//draw settings tab
if (mode==4) {
    draw_button(0,128,160,72,1)
    draw_button(0,200,160,164,1)
    draw_text(12,136,"Caption")
    draw_text(12,208,"Size")
    draw_text(12,273,"Speed")
}

with (Button) event_user(0)
with (Button) if (focus && alt!="" && (tagmode==mode || tagmode==-1)) drawtooltip(alt)

if (mode==0) {
    //object tab tooltips
    posx=0
    posy=0
    if (mouse_wy>120 && mouse_wy<height-100) for (i=0;i<objects_length;i+=1) if (objloaded[i]) {
        dx=40+40*posx
        dy=160+40*posy+palettescroll
        if (point_in_rectangle(mouse_wx,mouse_wy,dx-16,dy-16,dx+16,dy+16)) {
            drawtooltip(ds_list_find_value(objects,i))
        }
        if (posx=0) posx=1
        else if (posx=1) posx=2
        else {posx=0 posy+=1}
    }

    if (paltooltip && !paladdbuttondown) drawtooltip("Add more...")
}
