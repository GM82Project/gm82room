var str,i;
str=""

dx=floor((fieldhandx-view_xview)/zoom)
dy=floor((fieldhandy-view_yview)/zoom+24)

draw_set_valign(1)

for (i=0;i<objfields[obj];i+=1) {
    draw_set_color_sel()
    draw_line(dx,dy-16,dx,dy+16)
    draw_line(dx,dy+16,dx+16,dy+16)
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
        col1=$ffffff
        col2=selcol
    } else {
        col1=$ddffff
        col2=0
    }
    draw_rectangle_color(dx+16,dy+4,dx+dw,dy+28,col1,col1,col1,col1,0)
    draw_rectangle_color(dx+16,dy+4,dx+dw,dy+28,col2,col2,col2,col2,1)
    draw_set_color(0)
    draw_text(dx+16+8,dy+16,str)
    draw_set_color($ffffff)

    if (fields[i,0]) {
        if (objfieldtype[obj,i]=="color") {
            str=objfieldname[obj,i]+": "+fields[i,1]+" "
            l=string_width(str)
            col=real_hex(fields[i,1])
            draw_roundrect_color(dx+16+8+l,dy+8,dx+16+8+l+48,dy+24,col,col,0)
            draw_roundrect_color(dx+16+8+l,dy+8,dx+16+8+l+48,dy+24,0,0,1)
        }
        if (objfieldtype[obj,i]=="xy") {
            draw_set_color(selcol)
            if (editxy && editxyid==i) {
                px=floor((global.mousex-view_xview)/zoom)
                py=floor((global.mousey-view_yview)/zoom)
            } else {
                px=floor((real(fields[i,1])-view_xview)/zoom)
                py=floor((real(fields[i,2])-view_yview)/zoom)
            }
            draw_line_width(px-10,py-10,px+10,py+10,3)
            draw_line_width(px-10,py+10,px+10,py-10,3)
            draw_line(dx,dy+16,px,py)
        }
    }
    dy+=32
}

draw_set_valign(0)
