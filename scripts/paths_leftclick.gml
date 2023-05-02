if (mode==5) {
    var maxd,point,p;

    maxd=8*zm point=-1
    pointnum=path_get_number(current_path)

    for (p=0;p<pointnum;p+=1) {
        px=path_get_point_x(current_path,p)
        py=path_get_point_y(current_path,p)
        d=point_distance(global.mousex,global.mousey,px,py)
        if (d<=maxd) {point=p maxd=d}
    }

    if (point>=0) {
        current_pathpoint=point
        drag_point=1
    }
}
