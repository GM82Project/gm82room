var i;

i=ds_list_find_index(objects,argument0)
if (i<0) {show_error("Error loading project: object "+qt+string(argument0)+qt+" doesn't seem to exist in the project.",0) return noone}

if (!objloaded[i]) {
    objloaded[i]=1
    object[i]=ds_map_create() ds_map_read_ini(object[i],root+"objects\"+argument0+".txt")
    objspr[i]=get_sprite(ds_map_find_value(object[i],"sprite"))
    objmaskr[i]=micro_optim_mask_id
    objmask[i]=ds_map_find_value(object[i],"mask")
    objvis[i]=real(ds_map_find_value(object[i],"visible"))
    objdepth[i]=real(ds_map_find_value(object[i],"depth"))
    objparent[i]=ds_map_find_value(object[i],"parent")
    objpersist[i]=real(ds_map_find_value(object[i],"persistent"))
    objsolid[i]=real(ds_map_find_value(object[i],"solid"))
    objfields[i]=0
    objprev_objectid[i]=noone
    objshow[i]=true
    objprops[i]="##Depth: "+string(objdepth[i])+"#Visible: "+pick(objvis[i],"No","Yes")+"#Solid: "+pick(objsolid[i],"No","Yes")+"#Persist.: "+pick(objpersist[i],"No","Yes")+"#Parent: "+pick(objparent[i]!="","<noone>",objparent[i])
    objdesc[i]=""
    objoverride[i,ovr_grid]=0
    load_object_fields(i,argument0)
    palettesize+=1
}
set_objpal(i)
return i
