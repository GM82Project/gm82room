//swaps out commas for newlines
var in,out,tok,mode,i,len,c,d;

in=argument0
out=""

mode=0
tok=""

len=string_length(in)
i=1 repeat (len) {
    c=string_char_at(in,i)
    d=string_char_at(in,i+1)
    if (mode==0) {
        if (c=='"') mode=1
        if (c=="'") mode=2
        if (c+d=="/*") mode=3
    } else {
        if (mode==1) {
            if (c=='"') mode=0
        }
        if (mode==2) {
            if (c=="'") mode=0
        }
        if (mode==3) {
            if (c+d=="*/") mode=0
        }
    }
    if (mode==0 or i==len) {
        if (c=="," or i==len) {
            if (i==len) tok+=c
            if (out!="") out+=lf
            out+=string_trim(tok)
            tok=""
            c=""
        }
    }
    tok+=c
i+=1}

return out
