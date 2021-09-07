var l,b,count,find,fn,i;

fn=get_save_filename("Chunk files|*.82c","chunk.82c")

if (fn!="") {
    fn=filename_change_ext(fn,".82c")
    if (chunkcrop) {
        instance_deactivate_object(instance)
        instance_deactivate_object(tileholder)
        instance_activate_region(chunkleft,chunktop,chunkwidth-1,chunkheight-1,1)
    } else instance_activate_all()

    b=buffer_create()
    buffer_write_u8(b,2) //chunk version
    buffer_write_string(b,gamename)

    buffer_write_u32(b,chunkwidth)
    buffer_write_u32(b,chunkheight)

    l=ds_list_create()

    with (tileholder) {if (ds_list_find_index(l,bgname)==-1) ds_list_add(l,bgname)}
    s=ds_list_size(l)
    buffer_write_u16(b,s)
    for (i=0;i<s;i+=1) {
        find=ds_list_find_value(l,i)
        buffer_write_string(b,find)
        count=0 with (tileholder) {if (bgname==find) count+=1}
        buffer_write_u16(b,count)
        with (tileholder) if (bgname==find) {
            buffer_write_u32(b,tile_get_left(tile))
            buffer_write_u32(b,tile_get_top(tile))
            buffer_write_u32(b,tilew)
            buffer_write_u32(b,tileh)
            buffer_write_i32(b,x-chunkleft)
            buffer_write_i32(b,y-chunktop)
            buffer_write_i32(b,tlayer)
            buffer_write_float(b,tilesx)
            buffer_write_float(b,tilesy)
            buffer_write_u8(b,round(image_alpha*255))
            buffer_write_u8(b,round(color_get_blue(image_blend)))
            buffer_write_u8(b,round(color_get_green(image_blend)))
            buffer_write_u8(b,round(color_get_red(image_blend)))
        }
    }
    ds_list_clear(l)
    with (instance) {if (ds_list_find_index(l,objname)==-1) ds_list_add(l,objname)}
    s=ds_list_size(l)
    buffer_write_u16(b,s)
    for (i=0;i<s;i+=1) {
        find=ds_list_find_value(l,i)
        buffer_write_string(b,find)
        count=0 with (instance) {if (objname==find) count+=1}
        buffer_write_u16(b,count)
        with (instance) if (objname==find) {
            buffer_write_i32(b,x-chunkleft)
            buffer_write_i32(b,y-chunktop)
            buffer_write_float(b,image_xscale)
            buffer_write_float(b,image_yscale)
            buffer_write_float(b,image_angle)
            buffer_write_u8(b,round(image_alpha*255))
            buffer_write_u8(b,round(color_get_blue(image_blend)))
            buffer_write_u8(b,round(color_get_green(image_blend)))
            buffer_write_u8(b,round(color_get_red(image_blend)))
            buffer_write_string(b,code)
        }
    }
    ds_list_destroy(l)

    buffer_deflate(b)

    buffer_save(b,fn)
    buffer_destroy(b)

    change_mode(mode)
}
