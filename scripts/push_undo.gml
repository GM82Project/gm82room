with (Controller) if (undoing) {
    if (ds_list_size(undolist)>2) {
        ds_stack_push(undostack,undolist)
    } else {
        ds_list_destroy(undolist)
    }
    undolist=noone
    undoing=0
}
