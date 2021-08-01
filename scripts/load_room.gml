globalvar sprites,backgrounds,objects,sprloaded,bgloaded,objloaded,objspr,objvis,objdepth,roomname,roomcode,roomspeed,roompersistent,clearscreen,settings,gridx,gridy;
globalvar bg_current,vw_current;
globalvar bg_visible,bg_is_foreground,bg_source,bg_xoffset,bg_yoffset,bg_tile_h,bg_tile_v,bg_hspeed,bg_vspeed,bg_stretch;
globalvar vw_enabled,vw_visible,vw_x,vw_y,vw_w,vw_h,vw_xp,vw_yp,vw_wp,vw_hp,vw_follow,vw_hspeed,vw_vspeed,vw_hbor,vw_vbor;

var f,p,i,inst,layer,viewspeedcorrection;

roomwidth=800
roomheight=608

loadtext="Loading project..."
progress=0
draw_loader()

//find room
if (parameter_count()) {
    room_caption="Game Maker 8.2 Room Editor"
    dir=parameter_string(1)
} else {
    //room_caption="OpenGMK IDE Room Editor"
    //dir=get_open_filename("GM8.2 Room|room.txt","room.txt")
    dir="C:\Stuff\github\renex-engine\rooms\rmDemo3\room.txt"
    dir=filename_dir(dir)
}
roomname=filename_name(dir)
if (roomname="") {
    game_end()
    exit
}

dir+="\"
root=dir+"..\..\"
room_caption+=" - "+roomname
set_application_title(roomname+" - Room Editor")

//load assets
sprites=file_text_read_list(root+"sprites\index.yyd")
backgrounds=file_text_read_list(root+"backgrounds\index.yyd")
objects=file_text_read_list(root+"objects\index.yyd")

load_object_tree(root+"objects\tree.yyd")
load_background_tree(root+"backgrounds\tree.yyd")

sprites_length=ds_list_size(sprites)
backgrounds_length=ds_list_size(backgrounds)
objects_length=ds_list_size(objects)

sprloaded[sprites_length]=0
bgloaded[backgrounds_length]=0
objloaded[objects_length]=0

