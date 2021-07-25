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
maxlen=256
type=0
anchor=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
focus=position_meeting(mouse_wx,mouse_wy,id)

if (down!=0 && focus && !active) {
    active=1
    keyboard_string=text
}

if (active) {
    if (type=0) text=string_digits(keyboard_string)
    text=string_copy(text,1,maxlen)
    keyboard_string=text
    k+=1
    if (k mod 40-20) cursor="_"
    else cursor=""
    if (keyboard_check_pressed(vk_enter)) event_user(2)
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
buttoncol=$c0c0c0
draw_button(x,y,w,h,0)

draw_set_color(0)
draw_set_valign(1)
if (active) draw_text(x+8,y+h/2,text+cursor)
else draw_text(x+8,y+h/2,text)
draw_set_valign(0)
draw_set_color($ffffff)
#define Other_11
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_xscale=w
image_yscale=h
#define Other_12
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
down=0
if (active) {
    active=0
    if (action=="grid x") {
        if (text!="")
            gridx=median(1,real(text),roomwidth)
        text=string(gridx)
    }
    if (action=="grid y") {
        if (text!="")
            gridy=median(1,real(text),roomheight)
        text=string(gridy)
    }
}
