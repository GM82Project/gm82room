var str,i;
str=""

for (i=0;i<objfields[obj];i+=1) {
    if (fields[i,0]) {
        if (objfieldtype[obj,i]=="xy") {
            str+=objfieldname[obj,i]+"[0]="+fields[i,1]+" "+objfieldname[obj,i]+"[1]="+fields[i,2]+lf
        } else {
            str+=objfieldname[obj,i]+"="+fields[i,1]+lf
        }
    }
}

if (str!="") return "//gm82 fields begin"+lf+str+"//gm82 fields end"+lf

return ""
