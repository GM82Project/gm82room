///set_instance_field(instance,name,value1,[value2])
var i,l;

for (i=0;i<objfields[argument[0].obj];i+=1) {
    if (objfieldname[argument[0].obj,i]==argument[1]) {
        argument[0].hasfields=1
        argument[0].fields[i,0]=1

        if (objfieldtype[argument[0].obj,i]=="instance") {
            l=string_length(argument[2])
            argument[0].fields[i,1]=string_delete(argument[2],1,l-8)
        } else {
            argument[0].fields[i,1]=argument[2]
        }

        if (argument_count==4) {
            argument[0].fields[i,2]=argument[3]
        }
    }
}
