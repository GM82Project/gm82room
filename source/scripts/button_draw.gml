var col;
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
            case "path mode":        {up=(mode!=5 && !down)             }break
            case "view objects":     {up=(!view[0] && !down)            }break
            case "view tiles":       {up=(!view[1] && !down)            }break
            case "view bgs":         {up=(!view[2] && !down)            }break
            case "view fgs":         {up=(!view[3] && !down)            }break
            case "view views":       {up=(!view[4] && !down)            }break
            case "view invis":       {up=(!view[5] && !down)            }break
            case "view nospr":       {up=(!view[6] && !down)            }break
            case "view paths":       {up=(!view[7] && !down)            }break
            case "view ref":         {up=(!view[8] && !down)            }break
            case "view draw":        {up=(!view[9] && !down)            }break
            case "view ignore":      {up=(!view[10] && !down)           }break
            case "ref move":         {up=(!ref_moving && !down)         }break
            case "bgselect":         {up=(!down && bg_current!=actionid)}break
            case "vwselect":         {up=(!down && vw_current!=actionid)}break
            case "undo":             {up=(!down && alt!="Undo (empty)") }break
            case "tile panel grid":  {up=(!down && !tilepickgrid)       }break
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

                case "ref top": {checked=ref_top}break

                case "path smooth": {checked=path_get_kind(current_path)}break
                case "path closed": {checked=path_get_closed(current_path)}break
                case "path thin": {checked=path_thin}break

                case "screen draw": {checked=screen_grid_draw}break
            }
            up=!down
        }

        if (gray) up=0

        col=global.col_main
        if (action=="bgselect") col=pick(bg_visible[actionid] && bg_source[actionid]!="",col,$808080)
        if (action=="vwselect") col=pick(vw_visible[actionid],col,$808080)
        draw_button_ext(x,y,w,h,up,col)

        if (action=="undo") if (total_undo_size>0) draw_healthbar(x+4,y+24,x+27,y+27,min(100,1+(total_undo_size/undospace)*99),0,$ff00,$ff,0,1,0)

        if (text!="") {
            draw_set_color(global.col_text)
            if (type==0) {
                draw_set_halign(1)
                draw_set_valign(1)
                if (spr!=noone) draw_text(x+w/2+4,y+h/2-1,text)
                else draw_text(x+w/2,y+h/2-1,text)
                draw_set_halign(0)
                draw_set_valign(0)
            }
            if (type==1) {
                draw_set_valign(1)
                draw_text(x+w+8,y+h/2-1,text)
                draw_set_valign(0)
            }
            draw_set_color($ffffff)
        }
        if (spr!=noone) {
            if (text!="") draw_sprite(sprMenuButtons,spr,x+floor(w/2-string_width(text)/2+4),y+floor(h/2))
            else draw_sprite(sprMenuButtons,spr,x+floor(w/2),y+floor(h/2))
        }
        if (checked) {
            draw_sprite(sprMenuButtons,17,x+w/2,y+h/2)
        }
    }
}

if (object_index==TextField) {
    if (tagmode==mode || tagmode==-1) {
        if (type==1) {if (gray) col=global.col_main else col=real(text)}
        else {
            if (active) col=merge_color(global.col_high,$ffffff,0.75)
            else {
                if (type==0 || type==2 || action=="inst code box") {
                    if (gray) col=global.col_main
                    else col=merge_color(global.col_high,$ffffff,0.5)
                } else {
                    col=merge_color(global.col_high,$ffffff,0.5)
                }
            }
        }

        draw_button_ext(x,y,w,h,0,col)

        if (type!=1) {
            draw_set_color(0)
            draw_set_valign(0)
            if (active) {
                if (selected) {
                    draw_rectangle_color(x+8,y+5,x+7+string_width(dtext),y+5+string_height(dtext),$ff8000,$ff8000,$ff8000,$ff8000,0)
                    draw_set_color($ffffff)
                    draw_text(x+8,y+5,dtext)
                } else {
                    draw_set_color(merge_color(global.col_low,0,0.5))
                    draw_text(x+8,y+5,dtext)
                }
            } else {
                draw_set_color(merge_color(global.col_low,0,0.5))
                draw_text(x+8,y+5,dtext)
            }
            draw_set_valign(0)
            draw_set_color($ffffff)
        }
    }
}
