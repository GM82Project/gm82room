if (mode==3) {
    //grabbed a view
    if (grabview) {
        if (keyboard_check(vk_alt)) {
            vw_x[vw_current]=mouse_x-offx
            vw_y[vw_current]=mouse_y-offy
        } else {
            vw_x[vw_current]=floorto(mouse_x-offx,gridx)
            vw_y[vw_current]=floorto(mouse_y-offy,gridy)
        }
        update_viewpanel()
        if (!mouse_check_direct(mb_left)) grabview=0
    }

    //resized a view
    if (sizeview) {
        if (keyboard_check(vk_alt)) {
            vw_w[vw_current]=max(1,mouse_x-vw_x[vw_current])
            vw_h[vw_current]=max(1,mouse_y-vw_y[vw_current])
        } else {
            vw_w[vw_current]=max(gridx,roundto(mouse_x,gridx)-vw_x[vw_current])
            vw_h[vw_current]=max(gridy,roundto(mouse_y,gridy)-vw_y[vw_current])
        }
        update_viewpanel()
        if (!mouse_check_direct(mb_left)) sizeview=0
    }
}
