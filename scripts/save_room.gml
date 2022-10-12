///save_room(backup?)
var f,f2,i,l,cl,dir,savecode,str,crc,pr,yes;

dir=self.dir
if (argument0) {
    //backup save
    dir+="autosave\"
    directory_create(dir)
    file_text_close(file_text_open_write(dir+"gm82room lockfile"))
    message("Autosaved")
} else {
    //normal save, make backup first
    dirname=string_copy(dir,1,string_length(dir)-1)

    execute_program_silent('cmd /C robocopy "'+dirname+'" "'+directory_previous(dir)+filename_name(dirname)+"_gm82room_backup"+'" /s /e')

    delete_backups()
}

instance_activate_all()

pr=ds_priority_create()

//save tiles
f=file_text_open_write(dir+"layers.txt")
l=ds_list_size(layers) for (i=0;i<l;i+=1) {
    cl=real(ds_list_find_value(layers,i))
    yes=0 with (tileholder) if (tlayer==cl) {yes+=1 ds_priority_add(pr,id,order)}
    if (yes) {
        file_text_write_string(f,string(cl)+lf)
        f2=file_text_open_write(dir+string(cl)+".txt")
        repeat (yes) with (ds_priority_delete_min(pr)) {
            str=
                bgname+","+
                string(round(x))+","+string(round(y))+","+
                string(tile_get_left(tile))+","+
                string(tile_get_top(tile))+","+
                string(tile_get_width(tile))+","+
                string(tile_get_height(tile))+",0,"+
                string_better(tilesx)+","+
                string_better(tilesy)+","+
                string(round(image_alpha*255)*$1000000+image_blend)
            file_text_write_string(f2,str+lf)
        }
        file_text_close(f2)
    }
}
file_text_close(f)

//save instances
f=file_text_open_write(dir+"instances.txt")
l=0
with (instance) {
    //yeah i know but whatever works, man
    //note from future renex:  xD xD xD
    ds_priority_add(pr,id,-depth+order/orderlast)
    l+=1
}
repeat (l) with (ds_priority_delete_min(pr)) {
    savecode=gensavecode(code)
    str=
        objname+","+
        string(round(x))+","+
        string(round(y))+","+
        uid+",0,"+
        string_better(image_xscale)+","+
        string_better(image_yscale)+","+
        string(round(image_alpha*255)*$1000000+image_blend)+","+
        string_better(image_angle)+","+
        string(savecode!="")
    file_text_write_string(f,str+lf)

    if (savecode!="") {
        f2=file_text_open_write(dir+uid+".gml")
        file_text_write_string(f2,savecode)
        file_text_close(f2)
    }
}
file_text_close(f)

ds_priority_destroy(pr)

//save settings
f=file_text_open_write(dir+"room.txt")
str="caption="+roomcaption+lf
+"width="+string(roomwidth)+lf
+"height="+string(roomheight)+lf
+"snap_x="+string(gridx)+lf
+"snap_y="+string(gridy)+lf
+"isometric="+string(ds_map_find_value(settings,"isometric"))+lf
+"roomspeed="+string(roomspeed)+lf
+"roompersistent="+string(roompersistent)+lf
+"bg_color="+string(backgroundcolor)+lf
+"clear_screen="+string(clearscreen)+lf
+"clear_view="+string(clearview)+lf
+lf
for (i=0;i<8;i+=1) {
    str+="bg_visible"+string(i)+"="+string(bg_visible[i])+lf
    +"bg_is_foreground"+string(i)+"="+string(bg_is_foreground[i])+lf
    +"bg_source"+string(i)+"="+string(bg_source[i])+lf
    +"bg_xoffset"+string(i)+"="+string(bg_xoffset[i])+lf
    +"bg_yoffset"+string(i)+"="+string(bg_yoffset[i])+lf
    +"bg_tile_h"+string(i)+"="+string(bg_tile_h[i])+lf
    +"bg_tile_v"+string(i)+"="+string(bg_tile_v[i])+lf
    +"bg_hspeed"+string(i)+"="+string(bg_hspeed[i])+lf
    +"bg_vspeed"+string(i)+"="+string(bg_vspeed[i])+lf
    +"bg_stretch"+string(i)+"="+string(bg_stretch[i])+lf
}
str+=lf
+"views_enabled="+string(vw_enabled)+lf
for (i=0;i<8;i+=1) {
    str+="view_visible"+string(i)+"="+string(vw_visible[i])+lf
    +"view_xview"+string(i)+"="+string(vw_x[i])+lf
    +"view_yview"+string(i)+"="+string(vw_y[i])+lf
    +"view_wview"+string(i)+"="+string(vw_w[i])+lf
    +"view_hview"+string(i)+"="+string(vw_h[i])+lf
    +"view_xport"+string(i)+"="+string(vw_xp[i])+lf
    +"view_yport"+string(i)+"="+string(vw_yp[i])+lf
    +"view_wport"+string(i)+"="+string(vw_wp[i])+lf
    +"view_hport"+string(i)+"="+string(vw_hp[i])+lf
    +"view_fol_hbord"+string(i)+"="+string(vw_hbor[i])+lf
    +"view_fol_vbord"+string(i)+"="+string(vw_vbor[i])+lf
    +"view_fol_hspeed"+string(i)+"="+string(vw_hspeed[i])+lf
    +"view_fol_vspeed"+string(i)+"="+string(vw_vspeed[i])+lf
    +"view_fol_target"+string(i)+"="+string(vw_follow[i])+lf
}
str+=lf
str+="remember="+string(ds_map_find_value(settings,"remember"))+lf
+"editor_width="+string(ds_map_find_value(settings,"editor_width"))+lf
+"editor_height="+string(ds_map_find_value(settings,"editor_height"))+lf
+"show_grid="+string(ds_map_find_value(settings,"show_grid"))+lf
+"show_objects="+string(ds_map_find_value(settings,"show_objects"))+lf
+"show_tiles="+string(ds_map_find_value(settings,"show_tiles"))+lf
+"show_backgrounds="+string(ds_map_find_value(settings,"show_backgrounds"))+lf
+"show_foregrounds="+string(ds_map_find_value(settings,"show_foregrounds"))+lf
+"show_views="+string(ds_map_find_value(settings,"show_views"))+lf
+"delete_underlying_objects="+string(ds_map_find_value(settings,"delete_underlying_objects"))+lf
+"delete_underlying_tiles="+string(ds_map_find_value(settings,"delete_underlying_tiles"))+lf
+"tab="+string(ds_map_find_value(settings,"tab"))+lf
+"editor_x="+string(ds_map_find_value(settings,"editor_x"))+lf
+"editor_y="+string(ds_map_find_value(settings,"editor_y"))+lf
file_text_write_string(f,str)
file_text_close(f)

f=file_text_open_write(dir+"code.gml")
file_text_write_string(f,roomcode)
file_text_close(f)

change_mode(mode)

if (!argument0) {
    //normal save succeeded; remove backup
    dirname=directory_previous(dir)+filename_name(string_copy(dir,1,string_length(dir)-1))+"_gm82room_backup"

    if (directory_exists(dirname)) {
        execute_program_silent("cmd /C "+qt+"rmdir "+qt+dirname+qt+" /s /q"+qt)
    }
}
