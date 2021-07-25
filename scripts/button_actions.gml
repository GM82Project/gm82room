with (Controller) switch (argument0) {
    case "save and quit": {
        //save_room()
        game_end()
    }break
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
    case "toggle grid": {
        grid=!grid
    }break
    case "toggle crosshair": {
        crosshair=!crosshair
    }break
    case "object mode": {
        mode=0
    }break
    case "tile mode": {
        mode=1
    }break
    case "bg mode": {
        mode=2
    }break
    case "view mode": {
        mode=3
    }break
}
