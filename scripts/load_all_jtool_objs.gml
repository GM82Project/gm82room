var first,last,succ,key;

key=ds_map_find_first(jtool_objs)

if (!has_objects) return false

succ=true
repeat (ds_map_size(jtool_objs)) {
    objname=ds_map_find_value(jtool_objs,key)
    if (file_exists(root+"objects\"+objname+".txt")) get_object(objname)
    else succ=false
key=ds_map_find_next(jtool_objs,key)}

return succ
