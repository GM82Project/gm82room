var i,dir,f,code,p,name,desc,spr,sprfn;

pluginmenuitems=ds_map_create()
pluginmenu=N_Menu_CreatePopupMenu()

dir=program_directory+"\room_plugins\"

directory_create(dir)

i=0

for (f=file_find_first(dir+"*.gml",0);f!="";f=file_find_next()) {
    code=file_text_read_all(dir+f,lf)
    p=string_pos(lf,code)
    name=string_copy(code,1,p)
    code=string_delete(code,1,p)
    p=string_pos(lf,code)
    desc=string_copy(code,1,p)
    code=string_delete(code,1,p)

    if (name!="" and desc!="" and code!="") {
        plugindesc[i]=string_delete(desc,1,2)
        plugincode[i]=code_compile(code)

        item=N_Menu_AddItem(pluginmenu,string_delete(name,1,2),"")

        sprfn=dir+filename_change_ext(f,".png")
        if (file_exists(sprfn)) {
            spr=sprite_add(sprfn,1,0,0,0,0)
            N_Menu_ItemSetBitmap(pluginmenu,item,create_menu_bitmap(spr,0,filename_name(f)))
            sprite_delete(spr)
        } else N_Menu_ItemSetBitmap(pluginmenu,item,create_menu_bitmap(sprMenuButtons,56,"b56"))

        ds_map_add(pluginmenuitems,item,i)
        i+=1
    }
}file_find_close()

if (i==0) noplugins=1
