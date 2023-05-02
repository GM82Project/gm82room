if (mode==2) {
    if (bg_visible[bg_current]) {
        begin_undo(act_globalvec,"background "+string(bg_current)+" options",0)
        add_undo("bg_xoffset") add_undo(bg_current)
        add_undo(bg_xoffset[bg_current])
        push_undo()
        begin_undo(act_globalvec,"background "+string(bg_current)+" options",1)
        add_undo("bg_yoffset") add_undo(bg_current)
        add_undo(bg_yoffset[bg_current])
        push_undo()
        grab_background=true
        grab_bgoffx=bg_xoffset[bg_current]-global.mousex
        grab_bgoffy=bg_yoffset[bg_current]-global.mousey
    }
}
