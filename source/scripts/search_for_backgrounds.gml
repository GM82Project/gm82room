///search_for_backgrounds(name)
var i,searchterm,searchtermlower,bgname,exactmatch;
var item,icon;
var f,sprname,fn;

searchterm=argument0
if (searchterm=="") exit
searchtermlower=string_lower(searchterm)
ds_list_clear(searchresults)
exactmatch=""

//find matching backgrounds
for(i=0;i<ds_list_size(backgrounds);i+=1) {
    bgname=ds_list_find_value(backgrounds,i)
    if (string_pos(searchtermlower,string_lower(bgname))!=0) {
        ds_list_add(searchresults,bgname)
        if (searchtermlower==string_lower(bgname)) {
            exactmatch=bgname
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
    get_background_tiles(ds_list_find_value(searchresults,0))
    tilebgpal=micro_optimization_bgid
    tilebgname=str
    tilepal=0
    update_newtilepanel(1)
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
            fn=root+"cache\backgrounds\"+bgname+".bmp"
            if (file_exists(fn)) icon=loadthumb(fn)
        }
        N_Menu_ItemSetBitmap(searchmenu,item,icon)
        ds_map_add(searchmenuitems,item,exactmatch)

        N_Menu_AddSeparator(searchmenu)
    }

    for(i=0;i<ds_list_size(searchresults);i+=1) {
        bgname=ds_list_find_value(searchresults,i)
        item=N_Menu_AddItem(searchmenu,bgname,"")
        icon=object_menuicon
        //icon code yoinked from load_object_tree
        if (icon_mode && thumbcount<max_thumbs) {
            fn=root+"cache\backgrounds\"+bgname+".bmp"
            if (file_exists(fn)) icon=loadthumb(fn)
        }
        N_Menu_ItemSetBitmap(searchmenu,item,icon)
        ds_map_add(searchmenuitems,item,ds_list_find_value(searchresults,i))
    }

    call_nmenu("search_bg",searchmenu)
}
