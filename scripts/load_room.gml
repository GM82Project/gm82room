globalvar sprites,backgrounds,objects,sprloaded,bgloaded,objloaded,objspr,objvis,objdepth;

globalvar roomname,roomcode,roomspeed,roompersistent,clearscreen,settings,gridx,gridy;

globalvar bg_visible,bg_is_foreground,bg_source,bg_xoffset,bg_yoffset,bg_tile_h,bg_tile_v,bg_hspeed,bg_vspeed,bg_stretch;
globalvar vw_enabled,vw_visible,vw_x,vw_y,vw_w,vw_h,vw_xp,vw_yp,vw_wp,vw_hp,vw_follow,vw_hspeed,vw_vspeed,vw_hbor,vw_vbor;
globalvar layers;

globalvar extended_instancedata,viewspeedcorrection;

var f,p,i,inst,layer,map,tileid;


draw_loader("Loading project...",0)

//find room
if (parameter_count()) {
    //summoned from gm82
    room_caption="Game Maker 8.2 Room Editor"
    dir=parameter_string(1)
} else {
    //clicked on
    room_caption="OpenGMK IDE Room Editor"
    //dev
    if (environment_get_variable("USERNAME")=="hex") dir="C:\Stuff\github\renex-engine\rooms\rmDemo1"
    else dir=filename_dir(get_open_filename("GM8.2 Room|room.txt","room.txt"))
}
roomname=filename_name(dir)
if (roomname="") {
    //shruggeth
    game_end()
    exit
}


dir+="\"
root=dir+"..\..\"
room_caption+=" - "+roomname
set_application_title(roomname+" - Room Editor")


//load assets
sprites=file_text_read_list(root+"sprites\index.yyd")
sprites_length=ds_list_size(sprites)
sprloaded[sprites_length]=0

backgrounds=file_text_read_list(root+"backgrounds\index.yyd")
backgrounds_length=ds_list_size(backgrounds)
bgloaded[backgrounds_length]=0
load_background_tree(root+"backgrounds\tree.yyd")

objects=file_text_read_list(root+"objects\index.yyd")
objects_length=ds_list_size(objects)
objloaded[objects_length]=0
load_object_tree(root+"objects\tree.yyd")


