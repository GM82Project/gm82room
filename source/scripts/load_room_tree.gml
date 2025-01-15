var f,str,resname,path,curindent;

roommenuitems=ds_map_create()
roommenu=N_Menu_CreatePopupMenu()

ds_map_add(roommenuitems,N_Menu_AddItem(roommenu,"(no room)",""),undefined)

path[0]=roommenu
curindent=0

f=file_text_open_read_safe(argument0) if (f) {do {
    str=file_text_read_string(f)
    file_text_readln(f)
    if (str!="") {
        curindent=string_count(tab,str)
        str=string_replace_all(str,tab,"")
        resname=string_delete(str,1,1)
        if (string_char_at(str,1)=="+") {
            //group
            submenu=N_Menu_CreatePopupMenu()
            N_Menu_ItemSetBitmap(path[curindent],N_Menu_AddMenu(path[curindent],submenu,resname),folder_menuicon)
            curindent+=1
            path[curindent]=submenu
        } else {
            //resource
            item=N_Menu_AddItem(path[curindent],resname,"")
            icon=room_menuicon
            N_Menu_ItemSetBitmap(path[curindent],item,icon)
            ds_map_add(roommenuitems,item,resname)
        }
    }
} until (file_text_eof(f)) file_text_close(f)}
