with (Controller) {
    textfield_set("layer depth",ds_list_find_value(layers,ly_current))
    if (tilebgpal!=noone) {
        textfield_set("tile bg name",ds_list_find_value(backgrounds,tilebgpal))
        map=bg_tilemap[tilebgpal]
        if (!ds_map_size(map)) {
            curtile=noone
        } else {
            key=ds_map_find_first(map)
            repeat (tilepal) key=ds_map_find_next(map,key)
            curtile=ds_map_find_value(map,key)
        }
    }
}
