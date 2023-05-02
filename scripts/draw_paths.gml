if (mode==5 || view[7]) for (i=0;i<pathnum;i+=1) {
    if ((paths[i,0]==current_path && mode==5) || view[7]) {
        d3d_model_draw(paths[i,3],0,0,0,-1)
    }
}

if (mode==5 && current_path!=noone) {
    dx=path_get_point_x(current_path,current_pathpoint)-0.5
    dy=path_get_point_y(current_path,current_pathpoint)-0.5
    if (current_pathpoint>0) {
        draw_circle_color(dx,dy,4,0,0,0)
        draw_circle_color(dx,dy,3,selcol,selcol,0)
    } else {
        draw_rectangle_color(dx-4,dy-4,dx+4,dy+4,1,1,1,1,0)
        draw_rectangle_color(dx-3,dy-3,dx+3,dy+3,selcol,selcol,selcol,selcol,0)
    }
}
