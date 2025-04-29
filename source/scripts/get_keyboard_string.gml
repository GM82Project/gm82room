///get_keyboard_string(in):out
//thanks YellowAfterlife!
var in,kstr,pad;

in=argument0

kstr=keyboard_string

pad=string_count(chr(0),kstr)

if (pad>25) {
    if (pad<50) in=string_delete_end(in,50-pad)
    in+=string_delete(kstr,1,pad)
}

keyboard_string=string_repeat(chr(0),50)

return in
