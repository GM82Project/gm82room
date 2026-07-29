///find_smart_tile_at(x,y):tile
var name,leaf,u,v,find;

u=floorto(argument0,gridx*autotiler_tree_size)
v=floorto(argument1,gridy*autotiler_tree_size)

name=string(u)+"_"+string(v)

if (!ds_map_exists(autotiler_tree,name)) return noone

leaf=ds_map_find_value(autotiler_tree,name)

find=ds_grid_get(leaf,(argument0-u) div gridx,(argument1-v) div gridy)

if (find) return find

return noone
