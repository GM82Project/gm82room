var str,i;
str=""

for (i=0;i<objfields[obj];i+=1) {
    if (fields[i,0]=0) str+=objfieldname[obj,i]+" (unset)|"
    else {
        if (objfieldtype[obj,i]=="string") str+=objfieldname[obj,i]+": "+destringify(fields[i,1])+"|"
        else str+=objfieldname[obj,i]+": "+fields[i,1]+"|"
    }
}

menu=show_menu(str,-1)

if (menu==-1) exit

switch (objfieldtype[obj,menu]) {
    case "real": {fields[menu,1]=get_string("Insert new value for "+qt+objfieldname[obj,menu]+qt+":",fields[menu,1]) break}
    case "string": {fields[menu,1]=stringify(get_string("Insert new text for "+qt+objfieldname[obj,menu]+qt+":",destringify(fields[menu,1]))) break}
    case "color": {fields[menu,1]="$"+string_hex(get_color_ext(real_hex(fields[menu,1]),"Select new color for "+qt+objfieldname[obj,menu]+qt+":")) break}
    case "choice": {
        menu2=show_menu(string_replace_all(objfieldargs[obj,menu],",","|"),-1)
        if (menu2==-1) exit
        fields[menu,1]=get_nth_token(objfieldargs[obj,menu],",",menu2)
    break}
    case "xy": {show_message("nyi") break}
}

fields[menu,0]=1
