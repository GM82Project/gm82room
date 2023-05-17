var f,f2,fn,str,resname,path,curindent;

objmenuitems=ds_map_create()
objmenu=N_Menu_CreatePopupMenu()

ds_map_add(objmenuitems,N_Menu_AddItem(objmenu,"(no object)",""),undefined)

path[0]=objmenu
curindent=0

a=argument0

if (has_objects) {f=file_text_open_read_safe(argument0) if (f) {do {
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
            icon=object_menuicon
            if (icon_mode && thumbcount<max_thumbs) {
                f2=file_text_open_read_safe(root+"objects\"+resname+".txt")
                if (f2) {
                    sprname=string_delete(file_text_read_string(f2),1,7) //we do a little cheating for speed
                    file_text_close(f2)
                    if (sprname!="") {
                        fn=root+"cache\sprites\"+sprname+".bmp"
                        if (file_exists(fn)) icon=loadthumb(fn)
                    }
                }
            }
            N_Menu_ItemSetBitmap(path[curindent],item,icon)
            ds_map_add(objmenuitems,item,resname)
        }
    }
} until (file_text_eof(f)) file_text_close(f)}}
