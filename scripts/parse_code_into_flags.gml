var output,flag,len,str,val,i;

if (string_replace_all(string_replace_all(string_replace_all(argument0,chr(9),""),lf,"")," ","")="") return ""

output=""
flag="/*gm82room flag*/"
len=string_length(flag)

repeat (string_token_start(argument0,lf)) {
    str=string_token_next()
    val=string_delete(str,1,string_pos("=",str))
    if (string_pos(flag,str)) {
        i=0 repeat (8) {
            if (string_pos("background_hspeed["+string(i)+"]",str)) bg_hspeed[i]=real(val)
            if (string_pos("background_vspeed["+string(i)+"]",str)) bg_vspeed[i]=real(val)
        i+=1}
    } else {
        if (output!="") output+=lf
        output+=str
    }
}

return output
