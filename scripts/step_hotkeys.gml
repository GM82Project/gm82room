var yes;

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
    if (num_selected()) begin_undo(act_create,"deleting "+pick(mode,"instances","tiles"),0)
    if (mode==0) with (instance) if (sel) {add_undo_instance() instance_destroy()}
    if (mode==1) with (tileholder) if (sel) {add_undo_tile() instance_destroy()}
    push_undo()
}

var h,v;

h=keyboard_check_pressed(vk_right)-keyboard_check_pressed(vk_left)
v=keyboard_check_pressed(vk_down)-keyboard_check_pressed(vk_up)

if (h!=0 || v!=0) {
    yes=1
    with (TextField) if (active) yes=0
    if (yes) {
        keyboard_clear(vk_left)
        keyboard_clear(vk_right)
        keyboard_clear(vk_up)
        keyboard_clear(vk_down)
        if (keyboard_check(vk_shift)) {h*=gridx v*=gridy}
        if (mode==0) {
            with (instance) if (sel) {x+=h y+=v}
            with (select) update_inspector()
        }
        if (mode==1) {
            with (tileholder) if (sel) {x+=h y+=v}
            with (selectt) update_inspector()
        }
    }
}
