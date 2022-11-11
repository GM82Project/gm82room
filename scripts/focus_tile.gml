var tile,tileid,key,map,dy;

with (Controller) {
    tile=argument0

    tilebgname=other.bgname
    get_background(tilebgname)
    tilebgpal=micro_optimization_bgid

    update_newtilepanel()

    curtilex=tile_get_left(tile)
    curtiley=tile_get_top(tile)
    curtilew=tile_get_width(tile)
    curtileh=tile_get_height(tile)


    //dy=40*(tilepal div 4)+20
    //tpalscrollgo=clamp((height-152-216)/2-dy,-(tpalsize+1)*32+(height-152-216),0)
}
