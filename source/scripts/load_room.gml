var loading_autosave;

var f,p,i,l,inst,layer,map,tileid;

draw_loader("Loading project...",0.125,"")

//find room
if (parameter_count()) {
    //summoned from gm82
    savedir=parameter_string(1)
} else {
    //clicked on
    savedir=filename_dir(get_open_filename("GM8.2 Room|room.txt","room.txt"))
    window_default()
}

if (savedir="") {
    //this is for faster testing on my computer :)
    if (string_pos("gm_ttt_",program_directory)) {
        savedir="C:\Stuff\github\renex-engine\source\rooms\rmTemplate"
        //savedir="C:\Users\rene\Desktop\github\renex-engine\source\rooms\rmTemplate"
        //savedir="C:\Stuff\github\mkfusion\rooms\rm9_S1Area3"
    }
    if (!file_exists(savedir+"\room.txt")) {
        //ah. it's not my computer.
        game_end()
        return 0
    }
}

roomname=filename_name(savedir)
room_caption+=" - "+roomname
set_application_title(roomname+" - Room Editor")
global.default_caption=room_caption

savedir+="\"
root=directory_previous(directory_previous(savedir))
pjfile=file_find_first(root+"*.gm82",0) file_find_close()
gamename=filename_change_ext(pjfile,"")

jtool_loaded_engine="yoyoyo"

//load main project file
project=ds_map_create()
ds_map_read_ini(project,root+pjfile)
    gm82version=real(ds_map_find_value(project,"gm82_version"))
    if (gm82version==5) {
        has_backgrounds=real(ds_map_find_value(project,"has_backgrounds"))
        has_datafiles=real(ds_map_find_value(project,"has_datafiles"))
        has_fonts=real(ds_map_find_value(project,"has_fonts"))
        has_objects=real(ds_map_find_value(project,"has_objects"))
        has_paths=real(ds_map_find_value(project,"has_paths"))
        has_scripts=real(ds_map_find_value(project,"has_scripts"))
        has_sounds=real(ds_map_find_value(project,"has_sounds"))
        has_sprites=real(ds_map_find_value(project,"has_sprites"))
        has_timelines=real(ds_map_find_value(project,"has_timelines"))
    } else {
        has_backgrounds=1
        has_datafiles=1
        has_fonts=1
        has_objects=1
        has_paths=1
        has_scripts=1
        has_sounds=1
        has_sprites=1
        has_timelines=1
    }
//ds_map_destroy(project)

if (gm82version!=4 && gm82version!=5) {
    if (gm82version<4) show_message("Error loading "+gamename+": "+crlf+"Project version ("+string(gm82version)+") is too old."+crlf+"Please update Game Maker 8.2 and Save As to refresh the project.")
    else show_message("Error loading "+gamename+": "+crlf+"Project version ("+string(gm82version)+") is too new!"+crlf+"Please update Game Maker 8.2.")
    game_end()
    exit
}

load_thumbs()


//load assets
objlookup=ds_map_create()
bglookup=ds_map_create()

sprites=file_text_read_list(root+"sprites\index.yyd",noone,true)
sprites_length=ds_list_size(sprites)
sprloaded_len[sprites_length]=0

backgrounds=file_text_read_list(root+"backgrounds\index.yyd",bglookup,true)
backgrounds_length=ds_list_size(backgrounds)
bgloaded[backgrounds_length]=0
bghastiles[backgrounds_length]=0

objects=file_text_read_list(root+"objects\index.yyd",objlookup,true)
objects_length=ds_list_size(objects)
objloaded[objects_length]=0

load_constants(root+"settings\constants.txt")
load_datafiles(root+"datafiles\index.yyd")

//i know this is terrible but i can't make this clean and fast simultaneously
//also we load objects first to make sure we don't run out of GDI objects on the more important menu
//(windows has a 9999 GDI object per program limit and every menu thumbnail is one)
draw_loader("Loading resource tree...",0.125,"Objects")
load_object_tree(root+"objects\tree.yyd")

draw_loader("Loading resource tree...",0.125,"Sprites")
load_sprite_tree(root+"sprites\tree.yyd")

draw_loader("Loading resource tree...",0.125,"Sounds")
load_sound_tree(root+"sounds\tree.yyd")

draw_loader("Loading resource tree...",0.125,"Backgrounds")
load_background_tree(root+"backgrounds\tree.yyd")

