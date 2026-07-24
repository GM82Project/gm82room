var i,map,list,w,h;

micro_optimization_bgid=noone

if (is_real(argument0)) return bgDefault
if (argument0=="") return bgDefault

i=ds_list_find_index(backgrounds,argument0)
if (i<0) {show_error("Error loading project: background "+qt+argument0+qt+" doesn't seem to exist in the project.",0) return bgDefault}

if (!bgloaded[i]) {
    bg_background[i]=background_add(root+"backgrounds\"+argument0+".png",0,0)
    if (bg_background[i]==-1) bg_background[i]=bgDefault

    map=ds_map_create() ds_map_read_ini(map,root+"backgrounds\"+argument0+".txt")
    bg_gridx[i]=real(ds_map_find_value(map,"tile_width"))
    bg_gridy[i]=real(ds_map_find_value(map,"tile_height"))
    bg_gridox[i]=real(ds_map_find_value(map,"tile_hoffset"))
    bg_gridoy[i]=real(ds_map_find_value(map,"tile_voffset"))
    bg_gridsx[i]=real(ds_map_find_value(map,"tile_hsep"))
    bg_gridsy[i]=real(ds_map_find_value(map,"tile_vsep"))
    bg_istile[i]=real(ds_map_find_value(map,"tileset"))
    bg_tilemap[i]=ds_grid_create(48,2) ds_grid_set_region(bg_tilemap[i],0,0,46,1,noone) ds_grid_set_region(bg_tilemap[i],47,0,47,1,1)
    bg_tilemode[i]=0
    bg_modified[i]=0
    if (ds_map_exists(map,"gm82room_tilesmart")) {
        unpack_tilesmart_data(i,ds_map_find_value(map,"gm82room_tilesmart"))
    }
    ds_map_destroy(map)

    tilebgpal=i
    tilebgname=argument0
    bgloaded[i]=1
}

micro_optimization_bgid=i
return bg_background[i]
