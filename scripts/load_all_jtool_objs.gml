var first,last,succ,key;

first=ds_map_find_first(jtool_objs)
last=ds_map_find_last(jtool_objs)

if (!has_objects) return false

succ=true
for (key=first;key!=last;key=ds_map_find_next(jtool_objs,key)) {
    objname=ds_map_find_value(jtool_objs,key)
    if (file_exists(root+"objects\"+objname+".txt")) get_object(objname)
    else succ=false
}

return succ
