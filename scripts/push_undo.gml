var type;
with (Controller) if (undoing) {
    if (ds_list_size(undolist)>4) {
        ds_list_add(undolist,current_undo_size)
        ds_list_add(undostack,undolist)
        total_undo_size+=current_undo_size
        current_undo_size=0

        while (total_undo_size>undospace) {
            l=ds_list_find_value(undostack,0)
            total_undo_size-=ds_list_find_value(l,ds_list_size(l)-1)
            ds_list_destroy(l)
            ds_list_delete(undostack,0)
        }
    } else {
        ds_list_destroy(undolist)
    }
    update_undo_button()
    undolist=noone
    undoing=0
}
