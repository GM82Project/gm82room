var i,c,objc,b,sock;

sock=global.livesock

if (sock=noone) {
    sock=socket_create()
    socket_connect(sock,"127.0.0.1",4126)
    global.livesock=sock
    global.livebuf=buffer_create()
}

socket_update_read(sock)

objc=0 for (i=0;i<objects_length;i+=1) if (objloaded[i]) objc+=1

if (objc) {
    b=global.livebuf
    buffer_clear(b)
    buffer_write_u32(b,objc)

    for (i=0;i<objects_length;i+=1) if (objloaded[i]) {
        buffer_write_u32(b,i)

        c=0 with (instance) if (obj==i) c+=1
        buffer_write_u32(b,c)

        with (instance) if (obj=i) {
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

    socket_write_message(sock,b)
    socket_update_write(sock)
}
