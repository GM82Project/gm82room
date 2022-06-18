//note 22 april 2022
//removed support for format v2
var str,l;

str=parse_fields_into_code()+argument0

if (str="") return str

l=string_length(str)
while (string_char_at(str,l)==lf) l-=1

return string_copy(str,1,l)+lf
