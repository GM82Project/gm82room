///select_path_point(point,deselect)

var old;

old=current_pathpoint
current_pathpoint=argument0

if (keyboard_check(vk_shift) && !argument1) {
    if (ds_list_find_index(path_sel,current_pathpoint)==-1) ds_list_add(path_sel,current_pathpoint)
    if (old!=noone) if (ds_list_find_index(path_sel,old)==-1) ds_list_add(path_sel,old)
    selection=1
} else {
    ds_list_clear(path_sel)
    selection=0
}

update_selection_bounds()
update_inspector()
