if (mode==4) {
    //grabbed the chunk thingy
    if (grabchunk) {
        if (keyboard_check(vk_alt)) {
            chunkleft=global.mousex-offx
            chunktop=global.mousey-offy
        } else {
            chunkleft=floorto(global.mousex-offx,gridx)
            chunktop=floorto(global.mousey-offy,gridy)
        }
        update_settingspanel()
        if (!mouse_check_direct(mb_left) || !mouse_check_button(mb_left)) {
            grabchunk=0
        }
    }

    //resized the chunk
    if (sizechunk) {
        if (keyboard_check(vk_alt)) {
            chunkwidth=max(1,global.mousex-chunkleft)
            chunkheight=max(1,global.mousey-chunktop)
        } else {
            chunkwidth=max(gridx,roundto(global.mousex,gridx)-chunkleft)
            chunkheight=max(gridy,roundto(global.mousey,gridy)-chunktop)
        }
        update_settingspanel()
        if (!mouse_check_direct(mb_left) || !mouse_check_button(mb_left)) {
            sizechunk=0
        }
    }

    //resize room
    if (grabroom) {
        if (keyboard_check(vk_alt)) {
            dx=global.mousex
            dy=global.mousey
        } else {
            dx=floorto(global.mousex,gridx)
            dy=floorto(global.mousey,gridy)
        }
        if (grabroom==1) {
            roomleft=dx
            roomtop=dy
        }
        if (grabroom==2) {
            roomwidth=dx
            roomtop=dy
        }
        if (grabroom==3) {
            roomwidth=dx
            roomheight=dy
        }
        if (grabroom==4) {
            roomleft=dx
            roomheight=dy
        }
        if (grabroom==5) {
            if (keyboard_check(vk_alt)) {
                roomleft=global.mousex-offx
                roomtop=global.mousey-offy
            } else {
                roomleft=floorto(global.mousex-offx,gridx)
                roomtop=floorto(global.mousey-offy,gridy)
            }
            roomwidth=roomleft+storex
            roomheight=roomtop+storey
        }
        if (!mouse_check_direct(mb_left) || !mouse_check_button(mb_left)) {
            grabroom=0
            if (roomleft!=0 || roomtop!=0) {
                room_shift(-roomleft,-roomtop)
                roomwidth-=roomleft
                roomheight-=roomtop
                roomleft=0
                roomtop=0
            }
        }
        update_settingspanel()
    }
}
