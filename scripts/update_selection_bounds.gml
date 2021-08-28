var l,t,r,b;

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
