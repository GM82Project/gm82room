var i,map,list,w,h;

micro_optimization_bgid=noone

if (is_real(argument0)) return bgDefault
if (argument0=="") return bgDefault

i=ds_list_find_index(backgrounds,argument0)
if (!bgloaded[i]) {
    bg_background[i]=background_add(root+"backgrounds\"+argument0+".png",0,0)
    if (bg_background[i]==-1) bg_background[i]=bgDefault

    bg_tilemap[i]=ds_map_create()

    map=ds_map_create() ds_map_read_ini(map,root+"backgrounds\"+argument0+".txt")
    bg_gridx[i]=real(ds_map_find_value(map,"tile_width"))
    bg_gridy[i]=real(ds_map_find_value(map,"tile_height"))
    bg_gridox[i]=real(ds_map_find_value(map,"tile_hoffset"))
    bg_gridoy[i]=real(ds_map_find_value(map,"tile_voffset"))
    bg_gridsx[i]=real(ds_map_find_value(map,"tile_hsep"))
    bg_gridsy[i]=real(ds_map_find_value(map,"tile_vsep"))
    if (ds_map_find_value(map,"tileset")=="0") {
        //default full tile for non tilesets
        w=background_get_width(bg_background[i])
        h=background_get_height(bg_background[i])
        list=ds_list_create()
        ds_list_add(list,0)
        ds_list_add(list,0)
        ds_list_add(list,w)
        ds_list_add(list,h)
        ds_map_add(bg_tilemap[i],"0,0,"+string(w)+","+string(h),list)
    }
    ds_map_destroy(map)

    tilebgpal=i
    tilebgname=argument0
    bgloaded[i]=1
    item=N_Menu_AddItem(tilebgmenu,argument0,"")
    icon=background_menuicon
    if (ds_map_exists(bgmenuicons,argument0))
        icon=ds_map_find_value(bgmenuicons,argument0)
    N_Menu_ItemSetBitmap(tilebgmenu,item,icon)
    ds_map_add(bgmenuitems,item,argument0)
}

micro_optimization_bgid=i
return bg_background[i]
