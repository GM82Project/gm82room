if (!keyboard_check(vk_alt)) {
    x=roundto_unbiased(global.mousex-grabx-offx,gridx)+offx
    y=roundto_unbiased(global.mousey-graby-offy,gridy)+offy
} else {
    x=global.mousex-grabx
    y=global.mousey-graby
}
if (!direct_mbleft || !mouse_check_button(mb_left)) {
    grab=0
    update_inspector()
    do_change_undo("moving "+pick(mode,"instances","tiles","","","chunk"),0)
}
