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
active=0
k=0
dynamic=0
maxlen=256
minval=0
maxval=0
type=0
anchor=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
focus=position_meeting(mouse_wx,mouse_wy,id)

if (down!=0 && focus && !active && (Controller.select || !dynamic)) {
    active=1
    if (type=0) {
        keyboard_string=text
    }
    if (type=1) {
        text=string(get_color(real(text)))
        textfield_actions()
    }
    if (type=2) {
        active=0
    }
}

if (active) {
    if (type=0) text=string_digits(keyboard_string)
    if (maxval>0) text=string(min(maxval,real(text)))
    if (minval<maxval) text=string(max(minval,real(text)))
    text=string_copy(text,1,maxlen)
    keyboard_string=text
    k+=1
    if (k mod 40-20) cursor="_"
    else cursor=""
    if (keyboard_check_pressed(vk_enter)) textfield_actions()
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///draw
if (type==1) buttoncol=real(text)
else {
    if (active) buttoncol=$ffffff
    else {
        if (dynamic && !Controller.select) buttoncol=global.col_main
        else buttoncol=$c0c0c0
    }
}

draw_button(x,y,w,h,0)

if (type!=1) {
    draw_set_color(0)
    draw_set_valign(1)
    if (active) draw_text(x+8,y+h/2,text+cursor)
    else draw_text(x+8,y+h/2,text)
    draw_set_valign(0)
    draw_set_color($ffffff)
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