//load main project file
project=ds_map_create()
ds_map_read_ini(project,dir+"..\..\"+file_find_first(dir+"..\..\*.gm82",0)) file_find_close()

    gm82version=real(ds_map_find_value(project,"gm82_version"))
    if (gm82version==0) viewspeedcorrection=max_uint else viewspeedcorrection=0
    extended_instancedata=(gm82version>1)

ds_map_destroy(project)


//read room settings
settings=ds_map_create()
ds_map_read_ini(settings,dir+"room.txt")

background_color=real(ds_map_find_value(settings,"bg_color"))
clearscreen=real(ds_map_find_value(settings,"clear_screen"))
roomwidth=real(ds_map_find_value(settings,"width"))
roomheight=real(ds_map_find_value(settings,"height"))
roomspeed=real(ds_map_find_value(settings,"roomspeed"))
roompersistent=real(ds_map_find_value(settings,"roompersistent"))
gridx=real(ds_map_find_value(settings,"snap_x"))
gridy=real(ds_map_find_value(settings,"snap_y"))
roomcaption=ds_map_find_value(settings,"caption")
vw_enabled=real(ds_map_find_value(settings,"views_enabled"))

roomcode=string_replace_all(file_text_read_all(dir+"code.gml"),chr(13),"")
if (string_replace_all(string_replace_all(string_replace_all(roomcode,chr(9),""),chr(10),"")," ","")="") roomcode=""

for (i=0;i<8;i+=1) {
    k=string(i)
    bg_visible[i]=real(ds_map_find_value(settings,"bg_visible"+k))
    bg_is_foreground[i]=real(ds_map_find_value(settings,"bg_is_foreground"+k))
    bg_source[i]=ds_map_find_value(settings,"bg_source"+k)
    bg_tex[i]=get_background(bg_source[i])
    bg_xoffset[i]=real(ds_map_find_value(settings,"bg_xoffset"+k))
    bg_yoffset[i]=real(ds_map_find_value(settings,"bg_yoffset"+k))
    bg_tile_h[i]=real(ds_map_find_value(settings,"bg_tile_h"+k))
    bg_tile_v[i]=real(ds_map_find_value(settings,"bg_tile_v"+k))
    bg_hspeed[i]=real(ds_map_find_value(settings,"bg_hspeed"+k))
    bg_vspeed[i]=real(ds_map_find_value(settings,"bg_vspeed"+k))
    bg_stretch[i]=real(ds_map_find_value(settings,"bg_stretch"+k))

    vw_visible[i]=real(ds_map_find_value(settings,"view_visible"+k))
    vw_x[i]=real(ds_map_find_value(settings,"view_xview"+k))
    vw_y[i]=real(ds_map_find_value(settings,"view_yview"+k))
    vw_w[i]=real(ds_map_find_value(settings,"view_wview"+k))
    vw_h[i]=real(ds_map_find_value(settings,"view_hview"+k))
    vw_xp[i]=real(ds_map_find_value(settings,"view_xport"+k))
    vw_yp[i]=real(ds_map_find_value(settings,"view_yport"+k))
    vw_wp[i]=real(ds_map_find_value(settings,"view_wport"+k))
    vw_hp[i]=real(ds_map_find_value(settings,"view_hport"+k))
    vw_follow[i]=ds_map_find_value(settings,"view_fol_target"+k)
    vw_hbor[i]=real(ds_map_find_value(settings,"view_fol_hbord"+k))
    vw_vbor[i]=real(ds_map_find_value(settings,"view_fol_vbord"+k))
    vw_hspeed[i]=real(ds_map_find_value(settings,"view_fol_hspeed"+k))-viewspeedcorrection
    vw_vspeed[i]=real(ds_map_find_value(settings,"view_fol_vspeed"+k))-viewspeedcorrection
}


//load tiles
progress=0.25
time=current_time
layers=file_text_read_list(dir+"layers.txt")
layersize=ds_list_size(layers)
if (layersize) for (i=0;i<layersize;i+=1) {
    layer=real(ds_list_find_value(layers,i))
    ds_list_replace(layers,i,layer)
    f=file_text_open_read(dir+string(layer)+".txt") do {str=file_text_read_string(f) file_text_readln(f)
        o=instance_create(0,0,tileholder)

                                   p=string_pos(",",str)  o.bgname=string_copy(str,1,p-1)
        str=string_delete(str,1,p) p=string_pos(",",str)  o.x=real(string_copy(str,1,p-1))
        str=string_delete(str,1,p) p=string_pos(",",str)  o.y=real(string_copy(str,1,p-1))
        str=string_delete(str,1,p) p=string_pos(",",str)  tileu=real(string_copy(str,1,p-1))
        str=string_delete(str,1,p) p=string_pos(",",str)  tilev=real(string_copy(str,1,p-1))
        str=string_delete(str,1,p) p=string_pos(",",str)  o.image_xscale=real(string_copy(str,1,p-1))
        str=string_delete(str,1,p) p=string_pos(",",str)  o.image_yscale=real(string_copy(str,1,p-1))

        o.tile=tile_add(get_background(o.bgname),tileu,tilev,o.image_xscale,o.image_yscale,o.x,o.y,layer)
        o.depth=layer-0.01
        o.tlayer=layer

        //add tiles to unique tile hashmap
        map=bg_tilemap[micro_optimization_bgid]
        tileid=string(tileu)+","+string(tilev)+","+string(o.image_xscale)+","+string(o.image_yscale)
        if (!ds_map_exists(map,tileid)) {
            //add this tile
            list=ds_list_create()
            ds_list_add(list,tileu)
            ds_list_add(list,tilev)
            ds_list_add(list,o.image_xscale)
            ds_list_add(list,o.image_yscale)
            ds_map_add(map,tileid,list)
        }

        if (extended_instancedata) {
            str=string_delete(str,1,p) p=string_pos(",",str)  //skip "locked" flag
            str=string_delete(str,1,p) p=string_pos(",",str)  tilesx=real(string_copy(str,1,p-1))
            str=string_delete(str,1,p) p=string_pos(",",str)  tilesy=real(string_copy(str,1,p-1))
            str=string_delete(str,1,p) p=string_pos(",",str)  tileblend=real(str)

            o.image_xscale*=tilesx
            o.image_yscale*=tilesy
            tile_set_scale(o.tile,tilesx,tilesy)
            tile_set_alpha(o.tile,(tileblend>>24)/$ff)
            tile_set_blend(o.tile,tileblend&$ffffff)
        }

        if (current_time>time) {
            time=current_time
            progress=(progress*9+0.25+0.5*i/layersize)/10
            draw_loader("Loading tiles...",progress)
        }
    } until (file_text_eof(f)) file_text_close(f)
}


//load instances
time=current_time
f=file_text_open_read(dir+"instances.txt") do {str=file_text_read_string(f) file_text_readln(f)
    if (str!="") {
        o=instance_create(0,0,instance)

                                   p=string_pos(",",str)  o.objname=string_copy(str,1,p-1)
        str=string_delete(str,1,p) p=string_pos(",",str)  o.x=real(string_copy(str,1,p-1))
        str=string_delete(str,1,p) p=string_pos(",",str)  o.y=real(string_copy(str,1,p-1))
        str=string_delete(str,1,p) p=string_pos(",",str)  o.code=string_copy(str,1,p-1)

        if (o.code!="") parsecode(o,file_text_read_all(dir+o.code+".gml"))
        o.obj=get_object(o.objname)

        o.depth=objdepth[o.obj]
        o.sprite_index=objspr[o.obj]

        o.sprw=sprite_get_width(o.sprite_index)
        o.sprh=sprite_get_height(o.sprite_index)
        o.sprox=sprite_get_xoffset(o.sprite_index)
        o.sproy=sprite_get_yoffset(o.sprite_index)

        if (extended_instancedata) {
            str=string_delete(str,1,p) p=string_pos(",",str)  //skip "locked" flag
            str=string_delete(str,1,p) p=string_pos(",",str)  o.image_xscale=real(string_copy(str,1,p-1))
            str=string_delete(str,1,p) p=string_pos(",",str)  o.image_yscale=real(string_copy(str,1,p-1))
            str=string_delete(str,1,p) p=string_pos(",",str)  o.image_blend=real(string_copy(str,1,p-1))
            str=string_delete(str,1,p) p=string_pos(",",str)  o.image_angle=real(str)

            o.image_alpha=(o.image_blend>>24)/$ff
            o.image_blend=o.image_blend&$ffffff
        }

        if (current_time>time) {
            time=current_time
            progress=(progress*9+1)/10
            draw_loader("Loading instances...",progress)
        }
    }
} until (file_text_eof(f)) file_text_close(f)
