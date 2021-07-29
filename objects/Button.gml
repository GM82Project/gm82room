#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
down=0
w=32
h=32
text=""
spr=noone
focus=0
dynamic=0
alt=""
anchor=0
type=0
tagmode=-1
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
focus=position_meeting(mouse_wx,mouse_wy,id)

if (down!=0) {
    if (!focus) down=-1
    else down=abs(down)
    if (!mouse_check_button(mb_left)) {
        if (down && (Controller.select || !dynamic)) button_actions(action)
        down=0
    }
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///draw
if (tagmode==mode || tagmode==-1) {
    if (type==0) switch (action) {
        case "toggle grid":      {up=(!grid && !down)          }break
        case "toggle crosshair": {up=(!crosshair && !down)     }break
        case "interp":           {up=(!interpolation && !down) }break
        case "object mode":      {up=(mode!=0 && !down)        }break
        case "tile mode":        {up=(mode!=1 && !down)        }break
        case "bg mode":          {up=(mode!=2 && !down)        }break
        case "view mode":        {up=(mode!=3 && !down)        }break
        case "settings mode":    {up=(mode!=4 && !down)        }break
        case "view objects":     {up=(!view[0] && !down)       }break
        case "view tiles":       {up=(!view[1] && !down)       }break
        case "view bgs":         {up=(!view[2] && !down)       }break
        case "view fgs":         {up=(!view[3] && !down)       }break
        case "view views":       {up=(!view[4] && !down)       }break
        case "view invis":       {up=(!view[5] && !down)       }break
        case "view nospr":       {up=(!view[6] && !down)       }break
        default:                 {up=!down                     }
    }

    checked=0
    if (type==1) {
        if (action=="overlap check") checked=overlap_check
        if (action=="room persist") checked=roompersistent
        up=!down
    }

    if (dynamic && !Controller.select) up=0

    buttoncol=global.col_main
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
#define Other_11
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///startup
if (type==1) {
    w=24
    h=24
}

image_xscale=w
image_yscale=h
#define Other_12
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///click
down=(tagmode==mode || tagmode==-1)
