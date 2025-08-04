///FieldDefined(field)
var i,type,find;

find=string(argument[0])

for (i=0;i<objfields[obj];i+=1) {
    if (objfieldname[obj,i]==find) {
        if (fields[i,0]) return 1
    }
}

return 0
