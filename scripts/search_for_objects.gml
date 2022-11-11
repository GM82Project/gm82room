///search_for_objects(name)
var i,searchterm,searchtermlower,objname, exactmatch;
var item,icon;
var f,sprname,fn;

searchterm=argument0
if (searchterm=="") exit
searchtermlower=string_lower(searchterm)
ds_list_clear(searchresults)
exactmatch=""

//find matching objects
for(i=0;i<ds_list_size(objects);i+=1) {
    objname=ds_list_find_value(objects,i)
    if (string_pos(searchtermlower,string_lower(objname))!=0) {
        ds_list_add(searchresults,objname)
        if (searchtermlower==string_lower(objname)) {
            //Technically this is ambiguous if you have 2 objects in your
            //project which only differ in capitalization. I refuse to care.
            exactmatch=objname
        }
    }
}

//resolve search
if (ds_list_size(searchresults)==0) {
    //no results
    show_message("No results for '" + searchterm + "'.")
}
else if (ds_list_size(searchresults)==1) {
    //single result
    get_object(ds_list_find_value(searchresults,0))
    textfield_set("palette name",ds_list_find_value(objects,objpal))
}
else {
    //multiple results, show menu
    ds_map_clear(searchmenuitems)
    N_Menu_DestroyMenu(window_handle(), searchmenu)
    searchmenu=N_Menu_CreatePopupMenu()

    //start menu with exactly matching object if such exists
    if (exactmatch!="") {
        item=N_Menu_AddItem(searchmenu,exactmatch,"")
        icon=object_menuicon
        //icon code yoinked from load_object_tree
        if (icon_mode && thumbcount<max_thumbs) {
            f=file_text_open_read_safe(root+"objects\"+exactmatch+".txt")
            if (f) {
                sprname=string_delete(file_text_read_string(f),1,7) //we do a little cheating for speed
                file_text_close(f)
                if (sprname!="") {
                    fn=root+"cache\sprites\"+sprname+".bmp"
                    if (file_exists(fn)) icon=loadthumb(fn)
                }
            }
        }
        N_Menu_ItemSetBitmap(searchmenu,item,icon)
        ds_map_add(searchmenuitems,item,exactmatch)

        N_Menu_AddSeparator(searchmenu)
    }

    for(i=0;i<ds_list_size(searchresults);i+=1) {
        objname=ds_list_find_value(searchresults,i)
        item=N_Menu_AddItem(searchmenu,objname,"")
        icon=object_menuicon
        //icon code yoinked from load_object_tree
        if (icon_mode && thumbcount<max_thumbs) {
            f=file_text_open_read_safe(root+"objects\"+objname+".txt")
            if (f) {
                sprname=string_delete(file_text_read_string(f),1,7) //we do a little cheating for speed
                file_text_close(f)
                if (sprname!="") {
                    fn=root+"cache\sprites\"+sprname+".bmp"
                    if (file_exists(fn)) icon=loadthumb(fn)
                }
            }
        }
        N_Menu_ItemSetBitmap(searchmenu,item,icon)
        ds_map_add(searchmenuitems,item,ds_list_find_value(searchresults,i))
    }

    call_nmenu("search",searchmenu)
}
