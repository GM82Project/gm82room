///show_prefs()
var w,h,dx,dy,cx,cy,c,offx,offy,button,act,ww,hh;

screen_redraw()
rect(0,0,width,height,0,0.5)

w=732
h=420

act=""
button=1

offx=(width-w) div 2
offy=(height-h-32) div 2

io_clear()
mouse_check_direct(mb_left)
sleep(16)

ww=width
hh=height

while (1) {
    //input
    if (keyboard_check(vk_escape)) exit

    mouse_wx=window_mouse_get_x()
    mouse_wy=window_mouse_get_y()

    mx=mouse_wx-offx
    my=mouse_wy-offy

    buttonmem=button button=mouse_check_direct(mb_left) pressed=0 released=0
    if (button) {if (!buttonmem) pressed=1} else {if (buttonmem) released=1}

    tooltip=""

    if (point_in_rectangle(mx,my,8,h-48,8+64,h-48+40)) {
        if (pressed) act="grabok"
    }

    //code editor checkboxes
    if (point_in_rectangle(mx,my,8,32,8+24,32+24)) {
        tooltip="Uses the external code editor set up in GM 8.2 preferences."
        if (pressed) codeeditortype=0
    }
    if (point_in_rectangle(mx,my,8,64,8+24,64+24)) {
        tooltip="Uses a simple message box."
        if (pressed) codeeditortype=1
    }
    if (point_in_rectangle(mx,my,8,96,8+24,96+24)) {
        tooltip="Invokes Windows Notepad."
        if (pressed) codeeditortype=2
    }

    //color picker checkboxes
    if (point_in_rectangle(mx,my,240,192,240+24,192+24)) {
        tooltip="Uses the built-in color picker designed for GM 8.2."
        if (pressed) colorpickertype=0
    }
    if (point_in_rectangle(mx,my,240,224,240+24,224+24)) {
        tooltip="Uses the Windows color picker."
        if (pressed) colorpickertype=1
    }

    //theme checkboxes
    if (point_in_rectangle(mx,my,240,32,240+24,32+24)) {
        tooltip="Default Game Maker 8.2 dark theme."
        if (pressed) {
            theme=0
            theme_apply()
            continue
        }
    }
    if (point_in_rectangle(mx,my,240,64,240+24,64+24)) {
        tooltip="Windows 98-inspired light theme."
        if (pressed) {
            theme=1
            theme_apply()
            continue
        }
    }
    if (point_in_rectangle(mx,my,240,96,240+24,96+24)) {
        tooltip="Make a custom theme of your liking using color and edge options."
        if (pressed) {
            theme=2
            theme_apply()
            continue
        }
    }


    //start maximized
    if (point_in_rectangle(mx,my,472,32,472+24,32+24)) {
        tooltip="Starts the room editor filling the main monitor."
        if (pressed) {
            startmax=!startmax
            continue
        }
    }
    //grid off room
    if (point_in_rectangle(mx,my,472,64,472+24,64+24)) {
        tooltip="Draws the grid outside of the room when the cursor goes there."
        if (pressed) {
            outroomgrid=!outroomgrid
            continue
        }
    }
    //autosaves
    if (point_in_rectangle(mx,my,472,112,472+24,112+24)) {
        tooltip="Automatically save the room files when left idle or tabbing out."
        if (pressed) {
            do_autosaves=!do_autosaves
            continue
        }
    }
    //hide gizmo
    if (point_in_rectangle(mx,my,472,144,472+24,144+24)) {
        tooltip="Hides the depth inspector 3D Game Maker logo gizmo."
        if (pressed) {
            hide3dgizmo=!hide3dgizmo
            continue
        }
    }
    //crop bgs
    if (point_in_rectangle(mx,my,472,176,472+24,176+24)) {
        tooltip="Displays backgrounds cropped to fit only the room area."
        if (pressed) {
            cropbackgrounds=!cropbackgrounds
            continue
        }
    }
    //skip tool warnings
    if (point_in_rectangle(mx,my,472,208,472+24,208+24)) {
        tooltip="Skips the warning boxes that tell you how to use a tool."
        if (pressed) {
            skipwarnings=!skipwarnings
            continue
        }
    }
    //skip instance recenter
    if (point_in_rectangle(mx,my,472,240,472+24,240+24)) {
        tooltip="Don't fix the position of instances or tiles when transforming them."
        if (pressed) {
            skiprecenter=!skiprecenter
            continue
        }
    }
    //tile crop
    if (point_in_rectangle(mx,my,472,288,472+24,288+24)) {
        tooltip="Crop tiles that use parts outside of the texture limits of backgrounds."
        if (pressed) {
            dotilecrop=!dotilecrop
            continue
        }
    }
    //remove outside
    if (point_in_rectangle(mx,my,472,336,472+24,336+24)) {
        tooltip="Remove instances and tiles outside the room when closing."
        if (pressed) {
            remoutside=!remoutside
            continue
        }
    }
    //no description preview
    if (point_in_rectangle(mx,my,472,368,472+24,368+24)) {
        tooltip="Only show description fields when the field editor is open."
        if (pressed) {
            nodescpreview=!nodescpreview
            continue
        }
    }

    //rmb boxes

        //menu mode
        if (point_in_rectangle(mx,my,8,160,8+24,160+24)) {
            tooltip="Show a menu or open Fields when right clicking things."
            if (pressed) {
                swaprmb=1
                continue
            }
        }

        //delete mode
        if (point_in_rectangle(mx,my,8,192,8+24,192+24)) {
            tooltip="Delete a single thing when right clicking things."
            if (pressed) {
                swaprmb=0
                rmbalwaysdel=0
                continue
            }
        }

        //alwaysdel mode
        if (point_in_rectangle(mx,my,8,224,8+24,224+24)) {
            tooltip="Delete everything under the cursor when right clicking things."
            if (pressed) {
                swaprmb=0
                rmbalwaysdel=1
                continue
            }
        }

    //custom theme controls
    if (theme==2) {
        if (point_in_rectangle(mx,my,280,128,280+32,128+24)) {
            tooltip="Main color used for the surface of 3D buttons."
            if (pressed) {
                global.col_main=get_color_ext(global.col_main,"Select Main Color",noone,noone,noone)
                screen_redraw()
                rect(0,0,width,height,0,0.5)
                theme_apply()
                continue
            }
        }
        if (point_in_rectangle(mx,my,320,128,320+32,128+24)) {
            tooltip="Shine color used for 3D buttons."
            if (pressed) {
                global.col_high=get_color_ext(global.col_high,"Select Light Color",noone,noone,noone)
                screen_redraw()
                rect(0,0,width,height,0,0.5)
                theme_apply()
                continue
            }
        }
        if (point_in_rectangle(mx,my,360,128,360+32,128+24)) {
            tooltip="Shade color used for 3D buttons."
            if (pressed) {
                global.col_low=get_color_ext(global.col_low,"Select Shadow Color",noone,noone,noone)
                screen_redraw()
                rect(0,0,width,height,0,0.5)
                theme_apply()
                continue
            }
        }
        if (point_in_rectangle(mx,my,400,128,400+32,128+24)) {
            tooltip="Text color across the interface."
            if (pressed) {
                global.col_text=get_color_ext(global.col_text,"Select Text Color",noone,noone,noone)
                screen_redraw()
                rect(0,0,width,height,0,0.5)
                theme_apply()
                continue
            }
        }
        if (point_in_rectangle(mx,my,344,96,344+24,96+24)) {
            tooltip="Hard, polygonal-looking 3D edges. Default GM 8.2 visual design."
            if (pressed) {
                themebutton=0
                theme_apply()
                continue
            }
        }
        if (point_in_rectangle(mx,my,376,96,376+24,96+24)) {
            tooltip="Rounded, smooth-shaded 3D edges."
            if (pressed) {
                themebutton=1
                theme_apply()
                continue
            }
        }
        if (point_in_rectangle(mx,my,408,96,408+24,96+24)) {
            tooltip="Rounded, smooth-shaded 3D edges, with an outline using the text color."
            if (pressed) {
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
            if (point_in_rectangle(mx,my,8,h-48,8+64,h-48+40)) exit
        }
    }

    //draw
    if (window_get_width()!=ww or window_get_height()!=hh) {
        ww=window_get_width()
        hh=window_get_height()
        offx=(ww-w) div 2
        offy=(hh-h-32) div 2
        draw_clear(0)
        d3d_set_projection_ortho(0,0,ww,hh,0)
    }

    d3d_transform_add_translation(offx,offy,0)
    draw_button_ext(0,0,w,h,1,global.col_main)
    draw_button_ext(0,-32,w,32,1,global.col_main)
    draw_button_ext(0,h,w,32,1,global.col_main)
    draw_set_color(global.col_text)
    draw_text(8,-32+6,"Preferences")
    draw_text(8,8,"Code editor")
    draw_text(240,8,"Theme")
    draw_text(472,8,"Preferences")
    draw_text(240,168,"Color picker")
    draw_text(8,136,"Right Click Action")
    draw_text(8,h+6,tooltip)

    //ok button
    dx=8 dy=h-48 draw_button_ext(dx,dy,64,40,act!="grabok",global.col_main) draw_sprite(sprMenuButtons,0,dx+32,dy+20)

    //code editor checkboxes
    dx=8 dy=32 draw_button_ext(dx,dy,24,24,1,global.col_main) draw_text(dx+32,dy,"External (gm prefs)") if (codeeditortype=0) draw_sprite(sprMenuButtons,17,dx+12,dy+12)
    dx=8 dy=64 draw_button_ext(dx,dy,24,24,1,global.col_main) draw_text(dx+32,dy,"Simple") if (codeeditortype=1) draw_sprite(sprMenuButtons,17,dx+12,dy+12)
    dx=8 dy=96 draw_button_ext(dx,dy,24,24,1,global.col_main) draw_text(dx+32,dy,"Notepad.exe") if (codeeditortype=2) draw_sprite(sprMenuButtons,17,dx+12,dy+12)

    //theme checkboxes
    dx=240 dy=32 draw_button_ext(dx,dy,24,24,1,global.col_main) draw_text(dx+32,dy,"Dark") if (theme=0) draw_sprite(sprMenuButtons,17,dx+12,dy+12)
    dx=240 dy=64 draw_button_ext(dx,dy,24,24,1,global.col_main) draw_text(dx+32,dy,"Light") if (theme=1) draw_sprite(sprMenuButtons,17,dx+12,dy+12)
    dx=240 dy=96 draw_button_ext(dx,dy,24,24,1,global.col_main) draw_text(dx+32,dy,"Custom") if (theme=2) draw_sprite(sprMenuButtons,17,dx+12,dy+12)

    //color picker checkboxes
    dx=240 dy=192 draw_button_ext(dx,dy,24,24,1,global.col_main) draw_text(dx+32,dy,"Builtin") if (colorpickertype=0) draw_sprite(sprMenuButtons,17,dx+12,dy+12)
    dx=240 dy=224 draw_button_ext(dx,dy,24,24,1,global.col_main) draw_text(dx+32,dy,"Windows") if (colorpickertype=1) draw_sprite(sprMenuButtons,17,dx+12,dy+12)

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
    dx=472 dy=32 draw_button_ext(dx,dy,24,24,1,global.col_main) draw_text(dx+32,dy,"Start maximized") if (startmax) draw_sprite(sprMenuButtons,17,dx+12,dy+12)

    //grid off room
    dx=472 dy=64 draw_button_ext(dx,dy,24,24,1,global.col_main) draw_text(dx+32,dy,"Draw Grid Outside#of the Room Area") if (outroomgrid) draw_sprite(sprMenuButtons,17,dx+12,dy+12)

    //autosave
    dx=472 dy=112 draw_button_ext(dx,dy,24,24,1,global.col_main) draw_text(dx+32,dy,"Do Auto Saves") if (do_autosaves) draw_sprite(sprMenuButtons,17,dx+12,dy+12)

    //gizmo
    dx=472 dy=144 draw_button_ext(dx,dy,24,24,1,global.col_main) draw_text(dx+32,dy,"Hide 3D Gizmo") if (hide3dgizmo) draw_sprite(sprMenuButtons,17,dx+12,dy+12)

    //crop backgrounds
    dx=472 dy=176 draw_button_ext(dx,dy,24,24,1,global.col_main) draw_text(dx+32,dy,"Crop Backgrounds") if (cropbackgrounds) draw_sprite(sprMenuButtons,17,dx+12,dy+12)

    //tool warnings
    dx=472 dy=208 draw_button_ext(dx,dy,24,24,1,global.col_main) draw_text(dx+32,dy,"Skip Tool Warnings") if (skipwarnings) draw_sprite(sprMenuButtons,17,dx+12,dy+12)

    //recentering
    dx=472 dy=240 draw_button_ext(dx,dy,24,24,1,global.col_main) draw_text(dx+32,dy,"Don't Recenter#After Transform") if (skiprecenter) draw_sprite(sprMenuButtons,17,dx+12,dy+12)

    //tile crop
    dx=472 dy=288 draw_button_ext(dx,dy,24,24,1,global.col_main) draw_text(dx+32,dy,"Fix Broken Tile#Coordinates") if (dotilecrop) draw_sprite(sprMenuButtons,17,dx+12,dy+12)

    //remove outside
    dx=472 dy=336 draw_button_ext(dx,dy,24,24,1,global.col_main) draw_text(dx+32,dy,"Remove Outside") if (remoutside) draw_sprite(sprMenuButtons,17,dx+12,dy+12)

    //no description preview
    dx=472 dy=368 draw_button_ext(dx,dy,24,24,1,global.col_main) draw_text(dx+32,dy,"Hide Descriptions") if (nodescpreview) draw_sprite(sprMenuButtons,17,dx+12,dy+12)

    //swap rmb
    dx=8 dy=160 draw_button_ext(dx,dy,24,24,1,global.col_main) draw_text(dx+32,dy,"Menu") if (swaprmb) draw_sprite(sprMenuButtons,17,dx+12,dy+12)
    dx=8 dy=192 draw_button_ext(dx,dy,24,24,1,global.col_main) draw_text(dx+32,dy,"Delete") if (!swaprmb && !rmbalwaysdel) draw_sprite(sprMenuButtons,17,dx+12,dy+12)
    dx=8 dy=224 draw_button_ext(dx,dy,24,24,1,global.col_main) draw_text(dx+32,dy,"Continuous Delete") if (!swaprmb && rmbalwaysdel) draw_sprite(sprMenuButtons,17,dx+12,dy+12)

    draw_set_color($ffffff)
    d3d_transform_set_identity()

    screen_refresh()
    sleep(16)
    io_handle()
}

game_end()
