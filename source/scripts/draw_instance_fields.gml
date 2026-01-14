///draw_instance_fields(preview)
var str,i,dx,dy,h,deac,get,fieldparent,parentdrawy;
str=""

fieldhandx=x+lengthdir_x((sprh-sproy)*image_yscale,image_angle-90)+lengthdir_x(-(sprox)*image_xscale,image_angle)
fieldhandy=y+lengthdir_y((sprh-sproy)*image_yscale,image_angle-90)+lengthdir_y(-(sprox)*image_xscale,image_angle)
if (point_distance(fieldhandx,fieldhandy,draghandx,draghandy)<20*zm) {
    w=point_distance(x,y,fieldhandx,fieldhandy)+20*zm
    a=point_direction(x,y,fieldhandx,fieldhandy)
    fieldhandx=x+lengthdir_x(w,a)
    fieldhandy=y+lengthdir_y(w,a)
}

dx=floor((fieldhandx-view_xview)/zoom)
dy=floor((fieldhandy-view_yview)/zoom+24)
odx=dx
ody=dy-16

if (objdesc[obj]!="" and (fieldactive or not nodescpreview or keyboard_check(ord("C")))) {
    //object has a description field; let's draw it before

    str=objdesc[obj]

    str=string_replace_all(str,lf,crlf)

    w=string_width_ext(str,-1,width*0.75)+8
    h=string_height_ext(str,-1,width*0.75)+8

    if (fieldactive) draw_set_color_sel()
    else draw_set_color(0)
    draw_line(dx,dy-16,dx,dy+h-8)
    draw_line(dx,dy+h-8,dx+16,dy+h-8)

    x1=dx+16
    y1=dy+4

    draw_rectangle_color(x1,y1,x1+w,y1+h,$ddffff,$ddffff,$ddffff,$ddffff,0)
    draw_rectangle_color(x1,y1,x1+w,y1+h,0,0,0,0,1)
    draw_text_ext_color(x1+4,y1+4,str,-1,width*0.75,0,0,0,0,1)

    dy+=h+8
}

//draw_set_valign(1)

