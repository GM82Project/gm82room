var str,i,fieldparent;
str=""

for (i=0;i<objfields[obj];i+=1) {
    if (fields[i,0]) {
        fieldparent=objfielddepends[obj,i]
        if (fieldparent!=noone) {
            do {
                if (!fields[fieldparent,0]) break
                fieldparent=objfielddepends[obj,fieldparent]
            } until (fieldparent==noone)
            if (fieldparent!=noone) if (!fields[fieldparent,0]) continue
        }

        if (objfieldtype[obj,i]=="instance") {
            if (ds_map_exists(uidmap,fields[i,1])) {
                str+=objfieldname[obj,i]+"="+roomname+"_"+fields[i,1]+lf
            }
        } else if (objfieldtype[obj,i]=="xy") {
            str+=objfieldname[obj,i]+"[0]="+fields[i,1]+" "+objfieldname[obj,i]+"[1]="+fields[i,2]+lf
        } else {
            str+=objfieldname[obj,i]+"="+fields[i,1]+lf
        }
    }
}

if (str!="") return "//gm82 fields begin"+lf+str+"//gm82 fields end"+lf

return ""
