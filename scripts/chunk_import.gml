///(filename,x,y,scale)

var l,b,count,find,fn,i,o,ox,oy,scale,name;

//fn=argument0
//ox=argument1
//oy=argument2
//scale=argument3

fn=get_open_filename("Chunk files|*.82c","")
ox=chunkleft
oy=chunktop
scale=1

if (fn!="") {
    b=buffer_create()
    buffer_load(b,fn)
    buffer_inflate(b)

    //chunk version
    if (buffer_read_u8(b)>1) {
        show_message("Chunk file version is too new. Please download an updated version to load this chunk file.")
        exit
    }

    name=buffer_read_string(b)
    if (gamename!=name) {
        if (!show_question("This chunk file seems to be from a different game:##Current game: '"+gamename+"'#Chunk file: '"+name+"'##Do you still want to load it? It may cause corruption.")) {
            exit
        }
    }

    bgmap=global.__gm82chunk_bgmap
    objmap=global.__gm82chunk_objmap

    repeat (buffer_read_u16(b)) {
        name=buffer_read_string(b)
        repeat (buffer_read_u16(b)) {
            o=instance_create(ox,oy,tileholder) get_uid(o)

            left=buffer_read_u32(b)
            top=buffer_read_u32(b)
            o.tilew=buffer_read_u32(b)
            o.tileh=buffer_read_u32(b)
            o.x=buffer_read_i32(b)*scale
            o.y=buffer_read_i32(b)*scale
            o.tlayer=buffer_read_i32(b) o.depth=o.tlayer-0.01

            o.tilesx=buffer_read_float(b)*scale
            o.tilesy=buffer_read_float(b)*scale
            o.image_alpha=buffer_read_u8(b)/$ff
            o.image_blend=$10000*buffer_read_u8(b)+$100*buffer_read_u8(b)+buffer_read_u8(b)

            i=tile_add(find,left,top,o.tilew,o.tileh,ox+o.x,oy+o.y,o.tlayer)
            tile_set_scale(i,o.tilesx,o.tilesy)
            tile_set_alpha(i,o.image_alpha)
            tile_set_blend(i,o.image_blend)
            o.modified=1
        }
    }
    repeat (buffer_read_u16(b)) {
        name=buffer_read_string(b)
        repeat (buffer_read_u16(b)) {
            o=instance_create(ox,oy,instance) get_uid(o)
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

begin_undo(act_destroy,"pasting "+pick(mode,"instances","tiles"))
if (mode==0) {
    with (instance) if (modified) {add_undo(id) modified=0}
}
if (mode==1) {
    with (tileholder) if (modified) {add_undo(id) modified=0}
}
push_undo()
update_instance_memory()
