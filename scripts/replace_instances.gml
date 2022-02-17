if (!argument_count) {
    //called from the tool button
    N_Menu_ShowPopupMenu(window_handle(),objmenu,window_get_x()+mouse_wx,window_get_y()+mouse_wy,0)
    menutype="replaceobj"
} else {
    //called from the menu callback
    instance_activate_object(instance)

    var tmp;tmp=objpal

    //load new object in
    get_object(argument[0])
    var newobj;newobj=objpal

    objpal=tmp

    var name;name=ds_list_find_value(objects,newobj)
    var checksel;checksel=!!num_selected()

    begin_undo(act_alchemy,"replacing objects",0)
    add_undo(ds_list_find_value(objects,objpal))
    add_undo(objpal)
    with (instance) {
        if (obj==objpal && sel==checksel) {
            add_undo(uid)
            objname=name
            obj=newobj

            depth=objdepth[obj]
            sprite_index=objspr[obj]

            sprw=sprite_get_width(sprite_index)
            sprh=sprite_get_height(sprite_index)
            sprox=sprite_get_xoffset(sprite_index)
            sproy=sprite_get_yoffset(sprite_index)
        }
    }
    push_undo()

    change_mode(mode)
}
