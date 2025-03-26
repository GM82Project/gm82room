if (!argument_count) {
    //called from the tool button
    if (!skipwarnings) if (!show_question("Swap Instance Objects##This tool will replace the object associated with all selected instances. Note that this will erase any fields associated with such instances as fields are bound to specific objects.##Proceed?")) exit
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

    var i,j,compatible,oldobj,oldcount,ofields;


    begin_undo(act_alchemy,"replacing objects",0)
    with (instance) {
        if (sel==checksel) {
            oldobj=obj
            add_undo(uid)
            add_undo(obj)

            for (i=0;i<objfields[obj];i+=1) {
                add_undo(fields[i,0])
                if (fields[i,0]) {
                    add_undo(fields[i,1])
                    if (objfieldtype[obj,i] == "xy")
                        add_undo(fields[i,2])
                }
            }

            objname=name
            obj=newobj

            depth=objdepth[obj]
            sprite_index=objspr[obj]

            sprw=sprite_get_width(sprite_index)
            sprh=sprite_get_height(sprite_index)
            sprox=sprite_get_xoffset(sprite_index)
            sproy=sprite_get_yoffset(sprite_index)

            for (i=0;i<objfields[oldobj];i+=1) {
                ofields[i,0]=fields[i,0]
                ofields[i,1]=fields[i,1]
                ofields[i,2]=fields[i,2]
            }

            init_instance_fields(id)

            for (i=0;i<objfields[obj];i+=1) {
                compatible=-1
                for (j=0;j<objfields[oldobj];j+=1) {
                    if (objfieldtype[obj,i]==objfieldtype[oldobj,j])
                    and (objfieldname[obj,i]==objfieldname[oldobj,j]) {
                       compatible=j
                       break
                    }
                }
                if (compatible!=-1) {
                    fields[i,0]=ofields[compatible,0]
                    fields[i,1]=ofields[compatible,1]
                    fields[i,2]=ofields[compatible,2]
                    hasfields=1
                }
            }
        }
    }
    push_undo()

    change_mode(mode)
}
