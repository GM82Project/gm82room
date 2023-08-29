var tile,tileid,key,map,dy;

with (Controller) {
    tile=argument0

    tilebgname=other.bgname
    get_background(tilebgname)
    tilebgpal=micro_optimization_bgid

    curtilex=tile_get_left(tile)
    curtiley=tile_get_top(tile)
    curtilew=tile_get_width(tile)
    curtileh=tile_get_height(tile)

    update_newtilepanel(0)
}
