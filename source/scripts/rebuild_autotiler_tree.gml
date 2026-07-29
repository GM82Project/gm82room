var key,u,v,name,leaf;

//first we clear the old grids out of the tree
key=ds_map_find_first(autotiler_tree) repeat (ds_map_size(autotiler_tree)) {
    ds_grid_destroy(ds_map_find_value(autotiler_tree,key))
key=ds_map_find_next(autotiler_tree,key)}

ds_map_clear(autotiler_tree)

if (tilebgpal!=noone) if (bg_tilemode[tilebgpal]) {
    //create new grids
    with (tileholder) if (bg==bg_background[tilebgpal]) {
        u=floorto(x,gridx*autotiler_tree_size)
        v=floorto(y,gridy*autotiler_tree_size)
        name=string(u)+"_"+string(v)
        if (ds_map_exists(autotiler_tree,name)) leaf=ds_map_find_value(autotiler_tree,name)
        else {leaf=ds_grid_create(autotiler_tree_size,autotiler_tree_size) ds_map_add(autotiler_tree,name,leaf)}
        ds_grid_set(leaf,(x-u) div gridx,(y-v) div gridy,id)
    }
}
