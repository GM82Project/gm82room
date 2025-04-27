with (TextField) textfield_actions()

select=noone
selectt=noone
with (instance) {sel=0 fieldactive=0}
with (tileholder) sel=0

chunkloaded=0
selection=0

if (mode==5) {
    ds_list_clear(path_sel)
    if (current_path!=noone) {
        current_path=noone
        generate_path_model(current_pathname)
    }
    current_pathname=""
}

clear_inspector()
update_selection_bounds()
