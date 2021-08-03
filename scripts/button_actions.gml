with (Controller) switch (argument0) {
    //top panel
    case "save and quit": {
        //save_room()
        game_end()
    }break

    case "help": {
        show_info()
    }break

    case "object mode": {
        mode=0
        update_visibility(0)
    }break
    case "tile mode": {
        mode=1
        instance_activate_object(tileholder)
    }break
    case "bg mode": {
        mode=2
        instance_deactivate_object(tileholder)
    }break
    case "view mode": {
        mode=3
        instance_deactivate_object(tileholder)
    }break
    case "settings mode": {
        mode=4
        instance_deactivate_object(tileholder)
    }break

    case "room code": {
        roomcode=external_code_editor(roomcode)
        other.alt=roomcode
    }break

    case "palscroldown": {
        palettescrollgo-=200
    }break
    case "palscrolup": {
        palettescrollgo+=200
    }break

    //zoom
    case "reset view": {
        xgo=roomwidth/2
        ygo=roomheight/2
        zoomgo=1
        zoomcenter=1
    }break
    case "zoom in": {
        zoomgo/=1.2
    }break
    case "zoom out": {
        zoomgo*=1.2
    }break
    case "interp": {
        interpolation=!interpolation
    }break
    case "toggle grid": {
        grid=!grid
    }break
    case "toggle crosshair": {
        crosshair=!crosshair
    }break
    case "room persist": {
        roompersistent=!roompersistent
    }break

    //view
    case "view objects": {
        view[0]=!view[0]
        update_visibility(0)
    }break
    case "view tiles": {
        view[1]=!view[1]
        update_visibility(1)
    }break
    case "view bgs": {
        view[2]=!view[2]
    }break
    case "view fgs": {
        view[3]=!view[3]
    }break
    case "view views": {
        view[4]=!view[4]
    }break
    case "view invis": {
        view[5]=!view[5]
        update_visibility(0)
    }break
    case "view nospr": {
        view[6]=!view[6]
        update_visibility(0)
    }break

    //inspector
    case "copy object": {
        clipboard_set_text(select.objname)
    }break

    case "inst snap": {
        with (instance) if (sel) {
            x=roundto(x,gridx)
            y=roundto(y,gridy)
            update_inspector()
        }
    }break

    case "inst flip xs": {
        with (instance) if (sel) {
            image_xscale*=-1
            update_inspector()
        }
    }break
    case "inst flip ys": {
        with (instance) if (sel) {
            image_yscale*=-1
            update_inspector()
        }
    }break

    case "inst rot left": {
        with (instance) if (sel) {
            image_angle=modwrap(image_angle+90,0,360)
            update_inspector()
        }
    }break
    case "inst rot right": {
        with (instance) if (sel) {
            image_angle=modwrap(image_angle-90,0,360)
            update_inspector()
        }
    }break

    case "inst code": {
        edit_creation_code()
    }break

    case "overlap check": {
        overlap_check=!overlap_check
    }break

    case "clear bg": {
        clearscreen=!clearscreen
    }break

    case "bgselect": {
        bg_current=other.actionid
        update_backgroundpanel()
    }break

    case "vwselect": {
        vw_current=other.actionid
        update_viewpanel()
    }break

    case "bg visible": {
        bg_visible[bg_current]=!bg_visible[bg_current]
    }break
    case "bg fore": {
        bg_is_foreground[bg_current]=!bg_is_foreground[bg_current]
    }break
    case "bg tileh": {
        bg_tile_h[bg_current]=!bg_tile_h[bg_current]
    }break
    case "bg tilev": {
        bg_tile_v[bg_current]=!bg_tile_v[bg_current]
    }break
     case "bg stretch": {
        bg_stretch[bg_current]=!bg_stretch[bg_current]
    }break

    case "enable views": {
        vw_enabled=!vw_enabled
    }break

    case "view visible": {
        vw_visible[vw_current]=!vw_visible[vw_current]
    }break
}
