var layer;

layer=ds_list_find_value(layers,ly_current)

tile_layer_depth(layer,argument0)

with (tileholder) if (tlayer==layer) tlayer=argument0

ds_list_replace(layers,ly_current,argument0)

ds_list_sort(layers,1)

ly_current=ds_list_find_index(layers,argument0)

ly_depth=argument0

update_tilepanel()
