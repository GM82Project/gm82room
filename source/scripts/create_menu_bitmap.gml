///create_menu_bitmap(sprite,image,filename)
var s,fn;

fn=program_directory+"\cache\"+argument2+".bmp"

if (!file_exists(fn)) {
    s=surface_create(16,16)

    surface_set_target(s)
    draw_clear_alpha(0,0)
    draw_sprite_stretched(argument0,argument1,0,0,16,16)
    surface_reset_target()

    surface_save(s,fn)
    surface_free(s)
}

return N_Menu_LoadBitmap(fn)
