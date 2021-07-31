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
button_draw()
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
