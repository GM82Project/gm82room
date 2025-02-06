var i;

i=ds_list_find_index(objects,argument0)
if (i<0) {show_error("Error loading project: object "+qt+string(argument0)+qt+" doesn't seem to exist in the project.",0) return noone}

if (!objloaded[i]) {
    objloaded[i]=1
    object[i]=ds_map_create() ds_map_read_ini(object[i],root+"objects\"+argument0+".txt")
    objspr[i]=get_sprite(ds_map_find_value(object[i],"sprite"))
    objvis[i]=real(ds_map_find_value(object[i],"visible"))
    objdepth[i]=real(ds_map_find_value(object[i],"depth"))
    objparent[i]=ds_map_find_value(object[i],"parent")
    objfields[i]=0
    objprev_objectid[i]=noone
    objshow[i]=true
    objdesc[i]=""
    load_object_fields(i,argument0)
    desc="Depth: "+string(objdepth[i])+"#Visible: "+pick(objvis[i],"No","Yes")+"#Solid: "+pick(real(ds_map_find_value(object[i],"solid")),"No","Yes")+"#Parent: "+pick(objparent[i]!="","<none>",objparent[i])
    if (objdesc[i]!="") objdesc[i]=desc+"##"+objdesc[i] else objdesc[i]=desc
    palettesize+=1
}
set_objpal(i)
return i
