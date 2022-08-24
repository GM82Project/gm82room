var i;

i=ds_list_find_index(objects,argument0)
if (i==-1) return noone

if (!objloaded[i]) {
    objloaded[i]=1
    object[i]=ds_map_create() ds_map_read_ini(object[i],root+"objects\"+argument0+".txt")
    objspr[i]=get_sprite(ds_map_find_value(object[i],"sprite"))
    objvis[i]=real(ds_map_find_value(object[i],"visible"))
    objdepth[i]=real(ds_map_find_value(object[i],"depth"))
    objparent[i]=ds_map_find_value(object[i],"parent")
    objfields[i]=0
    objdesc[i]=""
    load_object_fields(i,argument0)
    palettesize+=1
}
objpal=i
return i
