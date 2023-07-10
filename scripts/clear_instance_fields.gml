///clear_instance_fields(instance)
var i;

argument[0].hasfields=0

for (i=0;i<objfields[argument[0].obj];i+=1) {
    argument[0].fields[i,0]=0
}
