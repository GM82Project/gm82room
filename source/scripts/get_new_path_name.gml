var pathname;

pathname=get_string("Name of the new path:",argument0)
while (ds_list_find_index(path_index_list,pathname)!=-1) {
    pathname=get_string("There already is a path called "+qt+pathname+qt+". Please choose a different name:",pathname)
}

return pathname
