if (!keyboard_check(vk_alt)) {
    x=floorto(global.mousex-grabx-offx,gridx)+offx
    y=floorto(global.mousey-graby-offy,gridy)+offy
} else {
    x=global.mousex-grabx
    y=global.mousey-graby
}
if (!mouse_check_direct(mb_left) || !mouse_check_button(mb_left)) {
    grab=0
    update_inspector()
    do_change_undo("moving "+pick(mode,"instances","tiles","","","chunk"),0)
}
