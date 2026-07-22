//save_backgrounds()
var i,fn,map;

map=ds_map_create()

i=0 repeat (ds_list_size(backgrounds)) {
    if (bgloaded[i]) if (ds_grid_get_mean(bg_tilemap[i],0,0,pick(bg_tilemode[i]-1,1,2,4,9,16,47)-1,1)!=noone) {
        fn=root+"backgrounds\"+ds_list_find_value(backgrounds,i)+".txt"
        ds_map_read_ini(map,fn)
        ds_map_set(map,"gm82room_tilesmart",save_tilemap_grid(i))
        ds_map_write_ini(map,fn)
    }
i+=1}

ds_map_destroy(map)