draw_loader("Loading resource tree...",0.125,"Paths")
load_path_tree(root+"paths\tree.yyd")
load_paths()

draw_loader("Loading resource tree...",0.125,"Scripts")
load_script_tree(root+"scripts\tree.yyd")

draw_loader("Loading resource tree...",0.125,"Fonts")
load_font_tree(root+"fonts\tree.yyd")
load_fonts()

draw_loader("Loading resource tree...",0.125,"Timelines")
load_timeline_tree(root+"timelines\tree.yyd")

draw_loader("Loading resource tree...",0.125,"Rooms")
load_room_tree(root+"rooms\tree.yyd")

//check autosave
loading_autosave=false
if (directory_exists(savedir+"autosave")) {
    if (show_question("Hey, it looks like something happened before#and there's an autosave backup for this room.##Do you want to load the backup?")) {
        dir+="autosave\"
        loading_autosave=true
    }
}

//read room settings
settings=ds_map_create()
ds_map_read_ini(settings,savedir+"room.txt")

backgroundcolor=real(ds_map_find_value(settings,"bg_color"))
clearscreen=real(ds_map_find_value(settings,"clear_screen"))
clearview=real(ds_map_find_value(settings,"clear_view"))
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

    //placeholders for room editor mods
    bg_blend[i]=$ffffff
    bg_alpha[i]=1
    bg_xscale[i]=1
    bg_yscale[i]=1

    //preview values
    bg_scrollx[i]=0
    bg_scrolly[i]=0

    vw_visible[i]=real(ds_map_find_value(settings,"view_visible"+k))
    vw_x[i]=real(ds_map_find_value(settings,"view_xview"+k))
    vw_y[i]=real(ds_map_find_value(settings,"view_yview"+k))
    vw_w[i]=real(ds_map_find_value(settings,"view_wview"+k))
    vw_h[i]=real(ds_map_find_value(settings,"view_hview"+k))
    vw_xp[i]=real(ds_map_find_value(settings,"view_xport"+k))
    vw_yp[i]=real(ds_map_find_value(settings,"view_yport"+k))
    vw_wp[i]=real(ds_map_find_value(settings,"view_wport"+k))
    vw_hp[i]=real(ds_map_find_value(settings,"view_hport"+k))
    vw_hbor[i]=real(ds_map_find_value(settings,"view_fol_hbord"+k))
    vw_vbor[i]=real(ds_map_find_value(settings,"view_fol_vbord"+k))
    vw_hspeed[i]=real(ds_map_find_value(settings,"view_fol_hspeed"+k))
    vw_vspeed[i]=real(ds_map_find_value(settings,"view_fol_vspeed"+k))
    vw_follow[i]=ds_map_find_value(settings,"view_fol_target"+k)
}

roomcode=parse_code_into_flags(file_text_read_all(savedir+"code.gml",lf))

//load tiles
progress=0.25
time=current_time
c=0
layers=file_text_read_list(savedir+"layers.txt",noone,false)
layersize=ds_list_size(layers)
if (layersize) {
    for (i=0;i<layersize;i+=1) {
        layer=real(ds_list_find_value(layers,i))
        ds_list_replace(layers,i,layer)
        f=file_text_open_read_safe(savedir+string(layer)+".txt") if (f) {do {str=file_text_read_string(f) file_text_readln(f)
            o=instance_create(0,0,tileholder) get_uid(o)

            string_token_start(str,",")
            o.bgname=string_token_next()
            o.x=real(string_token_next())
            o.y=real(string_token_next())
            tileu=real(string_token_next())
            tilev=real(string_token_next())
            o.tilew=real(string_token_next())
            o.tileh=real(string_token_next())

            o.bg=get_background_tiles(o.bgname)
            if (micro_optimization_bgid!=noone) {
                //check that the tile is inside the background
                if (o.tilew==0) o.tilew=16
                if (o.tileh==0) o.tileh=16
                bgw=background_get_width(bg_background[micro_optimization_bgid])
                bgh=background_get_height(bg_background[micro_optimization_bgid])
                
                if (dotilecrop) {
                    o.tilew=min(o.tilew,bgw-tileu)
                    o.tileh=min(o.tileh,bgh-tilev)
                }

                o.tile=tile_add(o.bg,tileu,tilev,o.tilew,o.tileh,o.x,o.y,layer)
                o.tlayer=layer

                o.image_xscale=o.tilew
                o.image_yscale=o.tileh

                string_token_next() //skip "locked" flag
                o.tilesx=real(string_token_next())
                o.tilesy=real(string_token_next())
                tileblend=real(string_token_next())

                o.image_xscale*=o.tilesx
                o.image_yscale*=o.tilesy
                o.image_alpha=floor(tileblend/$1000000)/$ff
                o.image_blend=tileblend&$ffffff

                tile_set_scale(o.tile,o.tilesx,o.tilesy)
                tile_set_alpha(o.tile,o.image_alpha)
                tile_set_blend(o.tile,o.image_blend)
            } else with (o) instance_destroy()
            
            if (o.tilew<=0 or o.tileh<=0) with (o) instance_destroy()

            c+=1

            if (current_time>time+200) {
                time=current_time
                progress=(progress*9+0.25+0.5*i/layersize)/10
                draw_loader("Loading tiles...",progress,string(c))
            }
        } until (file_text_eof(f)) file_text_close(f)}
    }
} else add_tile_layer()


