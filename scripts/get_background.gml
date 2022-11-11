var i,map,list,w,h;

micro_optimization_bgid=noone

if (is_real(argument0)) return bgDefault
if (argument0=="") return bgDefault

i=ds_list_find_index(backgrounds,argument0)
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
    ds_map_destroy(map)

    tilebgpal=i
    tilebgname=argument0
    bgloaded[i]=1
}

micro_optimization_bgid=i
return bg_background[i]
