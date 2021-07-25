//(str):crc32

//(c) juju adams
//adapted to gm8 by renex
var crc,i,l;

crc=$FFFFFFFF

l=string_length(argument0)

for (i=1;i<=l;i+=1) {
    crc=global.crc32table[(crc^ord(string_char_at(argument0,i)))&$FF]^(crc div 256)
}

return crc^$FFFFFFFF