for (i=0;i<objfields[obj];i+=1) {
    fieldparent=objfielddepends[obj,i]
    parentdrawy[i]=dy           
    
    dx=odx+objfieldindent[obj,i]*10
    hdy=dy-16
    if (fieldparent!=noone) {
        hdy=parentdrawy[fieldparent]+29
        do {
            if (!fields[fieldparent,0]) break
            fieldparent=objfielddepends[obj,fieldparent]
        } until (fieldparent==noone)
        if (fieldparent!=noone) if (!fields[fieldparent,0]) continue
    } else hdy=ody
    
    if (!fields[i,0]) {
        if (argument0) continue        
        str=objfieldname[obj,i]+objfielddef[obj,i]
        col1=$808080
    } else {
        if (argument0) col1=$808080
        else col1=$ddffff
        if (objfieldtype[obj,i]=="color" || objfieldtype[obj,i]=="colour") {
            str=objfieldname[obj,i]+": "+fields[i,1]+"      "
        } else if (objfieldtype[obj,i]=="xy") {
            str=objfieldname[obj,i]+": ("+fields[i,1]+", "+fields[i,2]+")"
        } else if (objfieldtype[obj,i]=="string") {
            str=objfieldname[obj,i]+": "+destringify(fields[i,1])
        } else if (objfieldtype[obj,i]=="bool" || objfieldtype[obj,i]=="boolean" || objfieldtype[obj,i]=="true" || objfieldtype[obj,i]=="false") {
            str=objfieldname[obj,i]
        } else if (objfieldtype[obj,i]=="instance") {
            deac=0
            if (ds_map_exists(uidmap,fields[i,1])) {
                get=ds_map_get(uidmap,fields[i,1])
                if (!instance_exists(get)) {deac=1 instance_activate_object(get)}
                str=objfieldname[obj,i]+": "+fields[i,1]+" ("+(get).objname+")"
            } else str=objfieldname[obj,i]+": "+fields[i,1]+" (missing)"
        } else if (objfieldtype[obj,i]=="__gm82room_ccode") {
            str=objfieldname[obj,i]+":"+lf+code
        } else {
            str=objfieldname[obj,i]+": "+fields[i,1]
        }
    }
    str=string_replace_all(str,"#","\#")
    dw=string_width(str)+48
    dh=string_height(str)+8
    if (point_in_rectangle(mouse_wx,mouse_wy,dx+16,dy+4,dx+dw,dy+dh)) {
        col1=$ffffff
        col2=selcol
    } else {
        col2=0
    }

    if (fieldactive) draw_set_color_sel()
    else draw_set_color(0)
    draw_line(dx,hdy,dx,dy+16)
    draw_line(dx,dy+16,dx+16,dy+16)

    draw_rectangle_color(dx+16,dy+4,dx+dw,dy+dh,col1,col1,col1,col1,0)
    draw_rectangle_color(dx+16,dy+4,dx+dw,dy+dh,col2,col2,col2,col2,1)
    draw_set_color(0)
    draw_text(dx+16+28,dy+6,str)
    draw_set_color($ffffff)

    switch (objfieldtype[obj,i]) {
        case "value": fr=0 break
        case "string": fr=1 break
        case "color": case "colour": fr=2 break
        case "enum": fr=3 break
        case "xy": fr=4 break
        case "sprite": fr=5 break
        case "sound": fr=6 break
        case "background": fr=7 break
        case "path": fr=8 break
        case "script": fr=9 break
        case "font": fr=10 break
        case "timeline": fr=11 break
        case "object": fr=12 break
        case "room": fr=13 break
        case "datafile": fr=14 break
        case "constant": fr=15 break
        case "instance": fr=16 break
        case "true": fr=18 if (fields[i,0]) if (fields[i,1]=="true") fr=18 else fr=17 break
        case "false": fr=17 if (fields[i,0]) if (fields[i,1]=="true") fr=18 else fr=17 break
        case "bool": case "boolean": fr=22 if (fields[i,0]) if (fields[i,1]=="true") fr=18 else fr=17 break
        case "number": case "number_range": fr=19 break
        case "radius": fr=20 break
        case "__gm82room_ccode": fr=21 break
        case "__gm82room_depth": fr=23 break
    }
    if (objfieldtype[obj,i]=="angle") {
        if (fields[i,0]) ang=real(fields[i,1])
        else ang=0
        texture_set_interpolation(0)
        draw_sprite_outline(sprFieldAngle,0,dx+28,dy+16,0.25,0.25,ang,$ffffff,1)
        texture_set_interpolation(1)
    } else draw_sprite(sprFieldIcons,fr,dx+28,dy+16)

    if (fields[i,0]) {
        if (objfieldtype[obj,i]=="color" || objfieldtype[obj,i]=="colour") {
            str=objfieldname[obj,i]+": "+fields[i,1]+" "
            l=string_width(str)
            col=real_hex(fields[i,1])
            draw_roundrect_color(dx+16+28+l,dy+8,dx+16+28+l+48,dy+24,col,col,0)
            draw_roundrect_color(dx+16+28+l,dy+8,dx+16+28+l+48,dy+24,0,0,1)
        }
        if (objfieldtype[obj,i]=="xy") {
            draw_set_color(selcol)
            px=floor((real(fields[i,1])-view_xview)/zoom)
            py=floor((real(fields[i,2])-view_yview)/zoom)
            draw_line_width(px-10,py-10,px+10,py+10,3)
            draw_line_width(px-10,py+10,px+10,py-10,3)
            draw_line(dx,dy+16,px,py)
        }
        if (objfieldtype[obj,i]=="instance") {
            draw_set_color(selcol)
            if (ds_map_exists(uidmap,fields[i,1])) {
                get=ds_map_get(uidmap,fields[i,1])
                with (get) {
                    draw_rectangle(floor((bbox_left-view_xview-0.5)/zoom),floor((bbox_top-view_yview-0.5)/zoom),floor((bbox_right+0.5-view_xview)/zoom),floor((bbox_bottom+0.5-view_yview)/zoom),1)
                    draw_arrow(dx,dy+16,floor(((bbox_left+bbox_right+1)/2-view_xview)/zoom),floor(((bbox_top+bbox_bottom+1)/2-view_yview)/zoom),10)
                }
                if (deac) instance_deactivate_object(get)
            } else {
                draw_set_color($ff)
                draw_line_width(dx-8,dy+8,dx+8,dy+24,4)
                draw_line_width(dx+8,dy+8,dx-8,dy+24,4)
            }
        }
        if (objfieldtype[obj,i]=="angle") {
            draw_set_color(selcol)

            px=floor((x-view_xview)/zoom)
            py=floor((y-view_yview)/zoom)

            a=real(fields[i,1])

            draw_arrow(px,py,px+lengthdir_x(100,a),py+lengthdir_y(100,a),10)

            if (editangle==2 && editfid==i) {
                if (keyboard_check(vk_alt)) {
                    px=floor((global.mousex-view_xview)/zoom)
                    py=floor((global.mousey-view_yview)/zoom)
                } else {
                    px=floor((roundto(global.mousex,gridx)-view_xview)/zoom)
                    py=floor((roundto(global.mousey,gridy)-view_yview)/zoom)
                }

                draw_line_width(px-10,py-10,px+10,py+10,3)
                draw_line_width(px-10,py+10,px+10,py-10,3)
            }
        }
        if (objfieldtype[obj,i]=="radius") {
            draw_set_color(selcol)

            px=floor((x-view_xview)/zoom)
            py=floor((y-view_yview)/zoom)

            a=real(fields[i,1])/zoom
            draw_set_circle_precision(64)
            draw_circle(px,py,a,1)
            draw_set_circle_precision(8)
        }
    } else if (editinst && editfid==i) {
        draw_set_color(selcol)
        draw_arrow(dx,dy+16,mouse_wx,mouse_wy,10*zm)
    }
    dy+=dh+4
    draw_set_color($ffffff)
}
dx=odx

draw_set_valign(0)
