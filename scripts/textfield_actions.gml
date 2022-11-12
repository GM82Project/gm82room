///apply
var val;

down=0
if (active) {
    active=0
    if (text!="") switch (action) {
        case "grid x": {gridx=median(1,real(text),roomwidth ) text=string(gridx)}break
        case "grid y": {gridy=median(1,real(text),roomheight) text=string(gridy)}break

        case "room width" : {val=clamp(round(real(text)),1,999999) undo_global("roomwidth","room width")  roomwidth=val }break
        case "room height": {val=clamp(round(real(text)),1,999999) undo_global("roomheight","room height") roomheight=val}break
        case "room speed" : {val=clamp(round(real(text)),1,9999  ) undo_global("roomspeed","room speed")  roomspeed=val }break

        case "ref alpha"  : {ref_alpha=real(text)}break
        case "ref angle"  : {ref_angle=real(text)}break
        case "ref xscale" : {if (ref_loaded) ref_w=ref_u*real(text)}break
        case "ref yscale" : {if (ref_loaded) ref_h=ref_v*real(text)}break

        case "inst x"    : {val=round(real(text)) with (instance) if (sel) {x=val do_change_undo("instance x",0)}}break
        case "inst y"    : {val=round(real(text)) with (instance) if (sel) {y=val do_change_undo("instance y",0)}}break
        case "inst xs"   : {val=real(text) with (instance) {if (sel) image_xscale=val if (abs(image_xscale*sprw)<1) image_xscale=1/sprw do_change_undo("instance xscale",0)}}break
        case "inst ys"   : {val=real(text) with (instance) {if (sel) image_yscale=val if (abs(image_yscale*sprw)<1) image_yscale=1/sprw do_change_undo("instance yscale",0)}}break
        case "inst ang"  : {val=real(text) with (instance) if (sel) image_angle=val do_change_undo("instance angle",0)}break
        case "inst col"  : {val=round(real(text)) with (instance) if (sel) image_blend=val if (check_colorpicker_undo(1)) do_change_undo("instance colour",0)}break
        case "inst alpha": {val=real(text)/255    with (instance) if (sel) image_alpha=val do_change_undo("instance alpha",0)}break

        case "tile x"    : {val=round(real(text)) with (tileholder) if (sel) {x=val tile_set_position(tile,x,y) do_change_undo("tile x",0)}}break
        case "tile y"    : {val=round(real(text)) with (tileholder) if (sel) {y=val tile_set_position(tile,x,y) do_change_undo("tile y",0)}}break
        case "tile xs"   : {val=real(text) with (tileholder) if (sel) {image_xscale=val*tilew if (abs(image_xscale)<1) image_xscale=1 tilesx=image_xscale/tilew tile_set_scale(tile,tilesx,tilesy) do_change_undo("tile xscale",0)}}break
        case "tile ys"   : {val=real(text) with (tileholder) if (sel) {image_yscale=val*tileh if (abs(image_yscale)<1) image_yscale=1 tilesy=image_yscale/tileh tile_set_scale(tile,tilesx,tilesy) do_change_undo("tile yscale",0)}}break
        case "tile col"  : {val=round(real(text)) with (tileholder) if (sel) {image_blend=val tile_set_blend(tile,image_blend) if (check_colorpicker_undo(1)) do_change_undo("tile colour",0)}}break
        case "tile alpha": {val=real(text)/255    with (tileholder) if (sel) {image_alpha=val tile_set_alpha(tile,image_alpha) do_change_undo("tile alpha",0)}}break

        case "tile panel grid x": {
            if (tilebgpal!=noone) {
                tex=Controller.bg_background[tilebgpal]
                tilepanel.gx=median(0,real(text),background_get_width(tex))
                if (tilepanel.gx==0) tilepanel.gx=bg_gridx[tilebgpal]
                text=string(tilepanel.gx)
            }
        }break
        case "tile panel grid y": {
            if (tilebgpal!=noone) {
                tex=Controller.bg_background[tilebgpal]
                tilepanel.gy=median(0,real(text),background_get_height(tex))
                if (tilepanel.gy==0) tilepanel.gy=bg_gridy[tilebgpal]
                text=string(tilepanel.gy)
            }
        }break

        case "layer depth": {val=clamp(round(real(text)),-1000000000,1000000000) change_tile_layer(val)}break

        case "bgcol"  : {val=round(real(text)) if (check_colorpicker_undo(0)) undo_global("backgroundcolor","background colour") backgroundcolor=val}break
        case "bg xpos": {val=round(real(text)) undo_globalvec("bg_xoffset",bg_current,"background "+string(bg_current)+" options") bg_xoffset[bg_current]=val}break
        case "bg ypos": {val=round(real(text)) undo_globalvec("bg_yoffset",bg_current,"background "+string(bg_current)+" options") bg_yoffset[bg_current]=val}break
        case "bg hsp" : {val=round(real(text)) undo_globalvec("bg_hspeed",bg_current,"background "+string(bg_current)+" options") bg_hspeed [bg_current]=val}break
        case "bg vsp" : {val=round(real(text)) undo_globalvec("bg_vspeed",bg_current,"background "+string(bg_current)+" options") bg_vspeed [bg_current]=val}break

        case "view x": {val=round(real(text)) undo_globalvec("vw_x",vw_current,"view "+string(vw_current)+" options") vw_x[vw_current]=val}break
        case "view y": {val=round(real(text)) undo_globalvec("vw_y",vw_current,"view "+string(vw_current)+" options") vw_y[vw_current]=val}break
        case "view w": {val=round(real(text)) undo_globalvec("vw_w",vw_current,"view "+string(vw_current)+" options") if (val=0) {val=16 text="16"} vw_w[vw_current]=val}break
        case "view h": {val=round(real(text)) undo_globalvec("vw_h",vw_current,"view "+string(vw_current)+" options") if (val=0) {val=16 text="16"} vw_h[vw_current]=val}break

        case "view xp": {val=round(real(text)) undo_globalvec("vw_xp",vw_current,"view "+string(vw_current)+" options") vw_xp[vw_current]=val}break
        case "view yp": {val=round(real(text)) undo_globalvec("vw_yp",vw_current,"view "+string(vw_current)+" options") vw_yp[vw_current]=val}break
        case "view wp": {val=round(real(text)) undo_globalvec("vw_wp",vw_current,"view "+string(vw_current)+" options") if (val=0) {val=16 text="16"} vw_wp[vw_current]=val}break
        case "view hp": {val=round(real(text)) undo_globalvec("vw_hp",vw_current,"view "+string(vw_current)+" options") if (val=0) {val=16 text="16"} vw_hp[vw_current]=val}break

        case "view hbor"  : {val=round(real(text)) undo_globalvec("vw_hbor",vw_current,"view "+string(vw_current)+" options") vw_hbor[vw_current]=val}break
        case "view vbor"  : {val=round(real(text)) undo_globalvec("vw_vbor",vw_current,"view "+string(vw_current)+" options") vw_vbor[vw_current]=val}break
        case "view hspeed": {val=round(real(text)) undo_globalvec("vw_hspeed",vw_current,"view "+string(vw_current)+" options") vw_hspeed[vw_current]=val}break
        case "view vspeed": {val=round(real(text)) undo_globalvec("vw_vspeed",vw_current,"view "+string(vw_current)+" options") vw_vspeed[vw_current]=val}break
    }

    //these actions accept empty strings
    switch (action) {
        case "room caption": {undo_global("roomcaption","room caption") roomcaption=text}break

        case "inst code box": {
            begin_undo(act_change,"modifying instance creation code",0)
            with (instance) if (sel) {if (code!=other.text) add_undo_instance_props() code=other.text}
            push_undo()
        }break
    }

    event_user(4)
}
