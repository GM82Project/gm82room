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
        if (!direct_mbleft) {
            begin_undo(act_globalvec,"changing view "+string(vw_current)+" position",0) add_undo("vw_x") add_undo(vw_current) add_undo(storex) add_undo("vw_y") add_undo(vw_current) add_undo(storey) push_undo()
            grabview=0
        }
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
        vw_wp[vw_current]=vw_w[vw_current]
        vw_hp[vw_current]=vw_h[vw_current]
        update_viewpanel()
        if (!direct_mbleft) {
            begin_undo(act_globalvec,"changing view "+string(vw_current)+" size",0) add_undo("vw_w") add_undo(vw_current) add_undo(storex) add_undo("vw_h") add_undo(vw_current) add_undo(storey) add_undo("vw_wp") add_undo(vw_current) add_undo(storexp) add_undo("vw_hp") add_undo(vw_current) add_undo(storeyp) push_undo()
            sizeview=0
        }
    }
}
