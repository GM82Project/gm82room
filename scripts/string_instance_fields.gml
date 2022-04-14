var str,i;
str=""

for (i=0;i<objfields[obj];i+=1) {
    if (fields[i,0]=0) str+=objfieldname[obj,i]+" (unset)"+lf
    else {
        if (objfieldtype[obj,i]=="xy") {
            str+=objfieldname[obj,i]+": ("+fields[i,1]+", "+fields[i,2]+")"+lf
        } else if (objfieldtype[obj,i]=="string") {
            str+=objfieldname[obj,i]+": "+destringify(fields[i,1])+lf
        } else {
            str+=objfieldname[obj,i]+": "+fields[i,1]+lf
        }
    }
}

return str
