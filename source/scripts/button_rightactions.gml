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
        m=show_menu("Grid X:|8|16|32|64|128|256|"+string(roomwidth div 2),-1)
        if (m) gridx=min(pick(m-1,8,16,32,64,128,256,roomwidth div 2),roomwidth)
        with (other) {text=string(gridx) event_user(4)}
    }break
    case "grid y": {
        m=show_menu("Grid Y:|8|16|32|64|128|256|"+string(roomheight div 2),-1)
        if (m) gridy=min(pick(m-1,8,16,32,64,128,256,roomheight div 2),roomheight)
        with (other) {text=string(gridy) event_user(4)}
    }break
}
