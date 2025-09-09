var str,p;

click=N_Menu_CheckMenus()
if (click) {
    io_clear()
    if (menutype=="pluginmenu") {
        get=ds_map_get(pluginmenuitems,click)
        if (show_question(plugindesc[get]+"##Proceed?")) code_execute(plugincode[get])
    }
    if (menutype=="toolmenu") {
        get=ds_map_get(toolmenuitems,click)
        switch (get) {
            case 0: {replace_instances()}break
            case 1: {load_jmap()}break
            case 2: {parsecode_instances()}break
            case 3: {cleanup_instances()}break
            case 4: {cement_instances()}break
            case 5: {subdivide_instances()}break
        }
    }
    if (menutype=="resourcefield") {
        if (menusub=="sprite")     get=ds_map_get(sprmenuitems,click)
        if (menusub=="background") get=ds_map_get(bgmenuitems,click)
        if (menusub=="path")       get=ds_map_get(pathmenuitems,click)
        if (menusub=="sound")      get=ds_map_get(soundmenuitems,click)
        if (menusub=="script")     get=ds_map_get(scriptmenuitems,click)
        if (menusub=="font")       get=ds_map_get(fontmenuitems,click)
        if (menusub=="timeline")   get=ds_map_get(timelinemenuitems,click)
        if (menusub=="object")     get=ds_map_get(objmenuitems,click)
        if (menusub=="room")       get=ds_map_get(roommenuitems,click)
        if (menusub=="datafile")   get=ds_map_get(datafilemenuitems,click)
        if (menusub=="constant")   get=ds_map_get(constmenuitems,click)

        if (menusub=="path" && string(get)==string(noone)) {
            pathname=get_new_path_name("path"+string(ds_list_size(path_index_list))+"_"+resfieldid.objname+"_"+resfieldid.uid)

            //create a new path for this field
            resfieldid.fields[resfieldi,0]=1
            resfieldid.fields[resfieldi,1]=pathname
            change_mode(5)

            current_path=path_add()
            ds_map_add(pathmap_model,pathname,d3d_model_create())
            ds_map_add(pathmap_path,pathname,current_path)
            ds_map_set(pathmap_edited,pathname,true)
            item=N_Menu_AddItem(pathmenu,pathname,"")
            N_Menu_ItemSetBitmap(pathmenu,item,path_menuicon)
            ds_map_add(pathmenuitems,item,pathname)
            path_set_closed(current_path,0)
            path_set_precision(current_path,4)
            path_set_kind(current_path,0)
            path_add_point(current_path,round(resfieldid.x),round(resfieldid.y),100)

            current_pathname=pathname
            current_pathpoint=0
            ds_list_clear(path_sel)
            selection=0
            generate_path_model(current_pathname)
            update_inspector()
            update_selection_bounds()

            ds_list_add(path_index_list,pathname)
            ds_list_add(path_tree_list,"|"+pathname)
            ds_map_add(path_tree_map,pathname,"|"+pathname)
        } else if (get==undefined) resfieldid.fields[resfieldi,0]=0
        else {
            if (invalid_variable_name(get)) {
                show_message("This resource has invalid characters in its name and can't be used on a field:##"+qt+get+qt+"##Click the broom icon in Game Maker and resolve any such problems.")
            } else {
                resfieldid.fields[resfieldi,0]=1
                resfieldid.fields[resfieldi,1]=get
            }
        }
    }
    if (menutype=="replaceobj") {
        replace_instances(ds_map_get(objmenuitems,click))
    }
    if (menutype=="object") {
        str=ds_map_get(objmenuitems,click)
        if (mode==0) {
            if (str!=undefined) {
                get_object(str)
                textfield_set("palette name",ds_list_find_value(objects,objpal))
            }
        }
        if (mode==3) {
            if (str==undefined) {
                undo_globalvec("vw_follow",vw_current,"view "+string(vw_current)+" options")
                vw_follow[vw_current]=""
                textfield_set("view follow","")
            } else {
                undo_globalvec("vw_follow",vw_current,"view "+string(vw_current)+" options")
                vw_follow[vw_current]=ds_map_find_value(objmenuitems,click)
                textfield_set("view follow",vw_follow[vw_current])
            }
        }
    }
    if (menutype=="background") {
        str=ds_map_get(bgmenuitems,click)
        begin_undo(act_globalvec,"background "+string(bg_current)+" options",0) add_undo("bg_tex") add_undo(bg_current) add_undo(bg_tex[bg_current]) push_undo()
        begin_undo(act_globalvec,"",1) add_undo("bg_source") add_undo(bg_current) add_undo(bg_source[bg_current]) push_undo()
        begin_undo(act_globalvec,"",1) add_undo("bg_visible") add_undo(bg_current) add_undo(bg_visible[bg_current]) push_undo()
        if (str==undefined) {
            bg_tex[bg_current]=bgDefault
            bg_source[bg_current]=""
            bg_visible[bg_current]=0
        } else {
            bg_tex[bg_current]=get_background(str)
            bg_source[bg_current]=str
            bg_visible[bg_current]=1
        }
        update_backgroundpanel()
    }
    if (menutype=="tilebg") {
        str=ds_map_get(bgmenuitems,click)
        if (str!=undefined) {
            get_background_tiles(str)
            tilebgpal=micro_optimization_bgid
            tilebgname=str
            tilepal=0
            update_newtilepanel(1)
        }
    }
    if (menutype=="search") {
        str=ds_map_get(searchmenuitems,click)
        if (str!=undefined) {
            if (mode==0) {
                get_object(str)
                textfield_set("palette name",ds_list_find_value(objects,objpal))
            }
        }
    }
}
