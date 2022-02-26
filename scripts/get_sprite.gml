var i,map;

if (argument0="") return sprDefault

i=ds_list_find_index(sprites,argument0)
if (!sprloaded[i]) {
    map=ds_map_create() ds_map_read_ini(map,root+"sprites\"+argument0+"\sprite.txt")
    spr_sprite[i]=sprite_add(root+"sprites\"+argument0+"\0.png",0,0,0,real(ds_map_find_value(map,"origin_x")),real(ds_map_find_value(map,"origin_y")))
    if (spr_sprite[i]==-1) spr_sprite[i]=sprDefault
    ds_map_destroy(map)
    sprloaded[i]=1
}
return spr_sprite[i]
