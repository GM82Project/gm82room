var sx,sy,cx,cy,cl,ct,cr,cb,mycx,mycy;

cl=max_int
ct=max_int
cr=-max_int
cb=-max_int

with (Controller) switch (argument0) {
    //top panel
    case "save and quit": {save_room(0) game_end()}break
    case "test game"    : {test_run()}break
    case "object mode"  : {change_mode(0)}break
    case "tile mode"    : {change_mode(1)}break
    case "bg mode"      : {change_mode(2)}break
    case "view mode"    : {change_mode(3)}break
    case "settings mode": {change_mode(4)}break
    case "path mode"    : {change_mode(5)}break
    case "help"         : {show_info()}break
    case "prefs"        : {show_prefs() write_preferences()}break
    case "live"         : {live_start()}break
    case "undo"         : {pop_undo()}break
    case "plugins"      : {if (noplugins) show_message("There are no plugins installed.") else call_nmenu("pluginmenu",pluginmenu)}break


    //settings
    case "room code"   : {undo_global("roomcode","room creation code") roomcode=external_code_editor(roomcode) other.alt=roomcode}break
    case "room persist": {undo_global("roompersistent","room options") roompersistent=!roompersistent}break
    case "room clear"  : {undo_global("clearview","room options") clearview=!clearview}break

    case "chunk crop"  : {chunkcrop=!chunkcrop if (!chunkcrop) chunkleft=0 chunktop=0 chunkwidth=roomwidth chunkheight=roomheight update_settingspanel()}break
    case "chunk export": {chunk_export()}break
    case "chunk import": {chunk_import()}break

    case "ref load"    : {load_reference(get_open_filename("Images|*.jpg;*.jpeg;*.png;*.gif;*.bmp",""))}break
    case "ref top"     : {ref_top=!ref_top}break
    case "ref move"    : {ref_moving=!ref_moving && ref_loaded if (ref_moving) view[8]=1}break
    case "ref reset"   : {ref_x=0 ref_y=0 ref_w=ref_u ref_h=ref_v ref_angle=0 update_settingspanel()}break

    case "screen draw" : {screen_grid_draw=!screen_grid_draw}break

    //visibility
    case "view objects": {view[0]=!view[0] change_mode(mode)}break
    case "view tiles"  : {view[1]=!view[1] change_mode(mode)}break
    case "view bgs"    : {view[2]=!view[2]}break
    case "view fgs"    : {view[3]=!view[3]}break
    case "view views"  : {view[4]=!view[4]}break
    case "view invis"  : {view[5]=!view[5] change_mode(mode)}break
    case "view nospr"  : {view[6]=!view[6] change_mode(mode)}break
    case "view paths"  : {view[7]=!view[7]}break
    case "view ref"    : {if (ref_loaded) view[8]=!view[8]}break
    case "view draw"   : {view[9]=!view[9] if (!view[9]) disable_preview_fields()}break
    case "view ignore" : {view[10]=!view[10] change_mode(mode)}break

    //zoom
    case "reset view"      : {xgo=roomwidth/2 ygo=roomheight/2 zoomgo=1 zoomcenter=1}break
    case "zoom in"         : {zoomgo/=1.2 zoomcenter=1}break
    case "zoom out"        : {zoomgo*=1.2 zoomcenter=1}break
    case "interp"          : {interpolation=!interpolation}break
    case "toggle grid"     : {grid=!grid}break
    case "toggle crosshair": {crosshair=!crosshair}break


    //instance inspector
    case "copy object"   : {clipboard_set_text(roomname+"_"+select.uid)}break
    case "inst code"     : {edit_creation_code()}break
    case "inst snap"     : {with (instance) if (sel) {x=roundto_unbiased(x,gridx) y=roundto_unbiased(y,gridy) do_change_undo("snapping",0) if (select==id) update_inspector() update_selection_bounds()}}break
    case "inst flip xs": {
        with (instance) if (sel) {
            cl=min(cl,bbox_left)
            ct=min(ct,bbox_top)
            cr=max(cr,bbox_right+1)
            cb=max(cb,bbox_bottom+1)
        }
        sx=round((cl+cr)/2)
        sy=round((ct+cb)/2)
        with (instance) if (sel) {
            mycx=round((bbox_right+bbox_left+1)/2) mycy=round((bbox_bottom+bbox_top+1)/2)
            image_xscale*=-1 image_angle*=-1
            if (!skiprecenter) x=round(x-((bbox_right+bbox_left+1)/2-mycx))+(sx-mycx)*2
            event_user(1)
            do_change_undo("mirroring",0)
            if (select==id) update_inspector()
        }
        update_selection_bounds()
    }break
    case "inst flip ys": {
        with (instance) if (sel) {
            cl=min(cl,bbox_left)
            ct=min(ct,bbox_top)
            cr=max(cr,bbox_right+1)
            cb=max(cb,bbox_bottom+1)
        }
        sx=round((cl+cr)/2)
        sy=round((ct+cb)/2)
        with (instance) if (sel) {
            mycx=round((bbox_right+bbox_left+1)/2) mycy=round((bbox_bottom+bbox_top+1)/2)
            image_yscale*=-1 image_angle*=-1
            if (!skiprecenter) y=round(y-((bbox_bottom+bbox_top+1)/2-mycy))+(sy-mycy)*2
            event_user(1)
            do_change_undo("flipping",0)
            if (select==id) update_inspector()
        }
        update_selection_bounds()
    }break
    case "inst centerx": {
        cx=roomwidth div 2
        with (instance) if (sel) {
            if (x==cx) x=round(cx-(bbox_right+1-bbox_left)/2) else x=cx
            if (select==id) update_inspector()
        }
        update_selection_bounds()
    }break
    case "inst centery": {
        cy=roomheight div 2
        with (instance) if (sel) {
            if (y==cy) y=round(cy-(bbox_bottom+1-bbox_top)/2) else y=cy
            if (select==id) update_inspector()
        }
        update_selection_bounds()
    }break
    case "inst rot left" : {
        with (instance) if (sel) {
            cl=min(cl,bbox_left)
            ct=min(ct,bbox_top)
            cr=max(cr,bbox_right+1)
            cb=max(cb,bbox_bottom+1)
        }
        sx=round((cl+cr)/2)
        sy=round((ct+cb)/2)
        with (instance) if (sel) {
            image_angle=modwrap(image_angle+90,0,360)
            mycx=sx+(y+0.5-sy)-0.5 mycy=sy-(x+0.5-sx)-0.5
            if (!skiprecenter) {x=mycx y=mycy}
            event_user(1)
            do_change_undo("rotation",0)
            if (select==id) update_inspector()
        }
        update_selection_bounds()
    }break
    case "inst rot right": {
        with (instance) if (sel) {
            cl=min(cl,bbox_left)
            ct=min(ct,bbox_top)
            cr=max(cr,bbox_right+1)
            cb=max(cb,bbox_bottom+1)
        }
        sx=round((cl+cr)/2)
        sy=round((ct+cb)/2)
        with (instance) if (sel) {
            image_angle=modwrap(image_angle-90,0,360)
            mycx=sx-(y+0.5-sy)-0.5 mycy=sy+(x+0.5-sx)-0.5
            if (!skiprecenter) {x=mycx y=mycy}
            event_user(1)
            do_change_undo("rotation",0)
            if (select==id) update_inspector()
        }
        update_selection_bounds()
    }break


    //instances
    case "palscroldown" : {palettescrollgo-=192}break
    case "palscrolup"   : {palettescrollgo+=192}break
    case "overlap check": {overlap_check=!overlap_check}break
    case "object search": {search_for_objects(get_string("Object name:",""))}break

    case "tools"        : {call_nmenu("toolmenu",toolmenu)}break

    case "instance list": {Instancepanel.open=!Instancepanel.open if (Instancepanel.open) {Instancepanel.updatew=1 Instancepanel.update_scheduled=true update_instancepanel()}}break
    case "ilistscrolup":  {with (Instancepanel) scroll=max(0,scroll-3)}break
    case "ilistscroldown":{with (Instancepanel) scroll=min(scroll+3,length-showlength)}break

    case "ilist up":      {ilist_move_instances(-1)}break
    case "ilist down":    {ilist_move_instances(1)}break
    case "ilist top":     {ilist_move_instances(-2)}break
    case "ilist bottom":  {ilist_move_instances(2)}break
    case "ilist charm":   {ilist_copy_many()}break
    case "ilist strange": {delete_selected()}break


    //tiles
    case "tile palscroldown" : {tpalscrollgo-=192}break
    case "tile palscrolup"   : {tpalscrollgo+=192}break
    case "tile overlap check": {tile_overlap_check=!tile_overlap_check}break

    case "tile panel grid"    : {tilepickgrid=!tilepickgrid}break
    case "tile panel zoom out": {Tilepanel.zgo=roundto(min(8,Tilepanel.zgo*2),1/8)}break
    case "tile panel zoom in" : {Tilepanel.zgo=roundto(max(1/8,Tilepanel.zgo/2),1/8)}break

    //tile inspector
    case "tile snap": {
        with (tileholder) if (sel) {
            x=roundto_unbiased(x,gridx) y=roundto_unbiased(y,gridy)
            tile_set_position(tile,x,y)
            do_change_undo("snapping",0)
            if (selectt==id) update_inspector()
            update_selection_bounds()
        }
    }break
    case "tile flip xs": {
        with (tileholder) if (sel) {
            cl=min(cl,bbox_left)
            ct=min(ct,bbox_top)
            cr=max(cr,bbox_right+1)
            cb=max(cb,bbox_bottom+1)
        }
        sx=round((cl+cr)/2)
        sy=round((ct+cb)/2)
        with (tileholder) if (sel) {
            mycx=round((bbox_right+bbox_left+1)/2)
            image_xscale*=-1
            if (!skiprecenter) x=round(x-((bbox_right+bbox_left+1)/2-mycx))+(sx-mycx)*2
            event_user(1)
            tilesx=image_xscale/tilew
            tilesy=image_yscale/tileh
            tile_set_position(tile,x,y)
            tile_set_scale(tile,tilesx,tilesy)
            do_change_undo("mirroring",0)
            if (selectt==id) update_inspector()
        }
        update_selection_bounds()
    }break
    case "tile flip ys": {
        with (tileholder) if (sel) {
            cl=min(cl,bbox_left)
            ct=min(ct,bbox_top)
            cr=max(cr,bbox_right+1)
            cb=max(cb,bbox_bottom+1)
        }
        sx=round((cl+cr)/2)
        sy=round((ct+cb)/2)
        with (tileholder) if (sel) {
            mycy=round((bbox_bottom+bbox_top+1)/2)
            image_yscale*=-1
            if (!skiprecenter) y=round(y-((bbox_bottom+bbox_top+1)/2-mycy))+(sy-mycy)*2
            event_user(1)
            tilesx=image_xscale/tilew
            tilesy=image_yscale/tileh
            tile_set_position(tile,x,y)
            tile_set_scale(tile,tilesx,tilesy)
            do_change_undo("flipping",0)
            if (selectt==id) update_inspector()
        }
        update_selection_bounds()
    }break
    case "tile centerx": {
        cx=roomwidth div 2
        with (tileholder) if (sel) {
            if (x==cx) x=round(cx-(bbox_right+1-bbox_left)/2) else x=cx
            tile_set_position(tile,x,y)
            if (selectt==id) update_inspector()
        }
        update_selection_bounds()
    }break
    case "tile centery": {
        cy=roomheight div 2
        with (tileholder) if (sel) {
            if (y==cy) y=round(cy-(bbox_bottom+1-bbox_top)/2) else y=cy
            tile_set_position(tile,x,y)
            if (selectt==id) update_inspector()
        }
        update_selection_bounds()
    }break

    case "layerscroldown": {layerscrollgo-=192}break
    case "layerscrolup"  : {layerscrollgo+=192}break
    case "layer dupe"    : {dupe_tile_layer()}break
    case "layer delete"  : {del_tile_layer()}break


    //backgrounds
    case "clear bg"  : {undo_global("clearscreen","room options") clearscreen=!clearscreen}break
    case "bgselect"  : {bg_current=other.actionid update_backgroundpanel()}break
    case "bg visible": {undo_globalvec("bg_visible",bg_current,"background "+string(bg_current)+" options") bg_visible[bg_current]=!bg_visible[bg_current]}break
    case "bg fore"   : {undo_globalvec("bg_is_foreground",bg_current,"background "+string(bg_current)+" options") bg_is_foreground[bg_current]=!bg_is_foreground[bg_current]}break
    case "bg tileh"  : {undo_globalvec("bg_tile_h",bg_current,"background "+string(bg_current)+" options") bg_tile_h[bg_current]=!bg_tile_h[bg_current]}break
    case "bg tilev"  : {undo_globalvec("bg_tile_v",bg_current,"background "+string(bg_current)+" options") bg_tile_v[bg_current]=!bg_tile_v[bg_current]}break
    case "bg stretch": {undo_globalvec("bg_stretch",bg_current,"background "+string(bg_current)+" options") bg_stretch[bg_current]=!bg_stretch[bg_current] update_backgroundpanel()}break


    //views
    case "vwselect": {vw_current=other.actionid update_viewpanel()}break
    case "enable views": {undo_global("vw_enabled","view options") vw_enabled=!vw_enabled}break
    case "view visible": {undo_globalvec("vw_visible",vw_current,"view "+string(vw_current)+" options") vw_visible[vw_current]=!vw_visible[vw_current]}break


    //paths
    case "pathscroldown" : {pathscrollgo-=192}break
    case "pathscrolup"   : {pathscrollgo+=192}break
    case "path point+"   : {if (current_path!=noone) select_path_point(min(path_get_number(current_path)-1,current_pathpoint+1),0)}break
    case "path point-"   : {if (current_path!=noone) select_path_point(max(0,current_pathpoint-1),0) update_inspector()}break
    case "path smooth"   : {path_set_kind(current_path,!path_get_kind(current_path)) dsmap(pathmap_edited,current_pathname,true) generate_path_model(current_pathname)}break
    case "path closed"   : {path_set_closed(current_path,!path_get_closed(current_path)) dsmap(pathmap_edited,current_pathname,true) generate_path_model(current_pathname)}break
    case "path thin"     : {path_thin=!path_thin if (current_path!=noone) generate_path_model(current_pathname)}break
    case "path point add": {if (current_path!=noone) {
        current_pathpoint+=1
        path_insert_point(current_path,current_pathpoint,path_get_point_x(current_path,current_pathpoint-1),path_get_point_y(current_path,current_pathpoint-1),path_get_point_speed(current_path,current_pathpoint-1))
        generate_path_model(current_pathname)
        select_path_point(current_pathpoint,1)
    }}break
    case "path point del": {if (current_path!=noone) if (path_get_number(current_path)>1) {
        if (ds_list_size(path_sel)==0) {
            path_delete_point(current_path,current_pathpoint)
            current_pathpoint=max(0,current_pathpoint-1)
        } else {
            //we need to sort the selection list because we have to delete the points backwards
            ds_list_sort(path_sel,0)
            minpoint=ds_list_find_value(path_sel,ds_list_size(path_sel)-1)
            i=0 repeat (ds_list_size(path_sel)) {
                point=ds_list_find_value(path_sel,i)
                if (current_pathpoint==point) current_pathpoint=max(0,minpoint-1)
                path_delete_point(current_path,point)
                if (path_get_number(path)==1) break
            i+=1}
        }

        dsmap(pathmap_edited,current_pathname,true)
        generate_path_model(current_pathname)
        select_path_point(current_pathpoint,1)
    }}break
    case "path destroy": {
        if (show_question("Are you sure you want to delete "+qt+current_pathname+qt+"?#This action is irreversible.")) {
            //replace index with empty line
            ds_list_replace(path_index_list,ds_list_find_index(path_index_list,current_pathname),"")
            //delete from tree
            ds_list_delete(path_tree_list,ds_list_find_index(path_tree_list,ds_map_find_value(path_tree_map,current_pathname)))
            //delete associated data
            path_delete(ds_map_find_value(pathmap_path,current_pathname))
            ds_map_delete(pathmap_path,current_pathname)
            d3d_model_destroy(ds_map_find_value(pathmap_model,current_pathname))
            item=ds_map_search(pathmenuitems,current_pathname)
            N_Menu_RemoveItem(pathmenu,item)
            ds_map_delete(pathmenuitems,item)
            ds_map_delete(pathmap_model,current_pathname)
            ds_map_delete(pathmap_edited,current_pathname)
            deselect()
        }
    }break

    case "path clear": {
        if (current_path!=noone) {
            px=path_get_point_x(current_path,0)
            py=path_get_point_y(current_path,0)
            ps=path_get_point_speed(current_path,0)
            path_clear_points(current_path)
            path_add_point(current_path,px,py,ps)
            generate_path_model(current_pathname)
            select_path_point(0,1)
        }
    }break

    case "path reverse": {
        if (current_path!=noone) {
            path_reverse(current_path)
            generate_path_model(current_pathname)
            select_path_point(path_get_number(current_path)-1,1)
        }
    }break

    case "path shift": {
        if (current_path!=noone) {
            str=get_string("Shift path by amount: (x,y)","0,0")
            if (str="" || !string_pos(",",str)) break
            p=string_pos(",",str)
            movex=string_digits(string_copy(str,1,p-1))
            movey=string_digits(string_delete(str,1,p))
            if (movex="" || movey="") break
            path_shift(current_path,real(movex),real(movey))
            generate_path_model(current_pathname)
        }
    }break

    case "path fliph": {
        if (current_path!=noone) {
            path_mirror(current_path)
            generate_path_model(current_pathname)
        }
    }break

    case "path flipv": {
        if (current_path!=noone) {
            path_flip(current_path)
            generate_path_model(current_pathname)
        }
    }break

    case "path rotate": {
        if (current_path!=noone) {
            str=get_string("Rotate path by angle:","0")
            if (str="" || string_digits(str)="") break
            path_rotate(current_path,real(str))
            generate_path_model(current_pathname)
        }
    }break
    case "path scale": {
        if (current_path!=noone) {
            str=get_string("Scale path by amount %: (h,v)","100,100")
            if (str="" || !string_pos(",",str)) break
            p=string_pos(",",str)
            sx=string_digits(string_copy(str,1,p-1))
            sy=string_digits(string_delete(str,1,p))
            if (sx="" || sy="") break
            path_scale(current_path,real(sx)/100,real(sy)/100)
            generate_path_model(current_pathname)
        }
    }break

    case "path snap": {
        if (current_path!=noone) {
            i=0 repeat (path_get_number(current_path)) {
                path_change_point(current_path,i,
                    roundto(path_get_point_x(current_path,i),gridx),
                    roundto(path_get_point_y(current_path,i),gridx),
                    path_get_point_speed(current_path,i)
                )
            i+=1}
            generate_path_model(current_pathname)
        }
    }break
}
