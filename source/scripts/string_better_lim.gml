///string_better_lim(real)
//real: value to convert to string
//returns: string of value with 13 decimal digits.

var __s;

if (is_string(argument0)) return argument0

__s=string_format(argument0,0,13)+";"
repeat (13) __s=string_replace(__s,"0;",";")
return string_replace(string_replace(__s,".;",""),";","")
