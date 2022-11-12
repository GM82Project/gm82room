//activate textfield
with (TextField) textfield_actions()
active=1
oldtext=text
if (text!="") selected=1
if (type==0 || type=4) {
    keyboard_string=text
}
if (type==1) {
    textfield_actions()
    val=get_color_ext(real(text),alt,id,"textfield",noone)
    if (val!=-1) text=string(val)
    textfield_actions()
}
if (type==2 || type==3) {
    active=0
}
if (action=="tile panel grid x" || action=="tile panel grid y") {
    if (tilebgpal==noone) {
        active=0
    } else if (bg_gridsx[tilebgpal]!=0 || bg_gridsy[tilebgpal]!=0) {
        active=0
        alt="You can't change the grid in spaced tilesets"
        alarm[0]=room_speed*2
    }
}
if (action=="palette name") {
    call_nmenu("object",objmenu)
}
if (action=="bg name") {
    call_nmenu("background",bgmenu)
}
if (action=="view follow") {
    call_nmenu("object",objmenu)
}
