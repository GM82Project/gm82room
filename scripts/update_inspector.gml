var seln;
seln=num_selected()

if (object_index!=Controller) {
    if (mode==0) {
        textfield_set("object name",objname)

        textfield_set("inst x",x)
        textfield_set("inst y",y)
        textfield_set("inst xs",image_xscale)
        textfield_set("inst ys",image_yscale)

        textfield_set("inst ang",image_angle)
        textfield_set("inst col",image_blend)
        textfield_set("inst alpha",round(image_alpha*255))
        textfield_set("inst code box",code)
    }

    if (mode==1) {
        textfield_set("current tile bg name",bgname)

        textfield_set("tile x",x)
        textfield_set("tile y",y)
        textfield_set("tile xs",tilesx)
        textfield_set("tile ys",tilesy)

        textfield_set("tile col",image_blend)
        textfield_set("tile alpha",round(image_alpha*255))
    }
}

with (Button) {
    if (mode==0 || mode==1) if (dynamic==mode) gray=!seln
    if (mode==5 && tagmode==5 && dynamic) gray=(current_path==noone)
}
