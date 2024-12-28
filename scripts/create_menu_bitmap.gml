var s,fn;

fn=program_directory+"\cache\"+string(argument1)+".bmp"

if (!file_exists(fn)) {
    s=surface_create(16,16)

    surface_set_target(s)
    draw_clear_alpha(0,0)
    draw_sprite(argument0,argument1,8,8)
    surface_reset_target()

    surface_save(s,fn)
    surface_free(s)
}

return N_Menu_LoadBitmap(fn)
