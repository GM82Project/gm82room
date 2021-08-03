///parsecode(inst,code)
var str,p;

with (argument0) {
    str=string_replace_all(argument1,chr(13),"")
    code=""
    delstop=0
    do {
        p=string_pos("image_",str)
        if (p) {
            code+=string_copy(str,1,p-1)
            str=string_delete(str,1,p+5)
            if (string_pos("xscale",str)==1) {image_xscale=parsereal(str,1)}
            if (string_pos("yscale",str)==1) {image_yscale=parsereal(str,1)}
            if (string_pos("angle",str)==1) {image_angle=parsereal(str,0)}
            if (string_pos("alpha",str)==1) {image_alpha=parsereal(str,1)}
            if (string_pos("blend",str)==1) {image_blend=parsereal(str,$ffffff)}

            if (delstop) str=string_delete(str,1,delstop-1)
            else code+="image_"
        } else code+=str
    } until !p

    if (string_replace_all(string_replace_all(string_replace_all(code,";",""),chr(10),"")," ","")=="") code=""
}
