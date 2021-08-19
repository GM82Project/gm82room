if (mode==3) {
    //grabbed a view
    if (grabview) {
        if (keyboard_check(vk_alt)) {
            vw_x[vw_current]=global.mousex-offx
            vw_y[vw_current]=global.mousey-offy
        } else {
            vw_x[vw_current]=floorto(global.mousex-offx,gridx)
            vw_y[vw_current]=floorto(global.mousey-offy,gridy)
        }
        update_viewpanel()
        if (!mouse_check_direct(mb_left)) grabview=0
    }

    //resized a view
    if (sizeview) {
        if (keyboard_check(vk_alt)) {
            vw_w[vw_current]=max(1,global.mousex-vw_x[vw_current])
            vw_h[vw_current]=max(1,global.mousey-vw_y[vw_current])
        } else {
            vw_w[vw_current]=max(gridx,roundto(global.mousex,gridx)-vw_x[vw_current])
            vw_h[vw_current]=max(gridy,roundto(global.mousey,gridy)-vw_y[vw_current])
        }
        update_viewpanel()
        if (!mouse_check_direct(mb_left)) sizeview=0
    }
}
