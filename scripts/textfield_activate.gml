//activate textfield
with (TextField) textfield_actions()
active=1
oldtext=text
if (text!="") selected=1
if (type==0 || type=4) {
    keyboard_string=text
}
if (type==1) {
    val=get_color_ext(real(text),alt)
    if (val!=-1) text=string(val)
    textfield_actions()
}
if (type==2 || type==3) {
    active=0
}
if (action=="tile panel grid x" || action=="tile panel grid y") {
    if (bg_gridsx[tilebgpal]!=0 || bg_gridsy[tilebgpal]!=0) {
        active=0
        alt="You can't change the grid in spaced tilesets"
        alarm[0]=room_speed*2
    }
}
if (action=="palette name") {
    N_Menu_ShowPopupMenu(window_handle(),objmenu,window_get_x()+mouse_wx,window_get_y()+mouse_wy,0)
    Controller.menutype="object"
}
if (action=="bg name") {
    N_Menu_ShowPopupMenu(window_handle(),bgmenu,window_get_x()+mouse_wx,window_get_y()+mouse_wy,0)
    Controller.menutype="background"
}
if (action=="view follow") {
    N_Menu_ShowPopupMenu(window_handle(),objmenu,window_get_x()+mouse_wx,window_get_y()+mouse_wy,0)
    Controller.menutype="object"
}
