var nomorefortnite;nomorefortnite=0

if (mode==1) {
    set_interpolation()

    draw_set_color($ff8000)
    draw_set_alpha(sel_alpha)
    with (tileholder) if (sel && !instance_exists(colorpicker)) {
        draw_rectangle(x-0.5,y-0.5,x+image_xscale-0.5,y+image_yscale-0.5,0)
    }
    draw_set_alpha(1)

    draw_set_color_sel()
    with (tileholder) if (sel) {
        draw_rectangle(bbox_left-0.5,bbox_top-0.5,bbox_right+1-0.5,bbox_bottom+1-0.5,1)
    }
    draw_set_color($ffffff)
    texture_set_interpolation(1)

    with (selectt) {
        event_user(0)
    }

    draw_set_color_sel()
    with (focus) draw_rectangle(bbox_left-0.5,bbox_top-0.5,bbox_right+0.5,bbox_bottom+0.5,1)
    draw_set_color($ffffff)

    if (autotiler_rectangle) {
        draw_set_color($ff8000)
        draw_set_alpha(0.5)
        l=min(floor(global.mousex/gridx),autotiler_rectangle_x)*gridx-0.5
        r=(max(floor(global.mousex/gridx),autotiler_rectangle_x)+1)*gridx+0.5
        t=min(floor(global.mousey/gridy),autotiler_rectangle_y)*gridy-0.5
        b=(max(floor(global.mousey/gridy),autotiler_rectangle_y)+1)*gridy+0.5
        draw_rectangle(l,t,r,b,0)
        draw_set_color_sel()
        draw_rectangle(l,t,r,b,1)
        draw_set_alpha(1)
        draw_set_color($ffffff)
    }

    if (crosshair && tilebgpal!=noone) {
        with (selectt) if (grab || scaling) nomorefortnite=1
        if (!keyboard_check(vk_control) && !keyboard_check(vk_shift) && !nomorefortnite && !selecting && !selsize) {
            set_interpolation()
            tex=bg_background[tilebgpal]
            u=curtilex
            v=curtiley
            tw=curtilew
            th=curtileh

            if (!bg_tilemode[tilebgpal]) {
                if (keyboard_check(vk_alt)) draw_background_part_ext(tex,u,v,tw,th,global.mousex,global.mousey,1,1,$ffffff,0.25)
                else draw_background_part_ext(tex,u,v,tw,th,fmx,fmy,1,1,$ffffff,0.25)
            }
            texture_set_interpolation(1)
        }
    }
}
