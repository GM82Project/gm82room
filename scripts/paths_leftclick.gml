if (mode==5) {
    if (current_path!=noone) {
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
            select_path_point(point,0)
            drag_point=1
        } else {
            if (keyboard_check(vk_shift)) {
                selecting=1
                selx=global.mousex
                sely=global.mousey
            } else {
                //add new point
                current_pathpoint+=1
                path_insert_point(current_path,current_pathpoint,0,0,path_get_point_speed(current_path,current_pathpoint-1))
                drag_point=1
            }
        }
    }
}
