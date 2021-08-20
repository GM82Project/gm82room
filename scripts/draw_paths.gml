for (i=0;i<pathnum;i+=1) {
    path=paths[i,0]
    if (paths[i,2]) {
        //smooth path
        l=path_get_length(path)
        for (p=0;p<l;p+=4) {
            if (p>0) {
                opx=px
                opy=py
            }
            px=path_get_x(path,p/l)
            py=path_get_y(path,p/l)
            if (p>0) {
                draw_set_color(0)
                draw_circle(px,py,1.5,0)
                draw_line_width(opx,opy,px,py,3)
                draw_line(opx,opy,px,py)
                draw_set_color($ffff)
                draw_circle(px,py,0.5,0)
                draw_line_width(opx,opy,px,py,1)
                draw_line(opx,opy,px,py)
            }
        }
    } else {
        //straight lines
        l=path_get_number(path)
        for (p=0;p<l;p+=1) {
            if (p>0) {
                opx=px
                opy=py
            }
            px=path_get_point_x(path,p)
            py=path_get_point_y(path,p)
            if (p>0) {
                draw_set_color(0)
                draw_line_width(opx,opy,px,py,3)
                draw_line(opx,opy,px,py)
                draw_set_color($ffff)
                draw_line_width(opx,opy,px,py,1)
                draw_line(opx,opy,px,py)
            }
        }
    }

    //draw points
    for (p=0;p<l;p+=1) {
        px=path_get_point_x(path,p)
        py=path_get_point_y(path,p)

        if (p>0) {
            draw_set_color(0)
            draw_circle(px,py,4,0)
            draw_set_color($ff0000)
            draw_circle(px,py,3,0)
        } else {
            draw_set_color(0)
            draw_rectangle(px-4,py-4,px+4,py+4,0)
            draw_set_color($8000)
            draw_rectangle(px-3,py-3,px+3,py+3,0)
        }
    }
    draw_set_color($ffffff)
}
