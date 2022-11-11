///get_color_ext(default,caption,instance,type,index)
var color,ocolor;

color=argument0
ocolor=color

if (colorpickertype==1 || argument2==noone) {
    color=get_color(ocolor)
    if (color==-1) return ocolor
    return color
}

with (instance_create(0,0,colorpicker)) {
    self.color=color
    oldcolor=color

    title=argument1
    target_instance=argument2
    type=argument3
    index=argument4

    hue=color_get_hue(color)
    sat=color_get_saturation(color)
    val=color_get_value(color)

    red=color_get_red(color)
    green=color_get_green(color)
    blue=color_get_blue(color)
}

return color
