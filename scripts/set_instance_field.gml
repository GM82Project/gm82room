///set_instance_field(instance,name,value1,[value2])
show_message("set "+argument[1]+" to "+argument[2])
var i;
for (i=0;i<objfields[argument[0].obj];i+=1) {
    if (objfieldname[argument[0].obj,i]==argument[1]) {
        argument[0].fields[i,0]=1
        argument[0].fields[i,1]=argument[2]
        if (argument_count==4) {
            argument[0].fields[i,2]=argument[3]
        }
    }
}
