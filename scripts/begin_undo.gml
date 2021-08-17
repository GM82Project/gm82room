///begin_undo(action_type)

with (Controller) {
    undolist=ds_list_create()
    ds_list_add(undolist,argument0)
    ds_list_add(undolist,mode)
    undoing=1
}
