var f,str,tab,resname,path,curindent;

globalvar objmenu,objmenuitems;

tab=chr(9)

objmenuitems=ds_map_create()
objmenu=N_Menu_CreatePopupMenu()
folder_menuicon=N_Menu_LoadBitmap("folder.bmp")
object_menuicon=N_Menu_LoadBitmap("object.bmp")

path[0]=objmenu
curindent=0

a=argument0

if (file_exists(argument0)) {
    f=file_text_open_read(argument0) do {
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
                N_Menu_ItemSetBitmap(path[curindent],item,object_menuicon)
                ds_map_add(objmenuitems,item,resname)
            }
        }
    } until (file_text_eof(f)) file_text_close(f)
}
