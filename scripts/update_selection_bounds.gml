var l,t,r,b,i,point,dx,dy;

if (mode==0 || mode==1) {
    if (selection) {
        l=max_int
        t=max_int
        r=-max_int
        b=-max_int
        if (mode==0) {
            with (instance) if (sel) {l=min(l,bbox_left) t=min(t,bbox_top) r=max(r,bbox_right+1) b=max(b,bbox_bottom+1)}
        }
        if (mode==1) {
            with (tileholder) if (sel) {l=min(l,bbox_left) t=min(t,bbox_top) r=max(r,bbox_right+1) b=max(b,bbox_bottom+1)}
        }
        selleft=l
        seltop=t
        selwidth=r-l
        selheight=b-t
    }
}

if (mode==5) {
    if (selection) {
        l=max_int
        t=max_int
        r=-max_int
        b=-max_int

        i=0 repeat (ds_list_size(path_sel)) {
            point=ds_list_find_value(path_sel,i)
            dx=path_get_point_x(current_path,point)
            dy=path_get_point_y(current_path,point)
            l=min(l,dx)
            t=min(t,dy)
            r=max(r,dx)
            b=max(b,dy)
        i+=1}

        selleft=l
        seltop=t
        selwidth=r-l
        selheight=b-t
    }
}
