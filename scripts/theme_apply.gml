var dir;dir="SOFTWARE\Game Maker\Version 8.2\Preferences\"

if (theme==0) {
    global.col_low=$203020
    global.col_main=$404040
    global.col_high=$607060
    global.col_text=$ffffff
    buttontex=sprButton0
    message_button(sprButton0)
}
if (theme==1) {
    global.col_low=$808080
    global.col_main=$c0c0c0
    global.col_high=$ffffff
    global.col_text=$000000
    buttontex=sprButton1
    message_button(sprButton1)
}

if (theme==2) {
    a=sprButtonWhitemask
    if (themebutton=1 || themebutton=2) a=sprButtonWhitemaskSmooth
    s=surface_create(80,25)
    surface_set_target(s)
    draw_clear(global.col_main)
    draw_sprite_ext(a,0,0,0,1,1,0,global.col_high,1)
    draw_sprite_ext(a,1,0,0,1,1,0,global.col_low,1)
    if (themebutton=2) draw_rectangle_color(0,0,79,24,global.col_text,global.col_text,global.col_text,global.col_text,1)
    spr=sprite_create_from_surface(s,0,0,80,25,0,0,0,0)
    sprite_add_from_surface(spr,s,0,0,80,25,0,0)
    draw_clear(global.col_main)
    draw_sprite_ext(a,0,0,0,1,1,0,global.col_low,1)
    draw_sprite_ext(a,1,0,0,1,1,0,global.col_high,1)
    if (themebutton=2) draw_rectangle_color(0,0,79,24,global.col_text,global.col_text,global.col_text,global.col_text,1)
    sprite_add_from_surface(spr,s,0,0,80,25,0,0)
    surface_reset_target()
    surface_free(s)
    sprite_assign(sprButton,spr)
    message_button(sprButton)
    buttontex=sprButton
}

background_assign(bgMessage,background_create_color(1,1,global.col_main))
message_background(bgMessage)
message_text_font("Courier New",12,global.col_text,1)
message_button_font("Courier New",12,global.col_text,1)
message_input_font("Courier New",12,global.col_text,1)
message_mouse_color(global.col_text)
