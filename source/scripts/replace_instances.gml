if (!argument_count) {
    //called from the tool button
    if (!show_question("Swap Instance Objects##This tool will replace the object associated with all selected instances. Note that this will erase any fields associated with such instances as fields are bound to specific objects.##Proceed?")) exit
    call_nmenu("replaceobj",objmenu)
} else {
    //called from the menu callback

    if (argument[0]==undefined) {
        //user selected nothing in the menu
        exit
    }

    instance_activate_object(instance)

    var tmp;tmp=objpal

    //load new object in
    get_object(argument[0])
    var newobj;newobj=objpal

    set_objpal(tmp)

    var name;name=ds_list_find_value(objects,newobj)
    var checksel;checksel=!!num_selected()

    begin_undo(act_alchemy,"replacing objects",0)
    with (instance) {
        if (sel==checksel) {
            add_undo(uid)
            add_undo(obj)
            objname=name
            obj=newobj

            depth=objdepth[obj]
            sprite_index=objspr[obj]

            sprw=sprite_get_width(sprite_index)
            sprh=sprite_get_height(sprite_index)
            sprox=sprite_get_xoffset(sprite_index)
            sproy=sprite_get_yoffset(sprite_index)

            init_instance_fields(id)
        }
    }
    push_undo()

    change_mode(mode)
}
