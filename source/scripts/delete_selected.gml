yes=1 with (TextField) if (active) yes=0 if (yes) with (Controller) {
    clear_inspector()
    select=noone
    selectt=noone
    if (num_selected()) begin_undo(act_create,"deleting "+pick(mode,"instances","tiles"),0)
    if (mode==0) with (instance) if (sel) {add_undo_instance() instance_destroy()}
    if (mode==1) with (tileholder) if (sel) {add_undo_tile() instance_destroy()}
    push_undo()
    selection=0
}
