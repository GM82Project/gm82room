var f,str,resname,path,curindent;

scriptmenuitems=ds_map_create()
scriptmenu=N_Menu_CreatePopupMenu()

ds_map_add(scriptmenuitems,N_Menu_AddItem(scriptmenu,"(no script)",""),undefined)

path[0]=scriptmenu
curindent=0

if (has_scripts) {f=file_text_open_read_safe(argument0) if (f) {do {
    str=file_text_read_string(f)
    file_text_readln(f)
    if (str!="") {
        curindent=0 while (string_char_at(str,1)==tab) {curindent+=1 str=string_delete(str,1,1)}
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
            icon=script_menuicon
            N_Menu_ItemSetBitmap(path[curindent],item,icon)
            ds_map_add(scriptmenuitems,item,resname)

            //load jtool table script
            if (resname=="gm82room_jtool_table") load_jtool_table(resname)
        }
    }
} until (file_text_eof(f)) file_text_close(f)}}
