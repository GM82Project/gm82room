var l,o,i,action,lmode,size;

if (!ds_stack_empty(undostack)) {
    l=ds_stack_pop(undostack)

    action=ds_list_find_value(l,0)
    lmode=ds_list_find_value(l,1)
    size=ds_list_size(l)-2
    i=2

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
