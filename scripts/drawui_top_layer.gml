tooltiptext=""

if (mode==0) {
    //object tab tooltips
    posx=0
    posy=0
    if (mouse_wy>120 && mouse_wy<height-136) for (i=0;i<objects_length;i+=1) if (objloaded[i]) {
        dx=20+40*posx
        dy=140+40*posy+palettescroll
        if (point_in_rectangle(mouse_wx,mouse_wy,dx-20,dy-20,dx+20,dy+20)) {
            w=sprite_get_width(objspr[i])
            h=sprite_get_height(objspr[i])
            if (w>32 || h>32) {
                dx=floor(max(1,dx-w/2)+w/2)+frac(w/2)
                dy=floor(max(1,dy-h/2)+h/2)+frac(h/2)
                draw_set_color_sel() d3d_set_fog(1,draw_get_color(),0,0) draw_set_color($ffffff)
                draw_sprite_stretched_ext(objspr[i],0,dx-w/2+1,dy-h/2+1,w,h,0,1)
                draw_sprite_stretched_ext(objspr[i],0,dx-w/2+1,dy-h/2-1,w,h,0,1)
                draw_sprite_stretched_ext(objspr[i],0,dx-w/2-1,dy-h/2+1,w,h,0,1)
                draw_sprite_stretched_ext(objspr[i],0,dx-w/2-1,dy-h/2-1,w,h,0,1)
                d3d_set_fog(0,0,0,0)
            }
            draw_sprite_stretched(objspr[i],0,dx-w/2,dy-h/2,w,h)
            tooltiptext=ds_list_find_value(objects,i)
            if (objdesc[i]!="") tooltiptext=tooltiptext+lf+lf+objdesc[i]
        }
        posx+=1 if (posx=4) {posx=0 posy+=1}
    }

    if (paltooltip && !paladdbuttondown) tooltiptext="Add more..."

    //bottom panel
    draw_button_ext(0,height-112,160,112,1,global.col_main)
}

if (mode==1 && tilebgpal!=noone) {
    with (tilepanel) if (point_in_rectangle(mouse_wx,mouse_wy,x+w-36,y,x+w,y+36) && !mouse_check_button(mb_left)) other.tooltiptext="Drag to resize"

    if (bgnametooltip!="") tooltiptext=bgnametooltip
}

draw_knob()

with (Button) button_draw()
with (Button) if (focus && alt!="" && (tagmode==mode || tagmode==-1)) drawtooltip(alt)

if (mousein && mode==0) {
    with (select) {
        if (fieldactive) {
            draw_instance_fields(0)
        } else if (abs(global.mousex-fieldhandx)<9*zm && abs(global.mousey-fieldhandy)<9*zm) {
            draw_instance_fields(1)
        }
    }
    if (keyboard_check(ord("C"))) {
        with (instance) if (abs(global.mousex-fieldhandx)<9*zm && abs(global.mousey-fieldhandy)<9*zm || other.focus==id && !fieldactive) {
            draw_instance_fields(1)
        }
    } else {
        with (focus) if (!fieldactive) {
            draw_instance_fields(1)
        }
    }
}

with (colorpicker) event_draw()

if (live_message_alpha) live_message_alpha-=1
draw_set_alpha(live_message_alpha/100)
draw_set_color(0)
draw_text(160+6+1,32+6+1,live_message)
draw_set_color($ffff)
draw_text(160+6,32+6,live_message)
draw_reset()

if (tooltiptext!="") drawtooltip(tooltiptext)
