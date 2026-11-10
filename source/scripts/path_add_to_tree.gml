var rn,findpos,l,i,str,indent,indentation;

rn="+"+roomname

findpos=-1
l=ds_list_size(path_tree_list)
i=0 repeat (l) {
    str=ds_list_find_value(path_tree_list,i)
    if (string_ends_with(str,rn)) {
        findpos=i
        indent=string_count(tab,str)
        indentation=string_repeat(tab,indent)
        break
    }
i+=1}

if (findpos!=-1) {
    while 1 {
        findpos+=1
        if (findpos>=l) break //end of list

        str=ds_list_find_value(path_tree_list,findpos)

        if (string_pos(indentation+"+",str)) break //found a subfolder
        if (string_count(tab,str)!=indent) break //end of folder
    }
} else {
    //there is no folder for this room. make one
    ds_list_add(path_tree_list,rn)
    findpos=ds_list_size(path_tree_list)
    indentation=""
}

ds_list_insert(path_tree_list,findpos,indentation+tab+"|"+argument0)
ds_list_add(path_index_list,argument0)
ds_map_add(path_tree_map,argument0,indentation+tab+"|"+argument0)
