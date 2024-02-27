if (mode==4) {
    //grabbed the chunk thingy
    if (grabchunk) {
        if (keyboard_check(vk_alt)) {
            chunkleft=global.mousex-offx
            chunktop=global.mousey-offy
        } else {
            chunkleft=roundto(global.mousex-offx,gridx)
            chunktop=roundto(global.mousey-offy,gridy)
        }
        update_settingspanel()
        if (!direct_mbleft) {
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
        if (!direct_mbleft) {
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
        if (!direct_mbleft) {
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
        if (grabroom==1) {                                    //[1]--------------------------[2]
            roomleft=min(dx,roomwidth)                        ///|                            |
            roomtop=min(dy,roomheight)                        ///|                            |
        }                                                     ///|                            |
        if (grabroom==2) {                                    ///|                            |
            roomwidth=max(dx,1)                               //[4]---------------------------[3]
            roomtop=min(dy,roomheight)
        }
        if (grabroom==3) {
            roomwidth=max(dx,1)
            roomheight=max(dy,1)
        }
        if (grabroom==4) {
            roomleft=min(dx,roomwidth)
            roomheight=max(dy,1)
        }
        if (grabroom==5) {
            if (keyboard_check(vk_alt)) {
                roomleft=global.mousex-offx
                roomtop=global.mousey-offy
            } else {
                roomleft=roundto(global.mousex-offx,gridx)
                roomtop=roundto(global.mousey-offy,gridy)
            }
            roomwidth=max(roomleft+storex,1)
            roomheight=max(roomtop+storey,1)
        }
        if (!direct_mbleft) {
            grabroom=0
            if (roomleft!=0 || roomtop!=0) {
                room_shift(-roomleft,-roomtop)
                //roomwidth-=roomleft
                //roomheight-=roomtop
                roomwidth=abs(roomwidth-roomleft)
                roomheight=abs(roomheight-roomtop)
                roomleft=0
                roomtop=0
            }
        }
        update_settingspanel()
    }
}
