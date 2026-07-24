//save_backgrounds()
var i,fn,map;

map=ds_map_create()

i=0 repeat (ds_list_size(backgrounds)) {
    if (bgloaded[i]) if (bg_modified[i]) {
        fn=root+"backgrounds\"+ds_list_find_value(backgrounds,i)+".txt"
        ds_map_read_ini(map,fn)
        ds_map_set(map,"tile_width",bg_gridx[i])
        ds_map_set(map,"tile_height",bg_gridy[i])
        ds_map_set(map,"tile_hoffset",bg_gridox[i])
        ds_map_set(map,"tile_voffset",bg_gridoy[i])
        ds_map_set(map,"tile_hsep",bg_gridsx[i])
        ds_map_set(map,"tile_vsep",bg_gridsy[i])
        ds_map_set(map,"gm82room_tilesmart",save_tilemap_grid(i))
        ds_map_write_ini(map,fn)
    }
i+=1}

ds_map_destroy(map)
