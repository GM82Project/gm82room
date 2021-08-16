var l,o,i,action,size;

if (!ds_stack_empty(undostack)) {
    l=ds_stack_pop(undostack)

    action=ds_list_find_value(l,0)
    size=ds_list_size(l)-1
    i=1

    instance_activate_all()

    switch (action) {
        case act_destroy: {
            repeat (size) {
                with (ds_list_find_value(l,i)) instance_destroy()
                i+=1
            }
        }
    }

    ds_list_destroy(l)

    change_mode(mode)
}
