var f,f2,i,l,layer,dir,savecode,str,crc;

dir=self.dir

//save tiles
f=file_text_open_write(dir+"layers.txt")
l=ds_list_size(layers) for (i=0;i<l;i+=1) {
    layer=real(ds_list_find_value(layers,i))
    file_text_write_string(f,string(layer)+chr(10))
    f2=file_text_open_write(dir+string(layer)+".txt")
    with (tileholder) if (depth==layer/* && scalex==1 && scaley==1 && blend==$ffffffff*/) {
        str=bgname+","+string(x)+","+string(y)+","
        +string(tile_get_left(tile))+","
        +string(tile_get_top(tile))+","
        +string(tile_get_width(tile))+","
        +string(tile_get_height(tile))+",0"
        file_text_write_string(f2,str+chr(10))
    }
    file_text_close(f2)
}
file_text_close(f)

//save instances
f=file_text_open_write(dir+"instances.txt")
with (instance) {
    savecode=gensavecode(code)
    str=objname+","+string(x)+","+string(y)+","
    if (savecode!="") {
        crc=string_upper(string_hex(crc32(savecode)))
        str+=string_repeat("0",8-string_length(crc))+crc
        f2=file_text_open_write(dir+crc+".gml")
        file_text_write_string(f2,savecode)
        file_text_close(f2)
    }
    str+=",0"
    file_text_write_string(f,str+chr(10))
}
file_text_close(f)

//save settings
f=file_text_open_write(dir+"room.txt")
str="caption="+string(ds_map_find_value(settings,"caption"))+chr(10)
+"width="+string(ds_map_find_value(settings,"width"))+chr(10)
+"height="+string(ds_map_find_value(settings,"height"))+chr(10)
+"snap_x="+string(ds_map_find_value(settings,"snap_x"))+chr(10)
+"snap_y="+string(ds_map_find_value(settings,"snap_y"))+chr(10)
+"isometric="+string(ds_map_find_value(settings,"isometric"))+chr(10)
+"roomspeed="+string(ds_map_find_value(settings,"roomspeed"))+chr(10)
+"roompersistent="+string(ds_map_find_value(settings,"roompersistent"))+chr(10)
+"bg_color="+string(ds_map_find_value(settings,"bg_color"))+chr(10)
+"clear_screen="+string(ds_map_find_value(settings,"clear_screen"))+chr(10)
+"clear_view="+string(ds_map_find_value(settings,"clear_view"))+chr(10)
+chr(10)
for (i=0;i<8;i+=1) {
    str+="bg_visible"+string(i)+"="+string(ds_map_find_value(settings,"bg_visible"+string(i)))+chr(10)
    +"bg_is_foreground"+string(i)+"="+string(ds_map_find_value(settings,"bg_is_foreground"+string(i)))+chr(10)
    +"bg_source"+string(i)+"="+string(ds_map_find_value(settings,"bg_source"+string(i)))+chr(10)
    +"bg_xoffset"+string(i)+"="+string(ds_map_find_value(settings,"bg_xoffset"+string(i)))+chr(10)
    +"bg_yoffset"+string(i)+"="+string(ds_map_find_value(settings,"bg_yoffset"+string(i)))+chr(10)
    +"bg_tile_h"+string(i)+"="+string(ds_map_find_value(settings,"bg_tile_h"+string(i)))+chr(10)
    +"bg_tile_v"+string(i)+"="+string(ds_map_find_value(settings,"bg_tile_v"+string(i)))+chr(10)
    +"bg_hspeed"+string(i)+"="+string(ds_map_find_value(settings,"bg_hspeed"+string(i)))+chr(10)
    +"bg_vspeed"+string(i)+"="+string(ds_map_find_value(settings,"bg_vspeed"+string(i)))+chr(10)
}
str+=chr(10)
+"views_enabled"+string(ds_map_find_value(settings,"views_enabled"))+chr(10)
for (i=0;i<8;i+=1) {
    str+="view_visible"+string(i)+"="+string(ds_map_find_value(settings,"view_visible"+string(i)))+chr(10)
    +"view_xview"+string(i)+"="+string(ds_map_find_value(settings,"view_xview"+string(i)))+chr(10)
    +"view_yview"+string(i)+"="+string(ds_map_find_value(settings,"view_yview"+string(i)))+chr(10)
    +"view_wview"+string(i)+"="+string(ds_map_find_value(settings,"view_wview"+string(i)))+chr(10)
    +"view_hview"+string(i)+"="+string(ds_map_find_value(settings,"view_hview"+string(i)))+chr(10)
    +"view_xport"+string(i)+"="+string(ds_map_find_value(settings,"view_xport"+string(i)))+chr(10)
    +"view_yport"+string(i)+"="+string(ds_map_find_value(settings,"view_yport"+string(i)))+chr(10)
    +"view_wport"+string(i)+"="+string(ds_map_find_value(settings,"view_wport"+string(i)))+chr(10)
    +"view_hport"+string(i)+"="+string(ds_map_find_value(settings,"view_hport"+string(i)))+chr(10)
    +"view_fol_hbord"+string(i)+"="+string(ds_map_find_value(settings,"view_fol_hbord"+string(i)))+chr(10)
    +"view_fol_vbord"+string(i)+"="+string(ds_map_find_value(settings,"view_fol_vbord"+string(i)))+chr(10)
    +"view_fol_hspeed"+string(i)+"="+string(ds_map_find_value(settings,"view_fol_hspeed"+string(i)))+chr(10)
    +"view_fol_vspeed"+string(i)+"="+string(ds_map_find_value(settings,"view_fol_vspeed"+string(i)))+chr(10)
    +"view_fol_target"+string(i)+"="+string(ds_map_find_value(settings,"view_fol_target"+string(i)))+chr(10)
}

str+="remember="+string(ds_map_find_value(settings,"remember"))+chr(10)
+"editor_width="+string(ds_map_find_value(settings,"editor_width"))+chr(10)
+"editor_height="+string(ds_map_find_value(settings,"editor_height"))+chr(10)
+"show_grid="+string(ds_map_find_value(settings,"show_grid"))+chr(10)
+"show_objects="+string(ds_map_find_value(settings,"show_objects"))+chr(10)
+"show_tiles="+string(ds_map_find_value(settings,"show_tiles"))+chr(10)
+"show_backgrounds="+string(ds_map_find_value(settings,"show_backgrounds"))+chr(10)
+"show_foregrounds="+string(ds_map_find_value(settings,"show_foregrounds"))+chr(10)
+"show_views="+string(ds_map_find_value(settings,"show_views"))+chr(10)
+"delete_underlying_objects="+string(ds_map_find_value(settings,"delete_underlying_objects"))+chr(10)
+"delete_underlying_tiles="+string(ds_map_find_value(settings,"delete_underlying_tiles"))+chr(10)
+"tab="+string(ds_map_find_value(settings,"tab"))+chr(10)
+"editor_x="+string(ds_map_find_value(settings,"editor_x"))+chr(10)
+"editor_y="+string(ds_map_find_value(settings,"editor_y"))+chr(10)
file_text_write_string(f,str)
file_text_close(f)
