var alphanumleft,alphanumright,key,str;

str=argument0

alphanumleft="abcdefghijklmnopqrstuvwxyz_ABCDEFGHIJKLMNOPQRSTUVWXYZ"
alphanumright=alphanumleft+"0123456789"

key=ds_map_find_first(constmap) repeat (constmapsize) {
    p=string_pos(key,str)
    if (p) {
        //if constant is a whole token
        if (!string_pos(string_char_at(str,p-1),alphanumleft))
        and (!string_pos(string_char_at(str,p+string_length(key)),alphanumright)) {
            //check if constant doesn't contain a function call
            if (ds_map_exists(consthasfunc,key)) {                                
                //fail!
                show_message(error+"Constant '"+key+"' present in preview field appears to have a function call in it, and can't be used in a preview field.")
                return undefined
            } else {
                //instantiate constant
                str=string_replace_all(str,key,"("+ds_map_find_value(constmap,key)+")")
            }
        }
    }
key=ds_map_find_next(constmap,key)}

return str
