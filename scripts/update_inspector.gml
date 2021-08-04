if (mode==0) {
    textfield_set("object name",objname)

    textfield_set("inst x",x)
    textfield_set("inst y",y)
    textfield_set("inst xs",image_xscale)
    textfield_set("inst ys",image_yscale)

    textfield_set("inst ang",image_angle)
    textfield_set("inst col",image_blend)
    textfield_set("inst alpha",round(image_alpha*255))
}

if (mode==1) {
    textfield_set("layer depth",ds_list_find_value(layers,ly_current))
}
