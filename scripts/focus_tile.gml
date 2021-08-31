var tile,tileid,key,map,dy;

with (Controller) {
    tile=argument0

    tilebgname=other.bgname
    get_background(tilebgname)
    tilebgpal=micro_optimization_bgid

    update_tilepanel()

    tileid=string(tile_get_left(tile))+","+string(tile_get_top(tile))+","+string(tile_get_width(tile))+","+string(tile_get_height(tile))

    map=bg_tilemap[tilebgpal]
    tpalsize=ds_map_size(map)

    tilepal=0
    key=ds_map_find_first(map)
    while (key!=tileid) {
        tilepal+=1
        key=ds_map_find_next(map,key)
    }
    curtile=ds_map_find_value(map,key)

    dy=40*(tilepal div 4)+20
    tpalscrollgo=clamp((height-152-216)/2-dy,-(tpalsize+1)*32+(height-152-216),0)
}
