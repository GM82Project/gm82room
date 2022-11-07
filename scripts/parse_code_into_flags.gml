if (string_replace_all(string_replace_all(string_replace_all(argument0,chr(9),""),lf,"")," ","")="") return ""

output=""
flag="/*gm82room flag*/"
len=string_length(flag)

repeat (string_token_start(argument0,lf)) {
    str=string_token_next()
    if (string_pos(flag,str)) {
        //if (string_pos("unused",str)) unused=true
    } else {
        if (output!="") output+=lf
        output+=str
    }
}

return output
