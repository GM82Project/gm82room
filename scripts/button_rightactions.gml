with (Controller) switch (argument0) {
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
}
