///room_shift(x,y)

instance_activate_all()

with (instance) {x+=argument0 y+=argument1}
with (tileholder) {x+=argument0 y+=argument1 tile_set_position(tile,x,y)}

var key; key=ds_map_find_first(pathmap_path)
repeat (ds_map_size(pathmap_path)) {
    path_shift(ds_map_find_value(pathmap_path,key),argument0,argument1)
    generate_path_model(key)
    ds_map_set(pathmap_edited,key,true)
key=ds_map_find_next(pathmap_path,key)}

xgo+=argument0
ygo+=argument1
