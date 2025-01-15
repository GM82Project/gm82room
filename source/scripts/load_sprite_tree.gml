var f,str,resname,path,curindent;

sprmenuitems=ds_map_create()
sprmenu=N_Menu_CreatePopupMenu()

ds_map_add(sprmenuitems,N_Menu_AddItem(sprmenu,"(no sprite)",""),undefined)

path[0]=sprmenu
curindent=0

if (has_sprites) {f=file_text_open_read_safe(argument0) if (f) {do {
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
            icon=sprite_menuicon
            if (icon_mode && thumbcount<max_thumbs) {
                fn=root+"cache\sprites\"+resname+".bmp"
                if (file_exists(fn)) icon=loadthumb(fn)
            }
            N_Menu_ItemSetBitmap(path[curindent],item,icon)
            ds_map_add(sprmenuitems,item,resname)
        }
    }
} until (file_text_eof(f)) file_text_close(f)}}
