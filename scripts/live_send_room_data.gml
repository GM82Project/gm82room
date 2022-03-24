var i,objc,b,sock,insc;

sock=global.livesock

if (sock=noone) {
    sock=socket_create()
    socket_connect(sock,"127.0.0.1",4126)
    global.livesock=sock
    global.livebuf=buffer_create()
}

socket_update_read(sock)

if (mode==0) {
    instance_activate_object(instance)
    objc=0 for (i=0;i<objects_length;i+=1) if (objloaded[i]) {
        with (instance) if (obj==i) {objc+=1 break}
    }

    if (objc) {
        b=global.livebuf
        buffer_clear(b)
        buffer_write_u8(b,0)
        buffer_write_u16(b,objc)
        for (i=0;i<objects_length;i+=1) if (objloaded[i]) {
            insc=0
            with (instance) if (obj==i) insc+=1
            if (insc) {
                buffer_write_u16(b,i)
                buffer_write_u16(b,insc)
                with (instance) if (obj==i) {
                    buffer_write_i32(b,x)
                    buffer_write_i32(b,y)
                    buffer_write_double(b,image_xscale)
                    buffer_write_double(b,image_yscale)
                    buffer_write_double(b,image_angle)
                    buffer_write_u32(b,image_blend)
                    buffer_write_double(b,image_alpha)
                    buffer_write_string(b,code)
                }
            }
        }

        socket_write_message(sock,b)
        socket_update_write(sock)
    }
    change_mode(mode)
}
if (mode==1) {
    /*instance_activate_object(tile)

    for (i=0;i<layersize;i+=1) {
        d=ds_list_find_value(layers,i)

    }


    buffer_write_u16(b,background)
    buffer_write_u16(b,left)
    buffer_write_u16(b,top)
    buffer_write_u16(b,width)
    buffer_write_u16(b,height)
    buffer_write_i32(b,x)
    buffer_write_i32(b,y)
    */
}
