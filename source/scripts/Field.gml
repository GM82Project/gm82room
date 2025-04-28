///Field(field,index)
var val,type;

type="<undefined>"
val=0

for (i=0;i<objfields[obj];i+=1) {
    if (objfieldname[obj,i]==string(argument[0])) {
        type=objfieldtype[obj,i]
        if (!fields[i,0]) {
            //return default
            if (type=="string") return "<undefined>"
            if (type=="true") return true
            return 0
        }
        if (argument_count==2)
            val=fields[i,1+argument[1]]
        else
            val=fields[i,1]
        break
    }
}

if (type=="bool" || type=="boolean" || type=="true" || type=="false") return val=="true"

if (type="value" or type=="enum") {
    return execute_string("return "+parse_constants_in_code(val))
}

if (type=="color" || type=="colour" || type=="string") return execute_string("return "+val)
if (type=="number" || type=="number_range" || type=="radius" || type=="angle" || type=="xy")
    return real(val)

return val
