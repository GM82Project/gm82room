///string_wrap(string,width)
var in,w,out,i,p,fail;

in=argument0
w=argument1
out=""
i=1
repeat (string_length(in)) {
    out+=string_char_at(in,i)
    if (string_width(out)>=w) {
        p=string_length(out)
        fail=true
        repeat (10) {
            p-=1
            if (p==0) break
            if (string_char_at(out,p)==" ") {
                out=string_insert(lf,string_delete(out,p,1),p)
                fail=false
                break
            }
        }
        if (fail) out=string_insert(lf,out,string_length(out))
    }
    i+=1
}

return out
