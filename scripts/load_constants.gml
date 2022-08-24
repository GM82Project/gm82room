var f,str,resname,p;

constmenuitems=ds_map_create()
constmenu=N_Menu_CreatePopupMenu()

ds_map_add(constmenuitems,N_Menu_AddItem(constmenu,"(no constant)",""),undefined)

f=file_text_open_read_safe(argument0) if (f) {do {
    str=file_text_read_string(f)
    file_text_readln(f)
    if (str!="") {
        p=string_pos("=",str)
        resname=string_copy(str,1,p-1)+" ("+string_delete(str,1,p)+")"

        item=N_Menu_AddItem(constmenu,resname,"")
        N_Menu_ItemSetBitmap(constmenu,item,constant_menuicon)
        ds_map_add(constmenuitems,item,resname)
    }
} until (file_text_eof(f)) file_text_close(f)}
