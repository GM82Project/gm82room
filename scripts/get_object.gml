var i;

//with (Controller) {
    i=ds_list_find_index(objects,argument0)
    if (!objloaded[i]) {
        object[i]=ds_map_create() ds_map_read_ini(object[i],root+"objects\"+argument0+".txt")
        objspr[i]=get_sprite(ds_map_find_value(object[i],"sprite"))
        objloaded[i]=1
        objpal=i
    }
    return i
//}
