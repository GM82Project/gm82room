var i,ret;

i=ds_list_find_index(objects,argument0)
if (i==-1) return ""

if (objloaded[i]) {
    return objparent[i]
} else {
    map=ds_map_create() ds_map_read_ini(map,root+"objects\"+argument0+".txt")
    ret=ds_map_find_value(map,"parent")
    ds_map_destroy(map)
    return ret
}
