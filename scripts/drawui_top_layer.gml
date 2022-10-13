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
    //tile tab tooltips
    posx=0
    posy=0
    if (mouse_wy>=152 && mouse_wy<height-216 && tilebgpal!=noone) {
        tex=bg_background[tilebgpal]
        map=bg_tilemap[tilebgpal]
        len=ds_map_size(map)
        key=ds_map_find_first(map)
        for (i=0;i<len;i+=1) {
            tile=ds_map_find_value(map,key)
            key=ds_map_find_next(map,key)
            dx=20+40*posx
            dy=172+40*posy+tpalscroll
            if (point_in_rectangle(mouse_wx,mouse_wy,dx-20,dy-20,dx+20,dy+20)) {
                u=ds_list_find_value(tile,0)
                v=ds_list_find_value(tile,1)
                tw=ds_list_find_value(tile,2)
                th=ds_list_find_value(tile,3)
                if (tw>32 || th>32) {
                    dx=floor(max(1,dx-tw/2)+tw/2)+frac(tw/2)
                    dy=floor(max(1,dy-th/2)+th/2)+frac(th/2)
                    draw_set_color_sel() d3d_set_fog(1,draw_get_color(),0,0) draw_set_color($ffffff)
                    draw_background_part(tex,u,v,tw,th,dx-tw/2+1,dy-th/2+1)
                    draw_background_part(tex,u,v,tw,th,dx-tw/2+1,dy-th/2-1)
                    draw_background_part(tex,u,v,tw,th,dx-tw/2-1,dy-th/2+1)
                    draw_background_part(tex,u,v,tw,th,dx-tw/2-1,dy-th/2-1)
                    d3d_set_fog(0,0,0,0)
                }
                draw_background_part(tex,u,v,tw,th,dx-tw/2,dy-th/2)
            }
            posx+=1 if (posx=4) {posx=0 posy+=1}
        }

        if (paltooltip && !paladdbuttondown) tooltiptext="Add tiles..."
    }

    if (mouse_wx>=width-160 && mouse_wy>=360 && mouse_wy<height-100) {
        mem=ly_current
        if (median(0,floor((mouse_wy-360-layerscroll)/32),layersize+1)==layersize) {
            tooltiptext="Add layer..."
        }
    }
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

if (tooltiptext!="") drawtooltip(tooltiptext)
