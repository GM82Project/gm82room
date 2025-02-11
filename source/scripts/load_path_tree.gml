var f,str,resname,path,curindent;

pathmenuitems=ds_map_create()
pathmenu=N_Menu_CreatePopupMenu()

path_tree_map=ds_map_create()
path_tree_list=ds_list_create()

ds_map_add(pathmenuitems,N_Menu_AddItem(pathmenu,"(no path)",""),undefined)
ds_map_add(pathmenuitems,N_Menu_AddItem(pathmenu,"[+] Add new path",""),noone)
N_Menu_AddSeparator(pathmenu)

path[0]=pathmenu
curindent=0

if (has_paths) {f=file_text_open_read_safe(argument0) if (f) {do {
    str=file_text_read_string(f)
    file_text_readln(f)
    if (str!="") {
        tree_entry=str
        ds_list_add(path_tree_list,tree_entry)
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
            icon=path_menuicon
            N_Menu_ItemSetBitmap(path[curindent],item,icon)
            ds_map_add(pathmenuitems,item,resname)
            ds_map_add(path_tree_map,resname,tree_entry)
        }
    }
} until (file_text_eof(f)) file_text_close(f)}}
