if (mode==3) {
    if (abs(global.mousex-(vw_x[vw_current]+vw_w[vw_current]))<8*zm && abs(global.mousey-(vw_y[vw_current]+vw_h[vw_current]))<8*zm) {
        sizeview=1
        storex=vw_w[vw_current]
        storey=vw_h[vw_current]
    } else if (point_in_rectangle(global.mousex,global.mousey,vw_x[vw_current],vw_y[vw_current],vw_x[vw_current]+vw_w[vw_current],vw_y[vw_current]+vw_h[vw_current])) {
        grabview=1
        storex=vw_x[vw_current]
        storey=vw_y[vw_current]
        offx=global.mousex-vw_x[vw_current]
        offy=global.mousey-vw_y[vw_current]
    } else {
        for (i=0;i<8;i+=1) if (vw_visible[i]) if (point_in_rectangle(global.mousex,global.mousey,vw_x[i],vw_y[i],vw_x[i]+vw_w[i],vw_y[i]+vw_h[i])) {
            vw_current=i
        }
    }
}
