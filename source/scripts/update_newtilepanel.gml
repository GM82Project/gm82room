///update_newtilepanel(reset)

with (tilepanel) {
    if (tilebgpal!=noone) {
        tex=bg_background[tilebgpal]
        bgw=background_get_width(tex)
        bgh=background_get_height(tex)
        if (bg_istile[tilebgpal]) {
            gx=bg_gridx[tilebgpal]
            gy=bg_gridy[tilebgpal]
            ox=bg_gridox[tilebgpal]
            oy=bg_gridoy[tilebgpal]
            sx=bg_gridsx[tilebgpal]
            sy=bg_gridsy[tilebgpal]
        } else {
            gx=bgw
            gy=bgh
            ox=0
            oy=0
            sx=0
            sy=0
        }
        textfield_set("tile panel grid x",gx)
        textfield_set("tile panel grid y",gy)

        if (argument0) {
            z=1
            zgo=1
            curtilex=ox
            curtiley=oy
            curtilew=gx
            curtileh=gy
        }

        xgo=curtilex+curtilew/2
        ygo=curtiley+curtileh/2
    }
}
