//activate textfield
with (TextField) textfield_actions()
active=1
oldtext=text
if (text!="") selected=!selected
if (type==0 || type=4) {
    clear_keyboard_string()
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
if (action=="tile panel grid x" || action=="tile panel grid y" || action=="tile panel off x" || action=="tile panel off y" || action=="tile panel sep x" || action=="tile panel sep y") {
    if (tilebgpal==noone) {
        active=0
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
if (action=="path precision") {
    text=string(show_menu("1 - less precise|2|3|4 - normal|5|6|7|8 - most precise",path_precision-1)+1)
    textfield_actions()
    active=0
}
