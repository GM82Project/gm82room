///begin_undo(act_type,description,combo)

with (Controller) {
    undolist=ds_list_create()
    ds_list_add(undolist,argument0)
    ds_list_add(undolist,argument1)
    ds_list_add(undolist,argument2)
    ds_list_add(undolist,mode)
    undoing=1
    current_undo_size=24*4
}
