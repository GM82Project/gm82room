var nomorefortnite;nomorefortnite=0

if (mode==1) {
    texture_set_interpolation(interpolation)

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

    if (crosshair && tilebgpal!=noone) {
        with (selectt) if (grab || draggatto) nomorefortnite=1
        if (!keyboard_check(vk_control) && !keyboard_check(vk_shift) && !nomorefortnite && !selecting && !selsize) {
            texture_set_interpolation(interpolation)
            tex=bg_background[tilebgpal]
            u=curtilex
            v=curtiley
            tw=curtilew
            th=curtileh

            if (keyboard_check(vk_alt)) draw_background_part_ext(tex,u,v,tw,th,global.mousex,global.mousey,1,1,$ffffff,0.25)
            else draw_background_part_ext(tex,u,v,tw,th,fmx,fmy,1,1,$ffffff,0.25)
            texture_set_interpolation(1)
        }
    }
}
