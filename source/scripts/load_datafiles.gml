var f,str,resname,p;

datafilemenuitems=ds_map_create()
datafilemenu=N_Menu_CreatePopupMenu()

ds_map_add(datafilemenuitems,N_Menu_AddItem(datafilemenu,"(no datafile)",""),undefined)

if (has_datafiles) {f=file_text_open_read_safe(argument0) if (f) {do {
    str=file_text_read_string(f)
    file_text_readln(f)
    if (str!="") {
        resname=str
        item=N_Menu_AddItem(datafilemenu,resname,"")
        N_Menu_ItemSetBitmap(datafilemenu,item,datafile_menuicon)
        ds_map_add(datafilemenuitems,item,resname)
    }
} until (file_text_eof(f)) file_text_close(f)}}
