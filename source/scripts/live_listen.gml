var sock,buf;

sock=global.livesock
buf=global.livebuf

if (global.live_connect) {
    state=socket_get_state(sock)
    if (state==2) {
        global.live_connect=0
        show_live_message("Live: Connected to Game!")
        live_send_room_data()
    }
    if (state==5) {
        global.live_connect=0
        show_live_message("Live: Error connecting to game.")
        socket_close(sock)
        socket_destroy(sock)
        global.livesock=noone
    }
}

if (sock!=noone) {
    socket_receive(sock)
    while (socket_read_message(sock,buf)) {
        buffer_set_pos(buf,0)
        type=buffer_read_u8(buf)
        if (type==1) {
            //game performed a room start and is requesting room data
            live_send_room_data()
            show_live_message("Live: Game performed a Room Start")
        }
    }
}
