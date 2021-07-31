///apply
var val;

down=0
if (active) {
    active=0
    if (action=="grid x") {
        if (text!="")
            gridx=median(1,real(text),roomwidth)
        text=string(gridx)
    }
    if (action=="grid y") {
        if (text!="")
            gridy=median(1,real(text),roomheight)
        text=string(gridy)
    }
    if (action=="inst x") {
        if (text!="") {
            val=round(real(text))
            with (instance) if (sel) x=val
        }
    }
    if (action=="inst y") {
        if (text!="") {
            val=round(real(text))
            with (instance) if (sel) y=val
        }
    }
    if (action=="inst xs") {
        if (text!="") {
            val=real(text)
            with (instance) if (sel) image_xscale=val
        }
    }
    if (action=="inst ys") {
        if (text!="") {
            val=real(text)
            with (instance) if (sel) image_yscale=val
        }
    }
    if (action=="inst ang") {
        if (text!="") {
            val=real(text)
            with (instance) if (sel) image_angle=val
        }
    }
    if (action=="inst col") {
        if (text!="") {
            val=round(real(text))
            with (instance) if (sel) image_blend=val
        }
    }
    if (action=="inst alpha") {
        if (text!="") {
            val=real(text)/255
            with (instance) if (sel) image_alpha=val
        }
    }

    if (action=="bgcol") {
        if (text!="") {
            val=round(real(text))
            background_color=val
        }
    }
    if (action=="bg xpos") {
        if (text!="") {
            val=round(real(text))
            bg_xoffset[bg_current]=val
        }
    }
    if (action=="bg ypos") {
        if (text!="") {
            val=round(real(text))
            bg_yoffset[bg_current]=val
        }
    }
    if (action=="bg hsp") {
        if (text!="") {
            val=round(real(text))
            bg_hspeed[bg_current]=val
        }
    }
    if (action=="bg vsp") {
        if (text!="") {
            val=round(real(text))
            bg_vspeed[bg_current]=val
        }
    }
    event_user(4)
}
