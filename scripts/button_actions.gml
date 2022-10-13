var sx,sy,cx,cy,nsel,cl,ct,cr,cb,mycx,mycy;

cl=max_int
ct=max_int
cr=-max_int
cb=-max_int

nsel=num_selected()

with (Controller) switch (argument0) {
    //top panel
    case "save and quit": {save_room(0) game_end()}break
    case "object mode"  : {change_mode(0)}break
    case "tile mode"    : {change_mode(1)}break
    case "bg mode"      : {change_mode(2)}break
    case "view mode"    : {change_mode(3)}break
    case "settings mode": {change_mode(4)}break
    case "help"         : {show_info()}break
    case "prefs"        : {show_prefs()}break
    case "undo"         : {pop_undo()}break


    //settings
    case "room code"   : {undo_global("roomcode","room creation code") roomcode=external_code_editor(roomcode) other.alt=roomcode}break
    case "room persist": {undo_global("roompersistent","room options") roompersistent=!roompersistent}break
    case "room clear"  : {undo_global("clearview","room options") clearview=!clearview}break

    case "chunk crop"  : {chunkcrop=!chunkcrop if (!chunkcrop) chunkleft=0 chunktop=0 chunkwidth=roomwidth chunkheight=roomheight update_settingspanel()}break
    case "chunk export": {chunk_export()}break
    case "chunk import": {chunk_import()}break

    case "ref load"    : {load_reference()}break
    case "ref top"     : {ref_top=!ref_top}break
    case "ref move"    : {ref_moving=!ref_moving && ref_loaded if (ref_moving) view[8]=1}break
    case "ref reset"   : {ref_x=0 ref_y=0 ref_w=ref_u ref_h=ref_v ref_angle=0 update_settingspanel()}break


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
    case "inst snap"     : {with (instance) if (sel) {x=roundto(x,gridx) y=roundto(y,gridy) do_change_undo("snapping",0) if (select==id) update_inspector() update_selection_bounds()}}break
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
            x=round(x-((bbox_right+bbox_left+1)/2-mycx))+(sx-mycx)*2
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
            y=round(y-((bbox_bottom+bbox_top+1)/2-mycy))+(sy-mycy)*2
            event_user(1)
            do_change_undo("flipping",0)
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
            x=mycx y=mycy
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
            x=mycx y=mycy
            event_user(1)
            do_change_undo("rotation",0)
            if (select==id) update_inspector()
        }
        update_selection_bounds()
    }break


    //instances
    case "palscroldown" : {palettescrollgo-=200}break
    case "palscrolup"   : {palettescrollgo+=200}break
    case "overlap check": {overlap_check=!overlap_check}break
    case "object search": {search_for_objects(get_string("Object name:",""))}break
    case "cement"       : {cement_instances()}break
    case "cleanup"      : {cleanup_instances()}break
    case "parsecode"    : {parsecode_instances()}break
    case "loadjmap"     : {load_jmap()}break
    case "replaceobj"   : {replace_instances()}break


    //tiles
    case "tile palscroldown" : {tpalscrollgo-=200}break
    case "tile palscrolup"   : {tpalscrollgo+=200}break
    case "tile overlap check": {tile_overlap_check=!tile_overlap_check}break

    //tile inspector
    case "tile snap": {
        with (tileholder) if (sel) {
            x=roundto(x,gridx) y=roundto(y,gridy)
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
            x=round(x-((bbox_right+bbox_left+1)/2-mycx))+(sx-mycx)*2
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
            y=round(y-((bbox_bottom+bbox_top+1)/2-mycy))+(sy-mycy)*2
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

    case "layerscroldown": {layerscrollgo-=200}break
    case "layerscrolup"  : {layerscrollgo+=200}break
    case "layer dupe"    : {dupe_tile_layer()}break
    case "layer delete"  : {del_tile_layer()}break


    //backgrounds
    case "clear bg"  : {undo_global("clearscreen","room options") clearscreen=!clearscreen}break
    case "bgselect"  : {bg_current=other.actionid update_backgroundpanel()}break
    case "bg visible": {undo_globalvec("bg_visible",bg_current,"background "+string(bg_current)+" options") bg_visible[bg_current]=!bg_visible[bg_current]}break
    case "bg fore"   : {undo_globalvec("bg_is_foreground",bg_current,"background "+string(bg_current)+" options") bg_is_foreground[bg_current]=!bg_is_foreground[bg_current]}break
    case "bg tileh"  : {undo_globalvec("bg_tile_h",bg_current,"background "+string(bg_current)+" options") bg_tile_h[bg_current]=!bg_tile_h[bg_current]}break
    case "bg tilev"  : {undo_globalvec("bg_tile_v",bg_current,"background "+string(bg_current)+" options") bg_tile_v[bg_current]=!bg_tile_v[bg_current]}break
    case "bg stretch": {undo_globalvec("bg_stretch",bg_current,"background "+string(bg_current)+" options") bg_stretch[bg_current]=!bg_stretch[bg_current]}break


    //views
    case "vwselect": {vw_current=other.actionid update_viewpanel()}break


    //views
    case "enable views": {undo_global("vw_enabled","view options") vw_enabled=!vw_enabled}break
    case "view visible": {undo_globalvec("vw_visible",vw_current,"view "+string(vw_current)+" options") vw_visible[vw_current]=!vw_visible[vw_current]}break
}
