var layer;

with (Controller) {
    layer=ds_list_find_value(layers,ly_current)

    layerto=ds_list_find_index(layers,argument0)

    //bruh
    if (ly_current==layerto) exit

    tile_layer_depth(layer,argument0)

    with (tileholder) if (tlayer==layer) tlayer=argument0

    if (layerto!=-1) {
        //this layer already exists
        ds_list_delete(layers,ly_current)
    } else {
        ds_list_replace(layers,ly_current,argument0)
    }

    ds_list_sort(layers,1)
    layersize=ds_list_size(layers)

    ly_current=ds_list_find_index(layers,argument0)

    ly_depth=argument0

    change_mode(1)
    update_tilepanel()
}
