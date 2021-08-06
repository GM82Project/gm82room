var i;

if (argument0=="") return bgDefault

i=ds_list_find_index(backgrounds,argument0)
if (!bgloaded[i]) {
    bg_background[i]=background_add(root+"backgrounds\"+argument0+".png",0,0)
    if (bg_background[i]==-1) bg_background[i]=bgDefault
    bg_tilemap[i]=ds_map_create()
    tilebgpal=i
    bgloaded[i]=1
    item=N_Menu_AddItem(tilebgmenu,argument0,"")
    N_Menu_ItemSetBitmap(tilebgmenu,item,background_menuicon)
    ds_map_add(bgmenuitems,item,argument0)
}

micro_optimization_bgid=i
return bg_background[i]
