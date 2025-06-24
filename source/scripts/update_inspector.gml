var seln;
seln=num_selected()

if (object_index==instance) {
    if (mode==0) {
        textfield_set("object name",objname)

        textfield_set("inst x",x)
        textfield_set("inst y",y)
        textfield_set("inst depth",depth)
        textfield_set("inst xs",image_xscale)
        textfield_set("inst ys",image_yscale)

        textfield_set("inst ang",image_angle)
        textfield_set("inst col",image_blend)
        textfield_set("inst alpha",round(image_alpha*255))
        textfield_set("inst code box",code)

        Instancepanel.update_scheduled=true
    }
}
if (object_index==tileholder) {
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

if (mode==5) {
    if (current_path==noone) {
        textfield_set("path name","")
        textfield_set("path precision","")
        textfield_set("path point","")
        textfield_set("path x","")
        textfield_set("path y","")
        textfield_set("path speed","")
    } else {
        textfield_set("path name",current_pathname)
        textfield_set("path precision",path_get_precision(current_path))
        textfield_set("path point",current_pathpoint)
        textfield_set("path x",path_get_point_x(current_path,current_pathpoint))
        textfield_set("path y",path_get_point_y(current_path,current_pathpoint))
        textfield_set("path speed",path_get_point_speed(current_path,current_pathpoint))
    }

}

with (Button) {
    if (mode==0 || mode==1) if (dynamic==mode) gray=!seln
    if (mode==5 && tagmode==5 && dynamic) gray=(current_path==noone)
}
