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
dynamic=-1
alt=""
anchor=0
type=0
tagmode=-1
downcount=0
gray=0
ilist=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (ilist) if (!Instancepanel.open) exit

if (down!=0) {
    //click button
    if (!focus) down=-1
    else down=abs(down)
    downcount+=1
    if (downcount>room_speed/3) button_held(action)
    if (!mouse_check_button(mb_left)) {
        if (down && !gray) button_actions(action)
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
#define Other_13
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///right click
button_rightactions(action)
