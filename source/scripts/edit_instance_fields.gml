///edit_instance_fields(delete)
var str,i,dx,dy,menu,menu2,left,right,deac,get,fieldparent;

//yeah i know this is the same as the draw script but what can i do

dx=floor((fieldhandx-view_xview)/zoom)
dy=floor((fieldhandy-view_yview)/zoom+24)
odx=dx
ody=dy-16

menu=-1

if (objdesc[obj]!="") {
    //object has a description field

    str=objdesc[obj]

    str=string_replace_all(str,lf,crlf)

    h=string_height_ext(str,-1,width*0.75)+8

    dy+=h+8
}

for (i=0;i<objfields[obj];i+=1) {
    fieldparent=objfielddepends[obj,i]
    parentdrawy[i]=dy

    dx=odx+objfieldindent[obj,i]*10
    if (fieldparent!=noone) {
        do {
            if (!fields[fieldparent,0]) break
            fieldparent=objfielddepends[obj,fieldparent]
        } until (fieldparent==noone)
        if (fieldparent!=noone) if (!fields[fieldparent,0]) continue
    }

    if (!fields[i,0]) {
        str=objfieldname[obj,i]+objfielddef[obj,i]
    } else {
        if (objfieldtype[obj,i]=="color" || objfieldtype[obj,i]=="colour") {
            str=objfieldname[obj,i]+": "+fields[i,1]+"      "
        } else if (objfieldtype[obj,i]=="xy") {
            str=objfieldname[obj,i]+": ("+fields[i,1]+", "+fields[i,2]+")"
        } else if (objfieldtype[obj,i]=="string") {
            str=objfieldname[obj,i]+": "+string_replace_all(destringify(fields[i,1]),"#","\#")
        } else if (objfieldtype[obj,i]=="bool" || objfieldtype[obj,i]=="boolean" || objfieldtype[obj,i]=="true" || objfieldtype[obj,i]=="false") {
            str=objfieldname[obj,i]
        } else if (objfieldtype[obj,i]=="instance") {
            deac=0
            if (ds_map_exists(uidmap,fields[i,1])) {
                get=ds_map_get(uidmap,fields[i,1])
                if (!instance_exists(get)) {deac=1 instance_activate_object(get)}
                str=objfieldname[obj,i]+": "+fields[i,1]+" ("+(get).objname+")"
                if (deac) instance_deactivate_object(get)
            } else str=objfieldname[obj,i]+": "+fields[i,1]+" (missing)"
        } else {
            str=objfieldname[obj,i]+": "+fields[i,1]
        }
    }
    dw=string_width(str)+48
    if (point_in_rectangle(mouse_wx,mouse_wy,dx+16,dy+4,dx+dw,dy+28)) {
        //edit this field
        menu=i
        menux=dx+16
        menuy=dy+4
        menuw=dx+dw
        menuh=dy+28
    }
    dy+=32
}

//creation code
if (menu==-1) repeat (1) {
    if (code="") {
        str=""
        h=24
        w=string_width("Creation code")+24+8
    } else {
        str=code
        h=string_height(str)+8+24
        w=max(string_width(str),string_width("Creation code:")+24)+8
    }

    if (point_in_rectangle(mouse_wx,mouse_wy,dx+16,dy+4,dx+w+16,dy+h+4)) {
        begin_undo(act_change,"modifying instance creation code",0)
        if (argument0) {
            str=""
        } else {
            str=external_code_editor(code)
        }
        if (code!=str) add_undo_instance_props()
        code=str
        update_inspector()
        push_undo()
        exit
    }
}

//clicked outside of all fields, turn off field display
if (menu==-1) {fieldactive=0 exit}

begin_undo(act_change,"edit instance fields",0)
add_undo_instance_props()
push_undo()

if (argument0) {
    fields[menu,1]=""
    fields[menu,2]=""
    fields[menu,0]=0
    exit
}

hasfields=1

switch (objfieldtype[obj,menu]) {
    case "sprite": {show_field_resource_menu(sprmenu,menu) break}
    case "sound": {show_field_resource_menu(soundmenu,menu) break}
    case "background": {show_field_resource_menu(bgmenu,menu) break}
    case "path": {show_field_resource_menu(pathmenu,menu) break}
    case "script": {show_field_resource_menu(scriptmenu,menu) break}
    case "font": {show_field_resource_menu(fontmenu,menu) break}
    case "timeline": {show_field_resource_menu(timelinemenu,menu) break}
    case "object": {show_field_resource_menu(objmenu,menu) break}
    case "room": {show_field_resource_menu(roommenu,menu) break}
    case "datafile": {show_field_resource_menu(datafilemenu,menu) break}
    case "constant": {show_field_resource_menu(constmenu,menu) break}

    case "true": {
        if (fields[menu,0]) {
            if (fields[menu,1]=="true") fields[menu,1]="false"
            else fields[menu,1]="true"
        } else fields[menu,1]="false"
        fields[menu,0]=1
    } break
    case "bool": case "boolean": case "false": {
        if (fields[menu,0]) {
            if (fields[menu,1]=="true") fields[menu,1]="false"
            else fields[menu,1]="true"
        } else fields[menu,1]="true"
        fields[menu,0]=1
    } break

    case "value": {
        fields[menu,1]=get_string("Insert new value for "+qt+objfieldname[obj,menu]+qt+":",fields[menu,1])
        fields[menu,0]=1
    } break

    case "string": {
        fields[menu,1]=stringify(get_string("Insert new text for "+qt+objfieldname[obj,menu]+qt+":",destringify(fields[menu,1])))
        fields[menu,0]=1
    } break

    case "color": case "colour": {
        fields[menu,1]="$"+string_hex(get_color_ext(real_hex(fields[menu,1]),"Select new "+objfieldtype[obj,menu]+" for "+qt+objfieldname[obj,menu]+qt+":",id,"field",menu))
        fields[menu,0]=1
    } break

    case "enum": {
        str=token_escape_commas(objfieldargs[obj,menu])
        menu2=show_menu(string_replace_all(str,lf,"|"),-1)
        if (menu2==-1) exit
        fields[menu,1]=get_nth_token(str,lf,menu2)
        fields[menu,0]=1
    break}

    case "number": {
        fields[menu,1]=string_number(get_string("Insert new number for "+qt+objfieldname[obj,menu]+qt+":",fields[menu,1]))
        fields[menu,0]=fields[menu,1]!=""
    } break
    case "number_range": {
        string_token_start(objfieldargs[obj,menu],",")
        __left=string_token_next()
        __right=string_token_next()
        getstring=string_number(get_string("Insert new number for "+qt+objfieldname[obj,menu]+qt+"#(between "+__left+" and "+__right+"):",fields[menu,1]))
        if (getstring!="") {
            fields[menu,1]=string_better_lim(median(real(__left),real(__right),real(getstring)))
            fields[menu,0]=1
        }
    } break

    case "xy": {editxy=1 editfid=menu break}
    case "instance": {editinst=1 editfid=menu break}
    case "angle": {editangle=1 editfid=menu break}
    case "radius": {editrad=1 editfid=menu break}
}
