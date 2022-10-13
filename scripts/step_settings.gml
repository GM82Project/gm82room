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

    //resize reference image
    if (grabref) {
        if (keyboard_check(vk_alt)) {
            dx=global.mousex
            dy=global.mousey
        } else {
            dx=roundto(global.mousex,gridx)
            dy=roundto(global.mousey,gridy)
        }
        if (grabref==1) {
            ref_angle=point_direction(ref_x,ref_y,global.mousex,global.mousey)+90-90*sign(ref_w)
            if (!keyboard_check(vk_alt)) {
                ref_angle=roundto(ref_angle,15) mod 360
            }
        }
        if (grabref==3) {
            dir=point_direction(ref_x,ref_y,dx,dy)
            len=point_distance(ref_x,ref_y,dx,dy)

            ref_w=lengthdir_x(len,dir-ref_angle)
            ref_h=lengthdir_y(len,dir-ref_angle)
        }
        if (grabref==5) {
            if (keyboard_check(vk_alt)) {
                ref_x=global.mousex-offx
                ref_y=global.mousey-offy
            } else {
                ref_x=roundto(global.mousex-offx,gridx)
                ref_y=roundto(global.mousey-offy,gridy)
            }
        }
        if (!mouse_check_direct(mb_left) || !mouse_check_button(mb_left)) {
            grabref=0
        }
        update_settingspanel()
    }

    //resize room
    if (grabroom) {
        if (keyboard_check(vk_alt)) {
            dx=global.mousex
            dy=global.mousey
        } else {
            dx=roundto(global.mousex,gridx)
            dy=roundto(global.mousey,gridy)
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
                roomleft=roundto(global.mousex-offx,gridx)
                roomtop=roundto(global.mousey-offy,gridy)
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
