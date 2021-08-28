///(filename,x,y,scale)

var l,b,count,find,fn,i,o,scale,name;

//fn=argument0
//ox=argument1
//oy=argument2
//scale=argument3

fn=get_open_filename("Chunk files|*.82c","")

scale=1

if (fn!="") {
    deselect()
    view[0]=1
    view[1]=1
    chunkcrop=1
    chunkloaded=1
    chunkname=filename_name(fn)

    b=buffer_create()
    buffer_load(b,fn)
    buffer_inflate(b)

    //chunk version
    if (buffer_read_u8(b)>2) {
        show_message("Chunk file version is too new. Please download an updated version to load this chunk file.")
        exit
    }

    name=buffer_read_string(b)
    if (gamename!=name) {
        if (!show_question("This chunk file seems to be from a different game:##Current game: '"+gamename+"'#Chunk file: '"+name+"'##Do you still want to load it? It may cause corruption.")) {
            exit
        }
    }

    chunkwidth=buffer_read_u32(b)
    chunkheight=buffer_read_u32(b)
    update_settingspanel()

    repeat (buffer_read_u16(b)) {
        name=buffer_read_string(b)
        find=ds_map_find_value(bglookup,name)
        texture=bg_background[find]
        repeat (buffer_read_u16(b)) {
            o=instance_create(chunkleft,chunktop,tileholder) get_uid(o)
            o.bg=texture
            o.bgname=name

            left=buffer_read_u32(b)
            top=buffer_read_u32(b)
            o.tilew=buffer_read_u32(b)
            o.tileh=buffer_read_u32(b)
            o.x+=buffer_read_i32(b)*scale
            o.y+=buffer_read_i32(b)*scale
            o.tlayer=buffer_read_i32(b) o.depth=o.tlayer-0.01

            o.tilesx=buffer_read_float(b)*scale
            o.tilesy=buffer_read_float(b)*scale
            o.image_alpha=buffer_read_u8(b)/$ff
            o.image_blend=$10000*buffer_read_u8(b)+$100*buffer_read_u8(b)+buffer_read_u8(b)

            o.tile=tile_add(texture,left,top,o.tilew,o.tileh,o.x,o.y,o.tlayer)
            tile_set_scale(o.tile,o.tilesx,o.tilesy)
            tile_set_alpha(o.tile,o.image_alpha)
            tile_set_blend(o.tile,o.image_blend)
            o.modified=1
        }
    }
    repeat (buffer_read_u16(b)) {
        name=buffer_read_string(b)
        find=ds_map_find_value(objlookup,name)
        repeat (buffer_read_u16(b)) {
            o=instance_create(chunkleft,chunktop,instance) get_uid(o)
            o.objname=name
            o.obj=get_object(o.objname)
            o.sprite_index=objspr[o.obj]
            o.sprw=sprite_get_width(o.sprite_index)
            o.sprh=sprite_get_height(o.sprite_index)
            o.sprox=sprite_get_xoffset(o.sprite_index)
            o.sproy=sprite_get_yoffset(o.sprite_index)

            o.x+=buffer_read_i32(b)*scale
            o.y+=buffer_read_i32(b)*scale
            o.image_xscale=buffer_read_float(b)*scale
            o.image_yscale=buffer_read_float(b)*scale
            o.image_angle=buffer_read_float(b)
            o.image_alpha=buffer_read_u8(b)/$ff
            o.image_blend=$10000*buffer_read_u8(b)+$100*buffer_read_u8(b)+buffer_read_u8(b)
            o.code=buffer_read_string(b)
            o.modified=1
        }
    }

    buffer_destroy(b)
}

mode=0
begin_undo(act_destroy,"",0)
with (instance) if (modified) {add_undo(uid) modified=0 sel=1}
mode=1
begin_undo(act_destroy,"importing a chunk file",1)
with (tileholder) if (modified) {add_undo(uid) modified=0 sel=1}
push_undo()
mode=4

update_instance_memory()