//load main project file
project=ds_map_create()
ds_map_read_ini(settings,dir+"..\..\"+file_find_first(dir+"..\..\*.gm82",0))
file_find_close()
//look for the view speed bug
if (string(ds_map_find_value(project,"gm82_version"))=="0") viewspeedcorrection=max_int
else viewspeedcorrection=0
ds_map_destroy(project)

//init room properties
roomcode=""
settings=ds_map_create()
ds_map_read_ini(settings,dir+"room.txt")

//load room properties
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

bg_current=0
vw_current=0

loadtext="Loading tiles..."
progress=0.25
draw_loader()

time=current_time

//load tiles
layers=file_text_read_list(dir+"layers.txt")
l=ds_list_size(layers) if (l) for (i=0;i<l;i+=1) {
    layer=real(ds_list_find_value(layers,i))
    f=file_text_open_read(dir+string(layer)+".txt") do {str=file_text_read_string(f) file_text_readln(f)
        p=string_pos(",",str) tileb=string_copy(str,1,p-1) str=string_delete(str,1,p)
        p=string_pos(",",str) tilex=real(string_copy(str,1,p-1)) str=string_delete(str,1,p)
        p=string_pos(",",str) tiley=real(string_copy(str,1,p-1)) str=string_delete(str,1,p)
        p=string_pos(",",str) tileu=real(string_copy(str,1,p-1)) str=string_delete(str,1,p)
        p=string_pos(",",str) tilev=real(string_copy(str,1,p-1)) str=string_delete(str,1,p)
        p=string_pos(",",str) tilew=real(string_copy(str,1,p-1)) str=string_delete(str,1,p)
        p=string_pos(",",str) tileh=real(string_copy(str,1,p-1))
        o=instance_create(tilex,tiley,tileholder)
        o.bgname=tileb o.depth=layer-0.01 o.tilew=tilew o.tileh=tileh o.tileu=tileu o.tilev=tilev
        o.tile=tile_add(get_background(tileb),tileu,tilev,tilew,tileh,tilex,tiley,layer)
        if (current_time>time) {
            time=current_time
            progress=(progress*9+0.25+0.5*i/l)/10
            draw_loader()
        }
    } until (file_text_eof(f)) file_text_close(f)
}
/*
loadtext="Loading dynamic tiles..."
progress=0.5

mode=0

f=file_text_open_read(dir+"code.gml") do {str=file_text_read_string(f) file_text_readln(f)
    if (string_pos("/"+"*gm82tile*"+"/",str)) mode=1
    if (mode) {
        str=file_text_read_string(f) file_text_readln(f)
        if (string_pos("/"+"*end gm82tile*"+"/",str)) {
            mode=0
        } else {
            str=string_delete(str,1,9)
            p=string_pos(",",str) tileb=string_copy(str,1,p-1) str=string_delete(str,1,p)
            p=string_pos(",",str) tileu=real(string_copy(str,1,p-1)) str=string_delete(str,1,p)
            p=string_pos(",",str) tilev=real(string_copy(str,1,p-1)) str=string_delete(str,1,p)
            p=string_pos(",",str) tilew=real(string_copy(str,1,p-1)) str=string_delete(str,1,p)
            p=string_pos(",",str) tileh=real(string_copy(str,1,p-1)) str=string_delete(str,1,p)
            p=string_pos(",",str) tilex=real(string_copy(str,1,p-1)) str=string_delete(str,1,p)
            p=string_pos(",",str) tiley=real(string_copy(str,1,p-1)) str=string_delete(str,1,p)
            p=string_pos(")",str) layer=real(string_copy(str,1,p-1))
            o=instance_create(tilex,tiley,tileholder)
            o.bgname=tileb o.depth=layer-0.01 o.tilew=tilew o.tileh=tileh o.tileu=tileu o.tilev=tilev
            o.tile=tile_add(get_background(tileb),tileu,tilev,tilew,tileh,tilex,tiley,layer)
            if (current_time>time) {
                time=current_time
                progress=(progress*9+0.75)/10
                draw_loader()
            }
        }
    } else roomcode+=str+chr(10)
} until (file_text_eof(f)) file_text_close(f)
*/

roomcode=string_replace_all(file_text_read_all(dir+"code.gml"),chr(13),"")
if (string_replace_all(string_replace_all(string_replace_all(roomcode,chr(9),""),chr(10),"")," ","")="") roomcode=""

time=current_time
loadtext="Loading instances..."

//load instances
f=file_text_open_read(dir+"instances.txt") do {str=file_text_read_string(f) file_text_readln(f)
    if (str!="") {
        o=instance_create(0,0,instance)
        p=string_pos(",",str) o.objname=string_copy(str,1,p-1) str=string_delete(str,1,p)
        p=string_pos(",",str) o.x=real(string_copy(str,1,p-1)) str=string_delete(str,1,p)
        p=string_pos(",",str) o.y=real(string_copy(str,1,p-1)) str=string_delete(str,1,p)
        p=string_pos(",",str) o.code=string_copy(str,1,p-1)
        if (o.code!="") {o.code=string_replace_all(file_text_read_all(dir+o.code+".gml"),chr(13),"") parsecode(o)}
        o.obj=get_object(o.objname)
        o.depth=objdepth[o.obj]
        o.sprite_index=objspr[o.obj]
        o.sprw=sprite_get_width(o.sprite_index)
        o.sprh=sprite_get_height(o.sprite_index)
        o.sprox=sprite_get_xoffset(o.sprite_index)
        o.sproy=sprite_get_yoffset(o.sprite_index)
        if (current_time>time) {
            time=current_time
            progress=(progress*9+1)/10
            draw_loader()
        }
    }
} until (file_text_eof(f)) file_text_close(f)
