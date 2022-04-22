var i,f,reading,str,p;

i=ds_list_find_index(objects,argument0)
if (i==-1) return noone

if (!objloaded[i]) {
    object[i]=ds_map_create() ds_map_read_ini(object[i],root+"objects\"+argument0+".txt")
    objspr[i]=get_sprite(ds_map_find_value(object[i],"sprite"))
    objvis[i]=real(ds_map_find_value(object[i],"visible"))
    objdepth[i]=real(ds_map_find_value(object[i],"depth"))
    objloaded[i]=1
    palettesize+=1

    //load fields
    //i know this looks kind of nasty but we need to consider speed here, as this
    //can potentially read through thousands of lines of gml when loading a room
    objfields[i]=0
    reading=0
    f=file_text_open_read_safe(root+"objects\"+argument0+".gml") if (f) {do {
        str=file_text_read_string(f)
        file_text_readln(f)
        if (!reading) {
            if (string_pos("#define Other_4",str)) {
                //only look for fields in room start events
                reading=1
            }
        } else {
            if (string_pos("#define",str)) {
                //we're done with room start
                reading=0 break
            }
            p=string_pos(": ",str)
            if (p) if (string_pos("//field ",str)==1) {
                objfieldname[i,objfields[i]]=string_copy(str,9,p-9)
                str=string_delete(str,1,p+1)
                if (string_pos("enum",str)==1) {
                    objfieldtype[i,objfields[i]]="enum"
                    objfieldargs[i,objfields[i]]=string_delete(string_copy(str,1,string_length(str)-1),1,7)
                } else {
                    objfieldtype[i,objfields[i]]=str
                }
                objfields[i]+=1
            }
        }
    } until (file_text_eof(f)) file_text_close(f)}
}
objpal=i
return i
