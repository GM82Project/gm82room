var yes;

if (mode==3) {
    draw_button_ext(0,96,160,40,1,global.col_main)
    draw_button_ext(0,200,160,348,1,global.col_main)
    draw_set_color(global.col_text)
    draw_text(12,236,"Room")
    draw_text(12,328,"Window")
    draw_text(12,420,"Following")
    draw_set_color($ffffff)

    draw_button_ext(width-160,0,160,216,1,global.col_main)
    draw_set_color(global.col_text)
    draw_text(width-160+12,8,"Window")
    draw_set_color($ffffff)
    draw_button_ext(width-160+4,32,160-8,160-8,0,0)

    yes=0
    if (vw_enabled) {
        //first we calculate the total view bounding box
        l=max_uint
        t=max_uint
        r=0
        b=0
        for (i=0;i<8;i+=1) if (vw_visible[i]) {
            yes=1
            l=min(l,vw_xp[i])
            t=min(t,vw_yp[i])
            r=max(r,vw_xp[i]+vw_wp[i])
            b=max(b,vw_yp[i]+vw_hp[i])
        }
        w=r-l
        h=b-t
    } else {
        w=roomwidth
        h=roomheight
        yes=1
    }

    //viewport preview box
    draw_set_halign(1)
    draw_set_valign(1)
    if (yes) {
        if (w>h) {dh=h*144/w dw=144}
        else {dw=w*144/h dh=144}
        dx=width-80-dw/2
        dy=32+76-dh/2
        rect(dx,dy,dw,dh,$808080,1)
        if (vw_enabled) {
            //draw each view
            for (i=0;i<8;i+=1) if (vw_visible[i]) {
                draw_set_color(pick(vw_current==i,$ffffff,$ff8000))
                x1=dx+(vw_xp[i]-l)/w*dw
                y1=dy+(vw_yp[i]-t)/h*dh
                x2=dx+(vw_xp[i]+vw_wp[i]-l)/w*dw
                y2=dy+(vw_yp[i]+vw_hp[i]-t)/h*dh
                draw_rectangle(x1,y1,x2,y2,0)
                draw_set_color(0)
                draw_rectangle(x1,y1,x2,y2,1)
                draw_text(mean(x1,x2),mean(y1,y2),i)
                draw_set_color($ffffff)
            }
        } else {
            draw_text(width-80,32+76,"Whole Room")
        }
    } else {
        draw_text(width-80,32+76,"No views are#visible.##Game will#not display#correctly.")
    }
    draw_set_halign(0)
    draw_set_valign(0)
    if (yes) {
        draw_set_color(global.col_text)
        draw_text(width-160+12,188,string(w)+" x "+string(h))
        draw_set_color($ffffff)
    }
}