//load instances
time=current_time
c=0
f=file_text_open_read_safe(savedir+"instances.txt") if (f) {do {str=file_text_read_string(f) file_text_readln(f)
    if (str!="") {
        o=instance_create(0,0,instance)

        string_token_start(str,",")
        o.objname=string_token_next()
        o.x=real(string_token_next())
        o.y=real(string_token_next())

        set_uid(o,string_token_next())

        orderlast+=1
        o.order=orderlast

        string_token_next() //skip "locked" flag
        o.image_xscale=real(string_token_next())
        o.image_yscale=real(string_token_next())
        o.image_blend=real(string_token_next())
        o.image_angle=real(string_token_next())

        o.image_alpha=floor(o.image_blend/$1000000)/$ff
        o.image_blend=o.image_blend&$ffffff

        if (string_token_next()=="1") {//has code flag
            fn=savedir+o.uid+".gml"
            if (!file_exists(fn)) {show_error("Error loading instance data:"+crlf+crlf+" Missing "+qt+fn+qt+" file.",1) exit}
            o.code=file_text_read_all(fn,lf)
            l=string_length(o.code)
            if (string_char_at(o.code,l)==lf) o.code=string_copy(o.code,1,l-1)
        }

        //load this last so we don't interrupt the token stream
        o.obj=get_object(o.objname)

        o.depth=objdepth[o.obj]
        o.sprite_index=objspr[o.obj]

        o.sprw=sprite_get_width(o.sprite_index)
        o.sprh=sprite_get_height(o.sprite_index)
        o.sprox=sprite_get_xoffset(o.sprite_index)
        o.sproy=sprite_get_yoffset(o.sprite_index)

        parse_code_into_fields(o,0)

        c+=1

        if (current_time>time+200) {
            time=current_time
            progress=(progress*9+1)/10
            draw_loader("Loading instances...",progress,string(c))
        }
    }
} until (file_text_eof(f)) file_text_close(f)}

//load last 3 objects added for convenience
i=objects_length
var lastobj;lastobj=noone
repeat (3) {
    if (i!=0) {
        do {i-=1 o=ds_list_find_value(objects,i)} until (i==0 || o!="")
        if (i!=0) {
            get_object(o)
            //and then select the last one
            if (lastobj=noone) lastobj=objpal
        }
    }
}
objpal=lastobj


//fill object hotbar with most used objects
var tempmap;tempmap=ds_map_create()
var temppr;temppr=ds_priority_create()

with (instance)
    if (ds_map_exists(tempmap,obj)) ds_map_replace(tempmap,obj,ds_map_find_value(tempmap,obj)+1)
    else ds_map_add(tempmap,obj,1)

key=ds_map_find_first(tempmap) repeat (ds_map_size(tempmap)) {
    ds_priority_add(temppr,key,ds_map_find_value(tempmap,key))
key=ds_map_find_next(tempmap,key)}

ds_map_destroy(tempmap)

i=1 repeat (min(9,ds_priority_size(temppr))) {
    objhotbar[i]=ds_priority_delete_max(temppr)
i+=1}

ds_priority_destroy(temppr)

//and before you ask, no, we're not doing that for tiles that would be insanely slow


if (loading_autosave) {
    savedir=directory_previous(savedir)
}

draw_loader("Finishing up...",progress,"")

return 1
