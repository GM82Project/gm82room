var cx,cy;

with (Controller) switch (argument0) {
    //top panel
    case "save and quit": {save_room() game_end()}break
    case "object mode"  : {change_mode(0)}break
    case "tile mode"    : {change_mode(1)}break
    case "bg mode"      : {change_mode(2)}break
    case "view mode"    : {change_mode(3)}break
    case "settings mode": {change_mode(4)}break
    case "help"         : {show_info()}break


    //settings
    case "room code"   : {roomcode=external_code_editor(roomcode) other.alt=roomcode}break
    case "room persist": {roompersistent=!roompersistent}break


    //visibility
    case "view objects": {view[0]=!view[0] change_mode(mode)}break
    case "view tiles"  : {view[1]=!view[1] change_mode(mode)}break
    case "view bgs"    : {view[2]=!view[2]}break
    case "view fgs"    : {view[3]=!view[3]}break
    case "view views"  : {view[4]=!view[4]}break
    case "view invis"  : {view[5]=!view[5] change_mode(mode)}break
    case "view nospr"  : {view[6]=!view[6] change_mode(mode)}break


    //zoom
    case "reset view"      : {xgo=roomwidth/2 ygo=roomheight/2 zoomgo=1 zoomcenter=1}break
    case "zoom in"         : {zoomgo/=1.2 zoomcenter=1}break
    case "zoom out"        : {zoomgo*=1.2 zoomcenter=1}break
    case "interp"          : {interpolation=!interpolation}break
    case "toggle grid"     : {grid=!grid}break
    case "toggle crosshair": {crosshair=!crosshair}break


    //instance inspector
    case "copy object"   : {clipboard_set_text(select.objname)}break
    case "inst code"     : {edit_creation_code()}break
    case "inst snap"     : {with (instance) if (sel) {x=roundto(x,gridx) y=roundto(y,gridy) update_inspector()}}break
    case "inst flip xs"  : {with (instance) if (sel) {
        cx=round((bbox_right+bbox_left+1)/2) cy=round((bbox_bottom+bbox_top+1)/2)
        image_xscale*=-1 event_user(1)
        x=round(x-((bbox_right+bbox_left+1)/2-cx)) y=round(y-((bbox_bottom+bbox_top+1)/2-cy))
        update_inspector()
    }}break
    case "inst flip ys"  : {with (instance) if (sel) {
        cx=round((bbox_right+bbox_left+1)/2) cy=round((bbox_bottom+bbox_top+1)/2)
        image_yscale*=-1 event_user(1)
        x=round(x-((bbox_right+bbox_left+1)/2-cx)) y=round(y-((bbox_bottom+bbox_top+1)/2-cy))
        update_inspector()
    }}break
    case "inst rot left" : {with (instance) if (sel) {
        cx=round((bbox_right+bbox_left+1)/2) cy=round((bbox_bottom+bbox_top+1)/2)
        image_angle=modwrap(image_angle+90,0,360)
        x=round(x-((bbox_right+bbox_left+1)/2-cx)) y=round(y-((bbox_bottom+bbox_top+1)/2-cy))
        update_inspector()
    }}break
    case "inst rot right": {with (instance) if (sel) {
        cx=round((bbox_right+bbox_left+1)/2) cy=round((bbox_bottom+bbox_top+1)/2)
        image_angle=modwrap(image_angle-90,0,360)
        x=round(x-((bbox_right+bbox_left+1)/2-cx)) y=round(y-((bbox_bottom+bbox_top+1)/2-cy))
        update_inspector()
    }}break


    //instances
    case "palscroldown" : {palettescrollgo-=200}break
    case "palscrolup"   : {palettescrollgo+=200}break
    case "overlap check": {overlap_check=!overlap_check}break


    //tiles
    case "tile palscroldown" : {tpalscrollgo-=200}break
    case "tile palscrolup"   : {tpalscrollgo+=200}break
    case "tile overlap check": {tile_overlap_check=!tile_overlap_check}break

    //tile inspector
    case "layerscroldown": {layerscrollgo-=200}break
    case "layerscrolup"  : {layerscrollgo+=200}break
    case "layer dupe"    : {dupe_tile_layer()}break
    case "layer delete"  : {del_tile_layer()}break


    //backgrounds
    case "clear bg"  : {clearscreen=!clearscreen}break
    case "bgselect"  : {bg_current=other.actionid update_backgroundpanel()}break
    case "bg visible": {bg_visible[bg_current]=!bg_visible[bg_current]}break
    case "bg fore"   : {bg_is_foreground[bg_current]=!bg_is_foreground[bg_current]}break
    case "bg tileh"  : {bg_tile_h[bg_current]=!bg_tile_h[bg_current]}break
    case "bg tilev"  : {bg_tile_v[bg_current]=!bg_tile_v[bg_current]}break
    case "bg stretch": {bg_stretch[bg_current]=!bg_stretch[bg_current]}break


    //views
    case "vwselect": {vw_current=other.actionid update_viewpanel()}break


    //views
    case "enable views": {vw_enabled=!vw_enabled}break
    case "view visible": {vw_visible[vw_current]=!vw_visible[vw_current]}break
}
