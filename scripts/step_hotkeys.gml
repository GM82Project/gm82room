if (keyboard_check(vk_control) && keyboard_check_pressed(ord("Z"))) {
    pop_undo()
}
if (keyboard_check_pressed(vk_escape)) {
    with (TextField) textfield_actions()
    clear_inspector()
    deselect()
}

if (keyboard_check_pressed(vk_delete)) {
    clear_inspector()
    select=noone
    selectt=noone
    if (num_selected()) begin_undo(act_create)
    if (mode==0) with (instance) if (sel) {add_undo_instance() instance_destroy()}
    if (mode==1) with (tileholder) if (sel) {add_undo_tile() instance_destroy()}
    push_undo()
}
