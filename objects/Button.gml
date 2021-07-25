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
alt=""
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
        if (down) button_actions(action)
        down=0
    }
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (action=="toggle grid") {
    up=(!grid && !down)
} else if (action=="toggle crosshair") {
    up=(!crosshair && !down)
} else if (action=="object mode") {
    up=(mode!=0 && !down)
} else if (action=="tile mode") {
    up=(mode!=1 && !down)
} else if (action=="bg mode") {
    up=(mode!=2 && !down)
} else if (action=="view mode") {
    up=(mode!=3 && !down)
} else {
    up=!down
}

buttoncol=global.col_main
draw_button(x,y,w,h,up)

if (text!="") {
    draw_set_halign(1)
    draw_set_valign(1)
    draw_text(x+w/2,y+h/2,text)
    draw_set_halign(0)
    draw_set_valign(0)
}
if (spr!=noone) {
    draw_sprite(sprMenuButtons,spr,x+w/2,y+h/2)
}
#define Other_11
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (text!="") w=string_width(text)+8

image_xscale=w
image_yscale=h
