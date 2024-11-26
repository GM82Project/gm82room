var f,str,resname,p,alphanum;

constmap=ds_map_create()
consthasfunc=ds_map_create()

constmenuitems=ds_map_create()
constmenu=N_Menu_CreatePopupMenu()

ds_map_add(constmenuitems,N_Menu_AddItem(constmenu,"(no constant)",""),undefined)

alphanum1="abcdefghijklmnopqrstuvwxyz_ABCDEFGHIJKLMNOPQRSTUVWXYZ"
alphanum2=alphanum1+"0123456789"

f=file_text_open_read_safe(argument0) if (f) {do {
    str=file_text_read_string(f)
    file_text_readln(f)
    if (str!="") {
        p=string_pos("=",str)

        cname=string_copy(str,1,p-1)
        cvalue=string_delete(str,1,p)

        ds_map_add(constmap,cname,cvalue)

        //check if constant has a function call in it
        if (match_found(
            match_any(match_whitespace,
            match_some(match_identifier,
            match_any(match_whitespace,
            match_exact("(",
            match_not_any("(",
            match_not_some(match_quotes,
            match_any(match_whitespace,
            cvalue))))))))
        ) {
            ds_map_add(consthasfunc,cname,true)
        }

        resname=cname+" ("+cvalue+")"

        item=N_Menu_AddItem(constmenu,resname,"")
        N_Menu_ItemSetBitmap(constmenu,item,constant_menuicon)
        ds_map_add(constmenuitems,item,cname)
    }
} until (file_text_eof(f)) file_text_close(f)}

constmapsize=ds_map_size(constmap)
