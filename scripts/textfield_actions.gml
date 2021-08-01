///apply
var val;

down=0
if (active) {
    active=0
    if (text!="") {
        if (action=="grid x") {
            gridx=median(1,real(text),roomwidth)
            text=string(gridx)
        }
        if (action=="grid y") {
            gridy=median(1,real(text),roomheight)
            text=string(gridy)
        }

        if (action=="room width") {
            val=clamp(round(real(text)),1,999999)
            roomwidth=val
        }
        if (action=="room height") {
            val=clamp(round(real(text)),1,999999)
            roomheight=val
        }
        if (action=="room speed") {
            val=clamp(round(real(text)),1,9999)
            roomspeed=val
        }

        if (action=="inst x") {
            val=round(real(text))
            with (instance) if (sel) x=val
        }
        if (action=="inst y") {
            val=round(real(text))
            with (instance) if (sel) y=val
        }
        if (action=="inst xs") {
            val=real(text)
            with (instance) if (sel) image_xscale=val
        }
        if (action=="inst ys") {
            val=real(text)
            with (instance) if (sel) image_yscale=val
        }
        if (action=="inst ang") {
            val=real(text)
            with (instance) if (sel) image_angle=val
        }
        if (action=="inst col") {
            val=round(real(text))
            with (instance) if (sel) image_blend=val
        }
        if (action=="inst alpha") {
            val=real(text)/255
            with (instance) if (sel) image_alpha=val
        }

        if (action=="bgcol") {
            val=round(real(text))
            background_color=val
        }
        if (action=="bg xpos") {
            val=round(real(text))
            bg_xoffset[bg_current]=val
        }
        if (action=="bg ypos") {
            val=round(real(text))
            bg_yoffset[bg_current]=val
        }
        if (action=="bg hsp") {
            val=round(real(text))
            bg_hspeed[bg_current]=val
        }
        if (action=="bg vsp") {
            val=round(real(text))
            bg_vspeed[bg_current]=val
        }

        if (action=="view x") {
            val=round(real(text))
            vw_x[vw_current]=val
        }
        if (action=="view y") {
            val=round(real(text))
            vw_y[vw_current]=val
        }
        if (action=="view w") {
            val=round(real(text))
            vw_w[vw_current]=val
        }
        if (action=="view h") {
            val=round(real(text))
            vw_h[vw_current]=val
        }

        if (action=="view xp") {
            val=round(real(text))
            vw_xp[vw_current]=val
        }
        if (action=="view yp") {
            val=round(real(text))
            vw_yp[vw_current]=val
        }
        if (action=="view wp") {
            val=round(real(text))
            vw_wp[vw_current]=val
        }
        if (action=="view hp") {
            val=round(real(text))
            vw_hp[vw_current]=val
        }

        if (action=="view hbor") {
            val=round(real(text))
            vw_hbor[vw_current]=val
        }
        if (action=="view vbor") {
            val=round(real(text))
            vw_vbor[vw_current]=val
        }
        if (action=="view hspeed") {
            val=round(real(text))
            vw_hspeed[vw_current]=val
        }
        if (action=="view vspeed") {
            val=round(real(text))
            vw_vspeed[vw_current]=val
        }
    }
    event_user(4)
}
