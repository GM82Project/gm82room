var i,map,frame;

frame=0

if (is_real(argument[0])) return sprDefault
if (argument[0]="") return sprDefault

if (argument_count==2) frame=argument[1]

if (frame<0) return sprDefault

i=ds_list_find_index(sprites,argument[0])
if (i<0) {show_error("Error loading project: sprite "+qt+argument0+qt+" doesn't seem to exist in the project.",0) return sprDefault}

while (sprloaded_len[i]<=frame) {
    sprloaded[i,sprloaded_len[i]]=0
    sprloaded_len[i]+=1
}

if (!sprloaded[i,frame]) {
    map=ds_map_create() ds_map_read_ini(map,root+"sprites\"+argument0+"\sprite.txt")

    if (frame>=real(ds_map_find_value(map,"frames"))) {
        ds_map_destroy(map)
        return sprDefault
    }

    spr_sprite[i,frame]=sprite_add(root+"sprites\"+argument0+"\"+string(frame)+".png",0,0,0,real(ds_map_find_value(map,"origin_x")),real(ds_map_find_value(map,"origin_y")))
    if (spr_sprite[i,frame]==-1) spr_sprite[i,frame]=sprDefault
    ds_map_destroy(map)
    sprloaded[i,frame]=1
}
return spr_sprite[i,frame]
