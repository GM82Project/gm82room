var in,out;

in=argument0

out=""

if (image_xscale!=1) out+="image_xscale="+string_format(image_xscale,8,8)+";
"
if (image_yscale!=1) out+="image_yscale="+string_format(image_yscale,8,8)+";
"
if (image_angle!=0) out+="image_angle="+string_format(image_angle,8,8)+";
"
if (image_blend!=$ffffff) out+="image_blend=$"+string_hex(image_blend)+";
"
if (image_alpha!=1) out+="image_alpha="+string(round(median(0,image_alpha*255,255)))+";
"

return string_replace_all(out+in,chr(13),"")
