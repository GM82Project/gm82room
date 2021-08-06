var cx,cy;

with (Controller) switch (argument0) {
    case "zoom in"           : {zoomgo/=1.05 zoomcenter=1}break
    case "zoom out"          : {zoomgo*=1.05 zoomcenter=1}break

    //instances
    case "palscroldown"      : {palettescrollgo-=20}break
    case "palscrolup"        : {palettescrollgo+=20}break

    //tiles
    case "tile palscroldown" : {tpalscrollgo-=20}break
    case "tile palscrolup"   : {tpalscrollgo+=20}break

    //tile inspector
    case "layerscroldown"    : {layerscrollgo-=20}break
    case "layerscrolup"      : {layerscrollgo+=20}break
}
