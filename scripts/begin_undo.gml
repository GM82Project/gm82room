///begin_undo(act_type,description)

with (Controller) {
    undolist=ds_list_create()
    ds_list_add(undolist,argument1)
    ds_list_add(undolist,argument0)
    ds_list_add(undolist,mode)
    undoing=1
}
