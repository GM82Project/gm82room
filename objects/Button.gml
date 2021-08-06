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
downcount=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
focus=position_meeting(mouse_wx,mouse_wy,id)

if (down!=0) {
    //click button
    if (!focus) down=-1
    else down=abs(down)
    downcount+=1
    if (downcount>room_speed/3) button_held(action)
    if (!mouse_check_button(mb_left)) {
        if (down && (Controller.select || !dynamic)) button_actions(action)
        down=0
    }
} else downcount=0
#define Other_12
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///click
down=(tagmode==mode || tagmode==-1)
