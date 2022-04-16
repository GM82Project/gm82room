var str,i,dx,dy,menu,menu2;

if (editxy) {
    fields[editxyid,1]=string(global.mousex)
    fields[editxyid,2]=string(global.mousey)
    editxy=0
    exit
}

//yeah i know this is the same as the draw script but what can i do

dx=floor((fieldhandx-view_xview)/zoom)
dy=floor((fieldhandy-view_yview)/zoom+24)

menu=-1

for (i=0;i<objfields[obj];i+=1) {
    if (!fields[i,0]) {
        str=objfieldname[obj,i]+" (unset)"
    } else {
        if (objfieldtype[obj,i]=="color") {
            str=objfieldname[obj,i]+": "+fields[i,1]+"      "
        } else if (objfieldtype[obj,i]=="xy") {
            str=objfieldname[obj,i]+": ("+fields[i,1]+", "+fields[i,2]+")"
        } else if (objfieldtype[obj,i]=="string") {
            str=objfieldname[obj,i]+": "+string_replace_all(destringify(fields[i,1]),"#","\#")
        } else {
            str=objfieldname[obj,i]+": "+fields[i,1]
        }
    }
    dw=string_width(str)+32
    if (point_in_rectangle(mouse_wx,mouse_wy,dx+16,dy+4,dx+dw,dy+28)) {
        //edit this field
        menu=i
    }
    dy+=32
}

//clicked outside of all fields, turn off field display
if (menu==-1) {fieldactive=0 exit}

switch (objfieldtype[obj,menu]) {
    case "value": {fields[menu,1]=get_string("Insert new value for "+qt+objfieldname[obj,menu]+qt+":",fields[menu,1]) break}
    case "string": {fields[menu,1]=stringify(get_string("Insert new text for "+qt+objfieldname[obj,menu]+qt+":",destringify(fields[menu,1]))) break}
    case "color": {fields[menu,1]="$"+string_hex(get_color_ext(real_hex(fields[menu,1]),"Select new color for "+qt+objfieldname[obj,menu]+qt+":")) break}
    case "choice": {
        menu2=show_menu(string_replace_all(objfieldargs[obj,menu],",","|"),-1)
        if (menu2==-1) exit
        fields[menu,1]=get_nth_token(objfieldargs[obj,menu],",",menu2)
    break}
    case "xy": {editxy=1 editxyid=menu break}
}

fields[menu,0]=1
