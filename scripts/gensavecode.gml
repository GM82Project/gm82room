var in,out,fieldstr;

in=argument0

fieldstr=parse_fields_into_code()

if (extended_instancedata) return fieldstr+in

//if you're not using gm82save v2, we can still "cheat" extended instance data by adding creation code

out=""

if (image_xscale!=1) out+="image_xscale="+string_format(image_xscale,8,8)+";"+lf
if (image_yscale!=1) out+="image_yscale="+string_format(image_yscale,8,8)+";"+lf
if (image_angle!=0) out+="image_angle="+string_format(image_angle,8,8)+";"+lf
if (image_blend!=$ffffff) out+="image_blend=$"+string_hex(image_blend)+";"+lf
if (image_alpha!=1) out+="image_alpha="+string(image_alpha)+";"+lf

return fieldstr+out+in
