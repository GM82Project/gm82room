///(filename,x,y,scale)

var l,b,count,find,fn,i,o,ox,oy,scale,name;

//fn=argument0
//ox=argument1
//oy=argument2
//scale=argument3
/*
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
            o=instance_create(ox,oy,tileholder)

            i=tile_add(find,buffer_read_u32(b),buffer_read_u32(b),buffer_read_u32(b),buffer_read_u32(b),ox+buffer_read_i32(b)*scale,oy+buffer_read_i32(b)*scale,buffer_read_i32(b))
            tile_set_scale(i,buffer_read_float(b)*scale,buffer_read_float(b)*scale)
            tile_set_alpha(i,buffer_read_u8(b)/$ff)
            tile_set_blend(i,$10000*buffer_read_u8(b)+$100*buffer_read_u8(b)+buffer_read_u8(b))
        }
    }
    repeat (buffer_read_u16(b)) {
        name=buffer_read_string(b)
        repeat (buffer_read_u16(b)) {
            o=instance_create(ox,oy,instance)
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
        }
    }

    buffer_destroy(b)
}
