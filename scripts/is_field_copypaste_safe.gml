///is_field_copypaste_safe(obj,name)
var i;

for (i=0;i<objfields[argument0.obj];i+=1) {
    if (objfieldname[argument0.obj,i]==argument1) {
        if (objfieldtype[argument0.obj,i]=="instance") {
            return 0
        }
    }
}

return 1
