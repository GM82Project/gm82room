var del,c;

if (num_selected()) {
    yes=1 with (TextField) if (active) yes=0 if (yes) with (Controller) {
        clear_inspector()
        select=noone
        selectt=noone
        c=0
        begin_undo(act_create,"deleting "+pick(mode,"instances","tiles"),0)
        if (mode==0) with (instance) if (sel) {add_undo_instance() del[c]=id c+=1}
        if (mode==1) with (tileholder) if (sel) {add_undo_tile() del[c]=id c+=1}
        push_undo()

        repeat (c) {c-=1 with (del[c]) instance_destroy()}

        selection=0
    }
}
