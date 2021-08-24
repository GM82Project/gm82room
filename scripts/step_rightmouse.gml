if (!keyboard_check(vk_control)) {
    if (mouse_check_button_pressed(mb_right)) {
        if (selecting) selecting=0
        clear_inspector()
        deselect()
        begin_undo(act_create,"erasing "+pick(mode,"instances","tiles"),0)
        erasing=1
    }
    if (erasing) {
        //delete instances
        if (mode==0) with (instance_position(global.mousex,global.mousey,instance)) {add_undo_instance() instance_destroy()}
        if (mode==1) with (instance_position(global.mousex,global.mousey,tileholder)) {add_undo_tile() instance_destroy()}

        if (!mouse_check_direct(mb_right)) {erasing=0 push_undo()}
    }
}
