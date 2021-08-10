var f,str,tab,resname,path,curindent;

globalvar bgmenu,tilebgmenu,bgmenuitems;

tab=chr(9)

bgmenuitems=ds_map_create()
bgmenu=N_Menu_CreatePopupMenu()
bgmenuicons=ds_map_create()
tilebgmenu=N_Menu_CreatePopupMenu()
N_Menu_AddMenu(tilebgmenu,bgmenu,"Backgrounds")
N_Menu_AddSeparator(tilebgmenu)

fn=root+"cache\#gm82room_background.bmp" export_include_file_location("background.bmp",fn) background_menuicon=N_Menu_LoadBitmap(fn)

ds_map_add(bgmenuitems,N_Menu_AddItem(bgmenu,"(no background)",""),"<undefined>")

path[0]=bgmenu
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
                icon=background_menuicon
                fn=root+"cache\backgrounds\"+resname+".bmp"
                if (file_exists(fn)) {icon=N_Menu_LoadBitmap(fn) ds_map_add(bgmenuicons,resname,icon)}
                N_Menu_ItemSetBitmap(path[curindent],item,icon)
                ds_map_add(bgmenuitems,item,resname)
            }
        }
    } until (file_text_eof(f)) file_text_close(f)
}
