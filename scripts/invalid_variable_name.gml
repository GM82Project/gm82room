///invalid_variable_name(str)
//returns if this is not a valid variable name
var valchrs,l,i;

if (string_pos(string_char_at(argument0,1),"0123456789")) return 0

valchrs="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_"

l=string_length(argument0)
for (i=1;i<=l;i+=1) {
    if (!string_pos(string_char_at(argument0,i),valchrs)) return 1
}

return 0
