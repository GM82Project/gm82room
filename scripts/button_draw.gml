if (object_index==Button) {
    if (tagmode==mode || tagmode==-1) {
        if (type==0) switch (action) {
            case "toggle grid":      {up=(!grid && !down)               }break
            case "toggle crosshair": {up=(!crosshair && !down)          }break
            case "interp":           {up=(!interpolation && !down)      }break
            case "object mode":      {up=(mode!=0 && !down)             }break
            case "tile mode":        {up=(mode!=1 && !down)             }break
            case "bg mode":          {up=(mode!=2 && !down)             }break
            case "view mode":        {up=(mode!=3 && !down)             }break
            case "settings mode":    {up=(mode!=4 && !down)             }break
            case "view objects":     {up=(!view[0] && !down)            }break
            case "view tiles":       {up=(!view[1] && !down)            }break
            case "view bgs":         {up=(!view[2] && !down)            }break
            case "view fgs":         {up=(!view[3] && !down)            }break
            case "view views":       {up=(!view[4] && !down)            }break
            case "view invis":       {up=(!view[5] && !down)            }break
            case "view nospr":       {up=(!view[6] && !down)            }break
            case "bgselect":         {up=(!down && bg_current!=actionid)}break
            case "vwselect":         {up=(!down && vw_current!=actionid)}break
            case "undo":             {up=(!down && alt!="Undo")         }break
            default:                 {up=!down                          }
        }

        checked=0
        if (type==1) {
            switch (action) {
                case "overlap check": {checked=overlap_check}break
                case "tile overlap check": {checked=tile_overlap_check}break
                case "room persist": {checked=roompersistent}break
                case "room clear": {checked=clearview}break

                case "clear bg": {checked=clearscreen}break
                case "bg visible": {checked=bg_visible[bg_current]}break
                case "bg fore": {checked=bg_is_foreground[bg_current]}break
                case "bg tileh": {checked=bg_tile_h[bg_current]}break
                case "bg tilev": {checked=bg_tile_v[bg_current]}break
                case "bg stretch": {checked=bg_stretch[bg_current]}break

                case "enable views": {checked=vw_enabled}break
                case "view visible": {checked=vw_visible[vw_current]}break

                case "chunk crop": {checked=chunkcrop}break
            }
            up=!down
        }

        if (gray) up=0

        if (extended && !extended_instancedata) up=0

        buttoncol=global.col_main
        if (action=="bgselect") buttoncol=pick(bg_visible[actionid] && bg_source[actionid]!="",buttoncol,$808080)
        if (action=="vwselect") buttoncol=pick(vw_visible[actionid],buttoncol,$808080)
        draw_button(x,y,w,h,up)

        if (text!="") {
            if (type==0) {
                draw_set_halign(1)
                draw_set_valign(1)
                draw_text(x+w/2,y+h/2,text)
                draw_set_halign(0)
                draw_set_valign(0)
            }
            if (type==1) {
                draw_set_valign(1)
                draw_text(x+w+8,y+h/2,text)
                draw_set_valign(0)
            }
        }
        if (spr!=noone) {
            draw_sprite(sprMenuButtons,spr,x+w/2,y+h/2)
        }
        if (checked) {
            draw_sprite(sprMenuButtons,17,x+w/2,y+h/2)
        }
    }
}

if (object_index==TextField) {
    if (tagmode==mode || tagmode==-1) {
        if (extended && !extended_instancedata) buttoncol=global.col_main
        else {
            if (type==1) buttoncol=real(text)
            else {
                if (active) buttoncol=$ffffff
                else {
                    if (type==0 || type==2) {
                        if (gray) buttoncol=global.col_main
                        else buttoncol=$c0c0c0
                    } else {
                        buttoncol=$c0c0c0
                    }
                }
            }
        }

        draw_button(x,y,w,h,0)

        if (type!=1) {
            draw_set_color(0)
            draw_set_valign(1)
            if (active) {
                draw_text(x+8,y+h/2,dtext+cursor)
            } else {
                draw_text(x+8,y+h/2,dtext)
            }
            draw_set_valign(0)
            draw_set_color($ffffff)
        }
    }
}
