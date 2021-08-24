if (!keyboard_check(vk_alt)) {
    x=floorto(global.mousex-grabx-offx,gridx)+offx
    y=floorto(global.mousey-graby-offy,gridy)+offy
} else {
    x=global.mousex-grabx
    y=global.mousey-graby
}
if (!mouse_check_direct(mb_left)) {
    grab=0
    do_change_undo("moving "+pick(mode,"instances","tiles"),0)
}
