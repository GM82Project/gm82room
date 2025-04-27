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
dtext=""
alt=""
basealt=""

k=20
cursor=""

spr=noone
focus=0
active=0
k=0
dynamic=-1
maxlen=256
displen=256
minval=0
maxval=0
type=0
anchor=0
tagmode=-1
ilist=0
gray=0
multiline=0

selected=0
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
alt=""
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
focus=instance_position(mouse_wx,mouse_wy,id)

if (focus && (tagmode==mode || tagmode==-1)) current_cursor=cr_beam

if (down!=0 && focus && !active && !(gray)) {
    textfield_activate()
}

if (active) {
    if (keyboard_check_pressed(vk_left) || keyboard_check_pressed(vk_right)) selected=0
    if (keyboard_check(vk_control)) {
        if (keyboard_check_pressed(ord("C"))) {
            clipboard_set_text(text)
        }
        if (keyboard_check_pressed(ord("V"))) {
            keyboard_string=clipboard_get_text()
            selected=0
        }
    }
    otext=text
    if (type=4) {
        text=string_copy(keyboard_string,1,maxlen)
    } else {
        if (type=0) {
            if (keyboard_string=="-" && keyboard_lastkey==vk_backspace) {
                keyboard_string=""
            }
            text=string_number(keyboard_string)
        }
        neg=!!string_pos("-",text)
        if (maxval>0) text=string(min(maxval,real(text)))
        if (minval<maxval) text=string(max(minval,real(text)))
        text=string_copy(text,1,maxlen)
        if (text=="0" && neg) text="-0"
    }
    if (selected) {
        if (keyboard_lastkey==vk_backspace || keyboard_lastkey==vk_delete || (keyboard_lastkey==vk_return && type!=0)) {
            text=""
            selected=0
        } else if (keyboard_string!=otext) {
            selected=0
            text=keyboard_lastchar
        }
    }

    k+=1
    if (k mod 40-20) cursor="_"
    else cursor=" "
    if (keyboard_check_pressed(vk_enter)) {
        if (multiline) {
            text+=lf
        } else {
            textfield_actions()
        }
    }
    keyboard_string=text
    event_user(4)
} else {k=20 cursor=""}
#define Other_14
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///preprocess text
var l;

if (type==4 || type==0) {
    l=string_length(text)
    if (multiline) {
        dtext=string_wrap(string_replace_all(text+cursor,lf,crlf),w-16,1)
        h=max(32,string_height(dtext)+12)
        image_yscale=h
    } else {
        dtext=text
        if (l>=displen) {
            if (type==4 || active) dtext=string_copy(dtext,l-displen+1+active,displen-active)
            else dtext=string_copy(dtext,1,displen)
            if (basealt!="") alt=basealt+" ("+string_replace_all(text,"#","\#")+")"
            else alt=string_replace_all(text,"#","\#")
        } else alt=basealt
    }
    dtext=string_replace_all(dtext,"#","\#")
} else dtext=text

oldtext=text
