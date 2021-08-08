textfield_set("tile bg name",ds_list_find_value(backgrounds,tilebgpal))

with (Controller) {
    map=bg_tilemap[tilebgpal]
    key=ds_map_find_first(map)
    repeat (tilepal) key=ds_map_find_next(map,key)
    curtile=ds_map_find_value(map,key)
}
