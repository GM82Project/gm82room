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
        if (!mouse_check_direct(mb_left)) {
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
        if (!mouse_check_direct(mb_left)) {
            sizechunk=0
        }
    }
}
