var str;

click=N_Menu_CheckMenus()
if (click) {
    if (menutype=="object") {
        str=ds_map_find_value(objmenuitems,click)
        if (mode==0) {
            if (str!="<undefined>") {
                get_object(str)
                textfield_set("palette name",ds_list_find_value(objects,objpal))
            }
        }
        if (mode==3) {
            if (str=="<undefined>") {
                vw_follow[vw_current]=noone
                textfield_set("view follow","")
            } else {
                vw_follow[vw_current]=ds_map_find_value(objmenuitems,click)
                textfield_set("view follow",vw_follow[vw_current])
            }
        }
    }
    if (menutype=="background") {
        str=ds_map_find_value(bgmenuitems,click)
        if (str=="<undefined>") {
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
        str=ds_map_find_value(bgmenuitems,click)
        if (str!="<undefined>") {
            get_background(str)
            tilebgpal=micro_optimization_bgid
            tilebgname=str
            tilepal=0
            update_tilepanel()
        }
    }
}
