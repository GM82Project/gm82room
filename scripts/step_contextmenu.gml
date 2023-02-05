var str,p;

click=N_Menu_CheckMenus()
if (click) {
    io_clear()
    if (menutype=="resourcefield") {
        resfieldid.fields[resfieldi,0]=1
        if (menusub=="sprite") {
            get=ds_map_get(sprmenuitems,click)
            if (get==undefined) resfieldid.fields[resfieldi,0]=0
            else resfieldid.fields[resfieldi,1]=get
        }
        if (menusub=="background") {
            get=ds_map_get(bgmenuitems,click)
            if (get==undefined) resfieldid.fields[resfieldi,0]=0
            else resfieldid.fields[resfieldi,1]=get
        }
        if (menusub=="path") {
            get=ds_map_get(pathmenuitems,click)
            if (get==undefined) resfieldid.fields[resfieldi,0]=0
            else resfieldid.fields[resfieldi,1]=get
        }
        if (menusub=="script") {
            get=ds_map_get(scriptmenuitems,click)
            if (get==undefined) resfieldid.fields[resfieldi,0]=0
            else resfieldid.fields[resfieldi,1]=get
        }
        if (menusub=="font") {
            get=ds_map_get(fontmenuitems,click)
            if (get==undefined) resfieldid.fields[resfieldi,0]=0
            else resfieldid.fields[resfieldi,1]=get
        }
        if (menusub=="timeline") {
            get=ds_map_get(timelinemenuitems,click)
            if (get==undefined) resfieldid.fields[resfieldi,0]=0
            else resfieldid.fields[resfieldi,1]=get
        }
        if (menusub=="object") {
            get=ds_map_get(objmenuitems,click)
            if (get==undefined) resfieldid.fields[resfieldi,0]=0
            else resfieldid.fields[resfieldi,1]=get
        }
        if (menusub=="room") {
            get=ds_map_get(roommenuitems,click)
            if (get==undefined) resfieldid.fields[resfieldi,0]=0
            else resfieldid.fields[resfieldi,1]=get
        }
        if (menusub=="datafile") {
            get=ds_map_get(datafilemenuitems,click)
            if (get==undefined) resfieldid.fields[resfieldi,0]=0
            else resfieldid.fields[resfieldi,1]=get
        }
        if (menusub=="constant") {
            get=ds_map_get(constmenuitems,click)
            if (get==undefined) resfieldid.fields[resfieldi,0]=0
            else {
                p=string_pos(" (",get)
                resfieldid.fields[resfieldi,1]=string_copy(get,1,p-1)
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
            update_newtilepanel()
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
