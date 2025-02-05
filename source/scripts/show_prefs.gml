///show_prefs()
var w,h,dx,dy,cx,cy,c,offx,offy,button,act;

screen_redraw()
rect(0,0,width,height,0,0.5)

w=488
h=412

act=""
button=1

offx=(width-w) div 2
offy=(height-h-32) div 2

io_clear()
mouse_check_direct(mb_left)
sleep(16)

while (1) {
    //input
    if (keyboard_check(vk_escape)) exit

    mouse_wx=window_mouse_get_x()
    mouse_wy=window_mouse_get_y()

    mx=mouse_wx-offx
    my=mouse_wy-offy

    buttonmem=button button=mouse_check_direct(mb_left) pressed=0 released=0
    if (button) {if (!buttonmem) pressed=1} else {if (buttonmem) released=1}

    if (pressed) {
        if (point_in_rectangle(mx,my,432,h-48,432+48,h-48+40)) {
            act="grabok"
        }

        //code editor checkboxes
        if (point_in_rectangle(mx,my,8,32,8+24,32+24)) {
            codeeditortype=0
        }
        if (point_in_rectangle(mx,my,8,64,8+24,64+24)) {
            codeeditortype=1
        }
        if (point_in_rectangle(mx,my,8,96,8+24,96+24)) {
            codeeditortype=2
        }

        //color picker checkboxes
        if (point_in_rectangle(mx,my,8,160,8+24,160+24)) {
            colorpickertype=0
        }
        if (point_in_rectangle(mx,my,8,192,8+24,192+24)) {
            colorpickertype=1
        }

        //theme checkboxes
        if (point_in_rectangle(mx,my,240,32,240+24,32+24)) {
            theme=0
            theme_apply()
            continue
        }
        if (point_in_rectangle(mx,my,240,64,240+24,64+24)) {
            theme=1
            theme_apply()
            continue
        }
        if (point_in_rectangle(mx,my,240,96,240+24,96+24)) {
            theme=2
            theme_apply()
            continue
        }

        //start maximized
        if (point_in_rectangle(mx,my,240,160,240+24,160+24)) {
            startmax=!startmax
            continue
        }

        //grid off room
        if (point_in_rectangle(mx,my,240,192,240+24,192+24)) {
            outroomgrid=!outroomgrid
            continue
        }
        //autosaves
        if (point_in_rectangle(mx,my,240,240,240+24,240+24)) {
            do_autosaves=!do_autosaves
            continue
        }
        //hide gizmo
        if (point_in_rectangle(mx,my,240,272,240+24,272+24)) {
            hide3dgizmo=!hide3dgizmo
            continue
        }
        //crop bgs
        if (point_in_rectangle(mx,my,240,304,240+24,304+24)) {
            cropbackgrounds=!cropbackgrounds
            continue
        }
        //skip tool warnings
        if (point_in_rectangle(mx,my,240,336,240+24,336+24)) {
            skipwarnings=!skipwarnings
            continue
        }

        //rmb boxes

            //menu mode
            if (point_in_rectangle(mx,my,8,256,8+24,256+24)) {
                swaprmb=1
                continue
            }

            //delete mode
            if (point_in_rectangle(mx,my,8,288,8+24,288+24)) {
                swaprmb=0
                rmbalwaysdel=0
                continue
            }

            //alwaysdel mode
            if (point_in_rectangle(mx,my,8,320,8+24,320+24)) {
                swaprmb=0
                rmbalwaysdel=1
                continue
            }

        //custom theme controls
        if (theme==2) {
            if (point_in_rectangle(mx,my,280,128,280+32,128+24)) {
                global.col_main=get_color_ext(global.col_main,"Select Main Color",noone,noone,noone)
                screen_redraw()
                rect(0,0,width,height,0,0.5)
                theme_apply()
                continue
            }
            if (point_in_rectangle(mx,my,320,128,320+32,128+24)) {
                global.col_high=get_color_ext(global.col_high,"Select Light Color",noone,noone,noone)
                screen_redraw()
                rect(0,0,width,height,0,0.5)
                theme_apply()
                continue
            }
            if (point_in_rectangle(mx,my,360,128,360+32,128+24)) {
                global.col_low=get_color_ext(global.col_low,"Select Shadow Color",noone,noone,noone)
                screen_redraw()
                rect(0,0,width,height,0,0.5)
                theme_apply()
                continue
            }
            if (point_in_rectangle(mx,my,400,128,400+32,128+24)) {
                global.col_text=get_color_ext(global.col_text,"Select Text Color",noone,noone,noone)
                screen_redraw()
                rect(0,0,width,height,0,0.5)
                theme_apply()
                continue
            }
            if (point_in_rectangle(mx,my,344,96,344+24,96+24)) {
                themebutton=0
                theme_apply()
                continue
            }
            if (point_in_rectangle(mx,my,376,96,376+24,96+24)) {
                themebutton=1
                theme_apply()
                continue
            }
            if (point_in_rectangle(mx,my,408,96,408+24,96+24)) {
                themebutton=2
                theme_apply()
                continue
            }
        }
    }

    //ok button
    if (act="grabok") {
        if (!button) {
            act=""
            if (point_in_rectangle(mx,my,432,h-48,432+48,h-48+40)) exit
        }
    }

    //draw
    d3d_transform_add_translation(offx,offy,0)
    draw_button_ext(0,0,w,h,1,global.col_main)
    draw_button_ext(0,-32,w,32,1,global.col_main)
    draw_set_color(global.col_text)
    draw_text(8,-32+6,"Preferences")
    draw_text(8,8,"Code editor")
    draw_text(240,8,"Theme")
    draw_text(8,136,"Color picker")
    draw_text(8,232,"Right Click Action")

    //ok button
    dx=432 dy=h-48 draw_button_ext(dx,dy,48,40,act!="grabok",global.col_main) draw_sprite(sprMenuButtons,0,dx+24,dy+20)

    //code editor checkboxes
    dx=8 dy=32 draw_button_ext(dx,dy,24,24,1,global.col_main) draw_text(dx+32,dy,"External (gm prefs)") if (codeeditortype=0) draw_sprite(sprMenuButtons,17,dx+12,dy+12)
    dx=8 dy=64 draw_button_ext(dx,dy,24,24,1,global.col_main) draw_text(dx+32,dy,"Simple") if (codeeditortype=1) draw_sprite(sprMenuButtons,17,dx+12,dy+12)
    dx=8 dy=96 draw_button_ext(dx,dy,24,24,1,global.col_main) draw_text(dx+32,dy,"Notepad.exe") if (codeeditortype=2) draw_sprite(sprMenuButtons,17,dx+12,dy+12)

    //theme checkboxes
    dx=240 dy=32 draw_button_ext(dx,dy,24,24,1,global.col_main) draw_text(dx+32,dy,"Dark") if (theme=0) draw_sprite(sprMenuButtons,17,dx+12,dy+12)
    dx=240 dy=64 draw_button_ext(dx,dy,24,24,1,global.col_main) draw_text(dx+32,dy,"Light") if (theme=1) draw_sprite(sprMenuButtons,17,dx+12,dy+12)
    dx=240 dy=96 draw_button_ext(dx,dy,24,24,1,global.col_main) draw_text(dx+32,dy,"Custom") if (theme=2) draw_sprite(sprMenuButtons,17,dx+12,dy+12)

    //color picker checkboxes
    dx=8 dy=160 draw_button_ext(dx,dy,24,24,1,global.col_main) draw_text(dx+32,dy,"Builtin") if (colorpickertype=0) draw_sprite(sprMenuButtons,17,dx+12,dy+12)
    dx=8 dy=192 draw_button_ext(dx,dy,24,24,1,global.col_main) draw_text(dx+32,dy,"Windows") if (colorpickertype=1) draw_sprite(sprMenuButtons,17,dx+12,dy+12)

    //custom theme controls
    if (theme=2) {
        dx=280 dy=128 draw_button_ext(dx,dy,32,24,0,global.col_main)
        dx=320 dy=128 draw_button_ext(dx,dy,32,24,0,global.col_high)
        dx=360 dy=128 draw_button_ext(dx,dy,32,24,0,global.col_low)
        dx=400 dy=128 draw_button_ext(dx,dy,32,24,0,global.col_text)
        dx=344 dy=96 draw_button_ext(dx,dy,24,24,1,global.col_main) if (themebutton=0) draw_sprite(sprMenuButtons,17,dx+12,dy+12)
        dx=376 dy=96 draw_button_ext(dx,dy,24,24,1,global.col_main) if (themebutton=1) draw_sprite(sprMenuButtons,17,dx+12,dy+12)
        dx=408 dy=96 draw_button_ext(dx,dy,24,24,1,global.col_main) if (themebutton=2) draw_sprite(sprMenuButtons,17,dx+12,dy+12)
    }

    //start maximized
    dx=240 dy=160 draw_button_ext(dx,dy,24,24,1,global.col_main) draw_text(dx+32,dy,"Start maximized") if (startmax) draw_sprite(sprMenuButtons,17,dx+12,dy+12)

    //grid off room
    dx=240 dy=192 draw_button_ext(dx,dy,24,24,1,global.col_main) draw_text(dx+32,dy,"Draw grid outside#of the room area") if (outroomgrid) draw_sprite(sprMenuButtons,17,dx+12,dy+12)

    //autosave
    dx=240 dy=240 draw_button_ext(dx,dy,24,24,1,global.col_main) draw_text(dx+32,dy,"Do autosaves") if (do_autosaves) draw_sprite(sprMenuButtons,17,dx+12,dy+12)

    //gizmo
    dx=240 dy=272 draw_button_ext(dx,dy,24,24,1,global.col_main) draw_text(dx+32,dy,"Hide 3D Gizmo") if (hide3dgizmo) draw_sprite(sprMenuButtons,17,dx+12,dy+12)

    //crop backgrounds
    dx=240 dy=304 draw_button_ext(dx,dy,24,24,1,global.col_main) draw_text(dx+32,dy,"Crop Backgrounds") if (cropbackgrounds) draw_sprite(sprMenuButtons,17,dx+12,dy+12)

    //crop backgrounds
    dx=240 dy=336 draw_button_ext(dx,dy,24,24,1,global.col_main) draw_text(dx+32,dy,"Skip Tool Warnings") if (skipwarnings) draw_sprite(sprMenuButtons,17,dx+12,dy+12)


    //swap rmb
    dx=8 dy=256 draw_button_ext(dx,dy,24,24,1,global.col_main) draw_text(dx+32,dy,"Menu") if (swaprmb) draw_sprite(sprMenuButtons,17,dx+12,dy+12)
    dx=8 dy=288 draw_button_ext(dx,dy,24,24,1,global.col_main) draw_text(dx+32,dy,"Delete") if (!swaprmb && !rmbalwaysdel) draw_sprite(sprMenuButtons,17,dx+12,dy+12)
    dx=8 dy=320 draw_button_ext(dx,dy,24,24,1,global.col_main) draw_text(dx+32,dy,"Continuous Delete") if (!swaprmb && rmbalwaysdel) draw_sprite(sprMenuButtons,17,dx+12,dy+12)

    draw_set_color($ffffff)
    d3d_transform_set_identity()

    screen_refresh()
    sleep(16)
    io_handle()
}

game_end()
