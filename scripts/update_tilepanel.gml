with (Controller) {
    textfield_set("tile bg name",ds_list_find_value(backgrounds,tilebgpal))
    textfield_set("layer depth",ds_list_find_value(layers,ly_current))
    map=bg_tilemap[tilebgpal]
    key=ds_map_find_first(map)
    repeat (tilepal) key=ds_map_find_next(map,key)
    curtile=ds_map_find_value(map,key)
}
