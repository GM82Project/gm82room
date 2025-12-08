var nomorefortnite;nomorefortnite=0

if (mode==0) {
    texture_set_interpolation(interpolation)

    with (instance) if (fieldactive) {
        //darken the room when there's fields ui up
        rect(0,0,roomwidth,roomheight,0,0.5)
        draw_self()
    }

    d3d_fog_trick($ff8000)
    with (instance) if (sel && !instance_exists(colorpicker)) {
        draw_sprite_ext(sprite_index,0,x,y,image_xscale,image_yscale,image_angle,0,sel_alpha)
    }
    d3d_fog_trick()

    draw_set_color_sel()
    with (instance) if (sel) {
        draw_rectangle(bbox_left-0.5,bbox_top-0.5,bbox_right+1-0.5,bbox_bottom+1-0.5,1)
    }
    draw_set_color($ffffff)

    texture_set_interpolation(1)

    with (select) {
        event_user(0)
    }
    draw_set_color_sel()
    with (focus) {
        draw_rectangle(bbox_left-0.5,bbox_top-0.5,bbox_right+0.5,bbox_bottom+0.5,1)
        if (select!=id) event_user(5)
    }
    draw_set_color($ffffff)

    if (keyboard_check(ord("C"))) with (instance) {
        if (code!="") {
            d3d_fog_trick($ff)
            draw_sprite_ext(sprite_index,0,x,y,image_xscale,image_yscale,image_angle,image_blend,0.5)
            d3d_fog_trick()
        }
        event_user(4)
    }

    if (crosshair) {
        with (select) if (grab || rotato || scaling) nomorefortnite=1
        if (!keyboard_check(vk_control) && !keyboard_check(vk_shift) && !nomorefortnite && !selecting && !selsize) {
            if (objpal!=noone) {
                texture_set_interpolation(interpolation)
                if (keyboard_check(vk_alt)) draw_sprite_ext(objspr[objpal],0,global.mousex,global.mousey,1,1,0,$ffffff,0.25)
                else draw_sprite_ext(objspr[objpal],0,fmx,fmy,1,1,0,$ffffff,0.25)
                texture_set_interpolation(1)
            }
        }
    }
}
