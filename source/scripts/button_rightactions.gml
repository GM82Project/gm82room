if (ilist) if (!Instancepanel.open) exit

with (Controller) switch (argument0) {
    case "palette name": case "bg name": case "view follow": case "path precision": {
        with (other) textfield_activate()
    } break

    case "zoom in": case "zoom out": {
        m=show_menu("Zoom level: "+string((1/zoomgo)*100)+"%|-|12.5%|25%|50%|100%|200%|400%|Custom",0)-1
        if (m==6) {
            v=get_integer("Custom zoom level (%):",round((1/zoomgo)*100))/100
            if (v!=0) zoomgo=1/v
            zoomcenter=1
        } else if (m!=-1) {
            zoomgo=pick(m,8,4,2,1,0.5,0.25)
            zoomcenter=1
        }
    }break

    case "grid x": {
        keyboard_check_direct(vk_lshift)
        keyboard_check_direct(vk_rshift)
        keyboard_check_direct(vk_lcontrol)
        keyboard_check_direct(vk_rcontrol)
        m=show_menu("Grid X:|8|16|32|64|128|256|"+string(roomwidth div 2)+" (room width / 2)|"+string(roomwidth)+" (room width)|"+string(screen_grid_width)+" (screen grid)",-1)
        if (m) {
            gridx=min(pick(m-1,8,16,32,64,128,256,roomwidth div 2,roomwidth,screen_grid_width),roomwidth)
            keyboard_check_direct(vk_lshift)
            keyboard_check_direct(vk_rshift)
            keyboard_check_direct(vk_lcontrol)
            keyboard_check_direct(vk_rcontrol)
            if (keyboard_check_direct(vk_lshift) or keyboard_check_direct(vk_rshift) or keyboard_check_direct(vk_lcontrol) or keyboard_check_direct(vk_rcontrol)) {
                gridy=min(pick(m-1,8,16,32,64,128,256,roomheight div 2,roomheight,screen_grid_height),roomheight)
                with (TextField) if (action=="grid y") {text=string(gridy) event_user(4)}
            }
            rebuild_autotiler_tree()
        }
        with (other) {text=string(gridx) event_user(4)}
    }break
    case "grid y": {
        keyboard_check_direct(vk_lshift)
        keyboard_check_direct(vk_rshift)
        keyboard_check_direct(vk_lcontrol)
        keyboard_check_direct(vk_rcontrol)
        m=show_menu("Grid Y:|8|16|32|64|128|256|"+string(roomheight div 2)+"| (room height / 2)"+string(roomheight)+" (room height)|"+string(screen_grid_height)+" (screen grid)",-1)
        if (m) {
            gridy=min(pick(m-1,8,16,32,64,128,256,roomheight div 2,roomheight,screen_grid_height),roomheight)
            keyboard_check_direct(vk_lshift)
            keyboard_check_direct(vk_rshift)
            keyboard_check_direct(vk_lcontrol)
            keyboard_check_direct(vk_rcontrol)
            if (keyboard_check_direct(vk_lshift) or keyboard_check_direct(vk_rshift) or keyboard_check_direct(vk_lcontrol) or keyboard_check_direct(vk_rcontrol)) {
                gridx=min(pick(m-1,8,16,32,64,128,256,roomwidth div 2,roomwidth,screen_grid_width),roomwidth)
                with (TextField) if (action=="grid x") {text=string(gridx) event_user(4)}
            }
            rebuild_autotiler_tree()
        }
        with (other) {text=string(gridy) event_user(4)}
    }break
}
