if (objprev_objectid[obj]!=noone && !disabled_preview) {
    d3d_set_depth(depth)
    event_perform_object(objprev_objectid[obj],ev_other,ev_user0+objprev_eventid[obj])

    draw_set_font(fntCode)
    draw_reset()
}
