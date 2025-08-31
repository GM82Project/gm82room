var sock,buf;

sock=global.livesock
buf=global.livebuf

if (global.live_connect) {
    socket_receive(sock)
    state=socket_get_state(sock)
    if (state==tcp_connected) {
        global.live_connect=0
        show_live_message("Test: Connected to Game!")
        live_send_room_data()
    }
    if (state==tcp_error or state==tcp_closed) {
        global.live_connect=0
        show_live_message("Test: Error connecting to game.")
        socket_close(sock)
        socket_destroy(sock)
        global.livesock=noone
    }
} else if (sock!=noone) {
    socket_receive(sock)

    if (socket_get_state(sock)!=tcp_connected) {
        socket_destroy(global.livesock)
        show_live_message("Test: Disconnected from game.")
        global.livesock=noone
        exit
    }

    while (socket_read_message(sock,buf)) {
        buffer_set_pos(buf,0)
        type=buffer_read_u8(buf)
        if (type==1) {
            //game performed a room start and is requesting room data
            live_send_room_data()
            show_live_message("Test: Game performed a Room Start")
        }
    }
}
