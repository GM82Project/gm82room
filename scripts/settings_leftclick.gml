if (mode==4) {
    if (chunkcrop) {
        if (abs(global.mousex-(chunkleft+chunkwidth))<8*zm && abs(global.mousey-(chunktop+chunkheight))<8*zm) {
            sizechunk=1
            storex=chunkwidth
            storey=chunkheight
            with (instance) if (sel) {
                start_selection_resize()
            }
            with (tileholder) if (sel) {
                start_selection_resize()
            }
        } else if (point_in_rectangle(global.mousex,global.mousey,chunkleft,chunktop,chunkleft+chunkwidth,chunktop+chunkheight)) {
            grabchunk=1
            storex=chunkleft
            storey=chunktop
            offx=global.mousex-chunkleft
            offy=global.mousey-chunktop
            with (instance) if (sel) {
                start_dragging()
            }
            with (tileholder) if (sel) {
                start_dragging()
            }
        } else {
            deselect()
        }
    } else if (ref_moving) {
        if (ref_loaded) {
            draghandx=ref_x+pivot_pos_x(ref_w,ref_h,ref_angle)
            draghandy=ref_y+pivot_pos_y(ref_w,ref_h,ref_angle)

            rothandx=ref_x+lengthdir_x(ref_w,ref_angle)
            rothandy=ref_y+lengthdir_y(ref_w,ref_angle)
            if (point_distance(rothandx,rothandy,draghandx,draghandy)<20*zm) {
                w=point_distance(ref_x,ref_y,draghandx,draghandy)+20*zm
                rothandx=ref_x+lengthdir_x(w,ref_angle)
                rothandy=ref_y+lengthdir_y(w,ref_angle)
            }

            if (abs(global.mousex-rothandx)<8*zm && abs(global.mousey-rothandy)<8*zm) grabref=1
            else if (abs(global.mousex-draghandx)<8*zm && abs(global.mousey-draghandy)<8*zm) grabref=3
            else if (point_in_quad(global.mousex,global.mousey,ref_x,ref_y,ref_x+lengthdir_x(ref_w,ref_angle),ref_y+lengthdir_y(ref_w,ref_angle),draghandx,draghandy,ref_x+lengthdir_x(ref_h,ref_angle-90),ref_y+lengthdir_y(ref_h,ref_angle-90))) {
                grabref=5
                offx=global.mousex-ref_x
                offy=global.mousey-ref_y
                storex=ref_x+ref_w
                storey=ref_y+ref_h
            }
        }
    } else {
        if (abs(global.mousex-(roomwidth))<8*zm && abs(global.mousey-(roomheight))<8*zm) grabroom=3
        else if (abs(global.mousex-(roomleft))<8*zm && abs(global.mousey-(roomtop))<8*zm) grabroom=1
        else if (abs(global.mousex-(roomwidth))<8*zm && abs(global.mousey-(roomtop))<8*zm) grabroom=2
        else if (abs(global.mousex-(roomleft))<8*zm && abs(global.mousey-(roomheight))<8*zm) grabroom=4
        else if (point_in_rectangle(global.mousex,global.mousey,0,0,roomwidth,roomheight)) {
            grabroom=5
            offx=global.mousex
            offy=global.mousey
            storex=roomwidth
            storey=roomheight
        }
    }
}
