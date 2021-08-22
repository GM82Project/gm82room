var type;
with (Controller) if (undoing) {
    if (ds_list_size(undolist)>4) {
        ds_stack_push(undostack,undolist)
    } else {
        ds_list_destroy(undolist)
    }
    with (Button) if (action="undo") {
        if (ds_stack_empty(undostack)) alt="Undo"
        else alt="Undo "+ds_list_find_value(ds_stack_top(undostack),1)+" ("+string(ds_stack_size(undostack))+" left)"
    }
    undolist=noone
    undoing=0
}
