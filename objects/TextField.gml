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

spr=noone
focus=0
active=0
k=0
dynamic=0
maxlen=256
displen=256
minval=0
maxval=0
type=0
anchor=0
tagmode=-1
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
focus=position_meeting(mouse_wx,mouse_wy,id)

if (down!=0 && focus && !active && (Controller.select || !dynamic)) {
    with (TextField) textfield_actions()
    active=1
    if (type==0 || type=4) {
        keyboard_string=text
    }
    if (type==1) {
        text=string(get_color(real(text)))
        textfield_actions()
    }
    if (type==2 || type==3) {
        active=0
    }
}

if (active) {
    if (type=4) text=string_copy(keyboard_string,1,maxlen)
    else {
        if (type=0) text=string_number(keyboard_string)
        if (maxval>0) text=string(min(maxval,real(text)))
        if (minval<maxval) text=string(max(minval,real(text)))
        text=string_copy(text,1,maxlen)
    }
    keyboard_string=text
    k+=1
    if (k mod 40-20) cursor="_"
    else cursor=""
    if (keyboard_check_pressed(vk_enter)) textfield_actions()

    event_user(4)
} else k=20
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///draw
if (tagmode==mode || tagmode==-1) {
    if (type==1) buttoncol=real(text)
    else {
        if (active) buttoncol=$ffffff
        else {
            if (type==0 || type==2) {
                if (dynamic && !Controller.select) buttoncol=global.col_main
                else buttoncol=$c0c0c0
            } else {
                buttoncol=$c0c0c0
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
#define Other_11
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///init
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
#define Other_14
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var l;

if (type==4) {
    l=string_length(text)
    dtext=text
    if (l>=displen) {
        dtext=string_copy(dtext,l-displen+1+active,displen-active)
        alt=string_replace_all(text,"#","\#")
    } else alt=""
    dtext=string_replace_all(dtext,"#","\#")
} else dtext=text
