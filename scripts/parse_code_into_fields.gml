var i,str,next,state,p,name,value,value2;

for (i=0;i<objfields[argument0.obj];i+=1) {
    argument0.hasfields=1
    argument0.fields[i,0]=0
    argument0.fields[i,1]=noone
    argument0.fields[i,2]=noone
}

str=argument0.code

if (str!="") {
    o.code=""
    state=0
    string_token_start(str,lf)
    do {
        next=string_token_next()
        if (state=0) {
            //hasn't started
            if (string_pos("//gm82 fields begin",next)) {state=1 continue}
        }
        if (state=1) {
            if (string_pos("//gm82 fields end",next)) {state=2 continue}
            //reading fields
            p=string_pos("[0]",next)
            if (p) {
                //this is an array so it must be coordinate
                name=string_copy(next,1,p-1)
                p=string_pos("=",next)
                str=string_delete(next,1,p)

                p=string_pos(" ",str)
                value=string_copy(str,1,p-1)
                p=string_pos("=",str)
                value2=string_delete(next,1,p)

                set_instance_field(argument0,name,value,value2)
            } else {
                p=string_pos("=",next)
                name=string_copy(next,1,p-1)
                value=string_delete(next,1,p)
                set_instance_field(argument0,name,value)
            }
        }
        if (state=2) {
            //we're done reading fields, re-add normal instance code
            o.code+=next+lf
        }
    } until (next="")
}

if (string_replace_all(string_replace_all(string_replace_all(o.code,";",""),lf,"")," ","")=="") o.code=""
