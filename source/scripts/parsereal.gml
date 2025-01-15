///parsereal(string,default):value

var i,c,mode,out;

i=1
mode=0
out=""

repeat (string_length(argument0)) {
    c=string_lower(string_char_at(argument0,i)) i+=1
    if (mode==0) {
        if (c=="=") mode=1
    } else if (mode==1) {
        if (c=="$") mode=3
        else if (string_pos(c,"0123456789.-")) {
            mode=2
            out+=c
        } else if (c!=" " && c!=chr(13) && c!=lf && c!=chr(9)) break
    } else if (mode==2) {
        if (string_pos(c,"0123456789.-")) {
            out+=c
        } else break
    } else if (mode==3) {
        if (string_pos(c,"0123456789abcdef-")) {
            out+=c
        } else break
    }
}

delstop=0

if (out!="") {
    delstop=i
    if (mode==2) return real(out)
    return real_hex(out)
}

return argument1
