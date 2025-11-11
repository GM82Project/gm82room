var i,yes,cur,minselx,maxselx,minsely,maxsely,dx,dy,b,str,cut;

if (instance_exists(colorpicker)) exit

cut=keyboard_check_pressed(ord("X"))

with (TextField) if (active) {
    if (keyboard_check(vk_control) && (keyboard_check_pressed(ord("C")) || cut)) {
        clipboard_set_text(text)
        if (cut) text=""
    }
    if (keyboard_check(vk_control) && keyboard_check_pressed(ord("V"))) {
        if (clipboard_has_text()) {
            text=clipboard_get_text()
            selected=0
        }
    }
    exit
}

if (keyboard_check(vk_control) && (keyboard_check_pressed(ord("C")) || cut)) {
    cur=0
    minselx=99999999
    minsely=99999999
    maxselx=-minselx
    maxsely=-minsely

    if (cut) {
        if (num_selected()) begin_undo(act_create,"cutting "+pick(mode,"instances","tiles"),0)
    }

    if (mode==0) with (instance) if (sel) {
        minselx=min(minselx,bbox_left)
        minsely=min(minsely,bbox_top)
        maxselx=max(maxselx,bbox_right+1)
        maxsely=max(maxsely,bbox_bottom+1)
        cur+=1
        copyvec[cur,0]=objname
        copyvec[cur,1]=obj
        copyvec[cur,2]=x
        copyvec[cur,3]=y
        copyvec[cur,4]=image_xscale
        copyvec[cur,5]=image_yscale
        copyvec[cur,6]=image_angle
        copyvec[cur,7]=image_blend
        copyvec[cur,8]=image_alpha
        copyvec[cur,9]=code
        copyvec[cur,10]=depth

        for (i=0;i<objfields[obj];i+=1) {
            copyvec[cur,11+i*3]=fields[i,0]
            copyvec[cur,12+i*3]=fields[i,1]
            copyvec[cur,13+i*3]=fields[i,2]
        }

        if (cut) {add_undo_instance() instance_destroy()}
    }
    if (mode==1) with (tileholder) if (sel) {
        minselx=min(minselx,bbox_left)
        minsely=min(minsely,bbox_top)
        maxselx=max(maxselx,bbox_right+1)
        maxsely=max(maxsely,bbox_bottom+1)
        cur+=1
        copyvec[cur,0]=bgname
        copyvec[cur,1]=bg
        copyvec[cur,2]=x
        copyvec[cur,3]=y
        copyvec[cur,4]=tilesx
        copyvec[cur,5]=tilesy
        copyvec[cur,6]=tile_get_left(tile)
        copyvec[cur,7]=image_blend
        copyvec[cur,8]=image_alpha
        copyvec[cur,9]=tile_get_top(tile)
        copyvec[cur,10]=tile_get_width(tile)
        copyvec[cur,11]=tile_get_height(tile)
        if (cut) {add_undo_tile() instance_destroy()}
    }
    if (cut) {push_undo() deselect()}
    if (cur>0) {
        copymode=mode
        copyvec[0,0]=cur
        copyvec[0,1]=minselx
        copyvec[0,2]=minsely
        copyvec[0,3]=maxselx
        copyvec[0,4]=maxsely
        copyvec[0,5]=minselx-floorto(minselx,gridx)
        copyvec[0,6]=minsely-floorto(minsely,gridy)

        b=buffer_create()
        buffer_write_string(b,gamename)
        buffer_write_u8(b,copymode)
        buffer_write_u32(b,copyvec[0,0])
        buffer_write_i32(b,copyvec[0,1])
        buffer_write_i32(b,copyvec[0,2])
        buffer_write_i32(b,copyvec[0,3])
        buffer_write_i32(b,copyvec[0,4])
        buffer_write_i32(b,copyvec[0,5])
        buffer_write_i32(b,copyvec[0,6])
        if (copymode==0) {
            i=1 repeat (cur) {
                buffer_write_string(b,copyvec[i,0])

                buffer_write_i32(b,copyvec[i,2])
                buffer_write_i32(b,copyvec[i,3])
                buffer_write_float(b,copyvec[i,4])
                buffer_write_float(b,copyvec[i,5])
                buffer_write_float(b,copyvec[i,6])
                buffer_write_i32(b,copyvec[i,7])
                buffer_write_float(b,copyvec[i,8])
                buffer_write_string(b,copyvec[i,9])
                buffer_write_i32(b,copyvec[i,10])

                for (j=0;j<objfields[copyvec[i,1]];j+=1) {
                    buffer_write_u8(b,copyvec[i,11+j*3]) //field set flag
                    buffer_write_variable(b,copyvec[i,12+j*3])
                    buffer_write_variable(b,copyvec[i,13+j*3])
                }
            i+=1}
        }
        if (copymode==1) {
            i=1 repeat (cur) {
                buffer_write_string(b,copyvec[i,0])

                buffer_write_i32(b,copyvec[i,2])
                buffer_write_i32(b,copyvec[i,3])
                buffer_write_float(b,copyvec[i,4])
                buffer_write_float(b,copyvec[i,5])
                buffer_write_i32(b,copyvec[i,6])
                buffer_write_i32(b,copyvec[i,7])
                buffer_write_float(b,copyvec[i,8])
                buffer_write_i32(b,copyvec[i,9])
                buffer_write_i32(b,copyvec[i,10])
                buffer_write_i32(b,copyvec[i,11])
            i+=1}
        }
        buffer_deflate(b)
        clipboard_set_text("__gm82room_clipboard"+chr_crlf+buffer_encode_base64(b,buffer_get_size(b)))
        buffer_destroy(b)
    }
}

if (keyboard_check(vk_control) && keyboard_check_pressed(ord("V"))) {
    if (clipboard_has_text()) {
        str=string_replace_all(clipboard_get_text(),chr_crlf,chr_lf)
        if (string_starts_with(str,"__gm82room_clipboard"+chr_lf)) {
            clipboard_set_text("")
            b=buffer_create()
            buffer_decode_base64(b,string_delete(str,1,21))
            buffer_inflate(b)
            buffer_set_pos(b,0)
            pastename=buffer_read_string(b)
            if (gamename!=pastename) {
                if (show_message_ext("Error pasting: can't paste clipboard data for '"+pastename+"' in '"+gamename+"'.","Accept","","Override")!=2)
                    exit
            }
            copymode=buffer_read_u8(b)
            copyvec[0,0]=buffer_read_u32(b) cur=copyvec[0,0]
            copyvec[0,1]=buffer_read_i32(b)
            copyvec[0,2]=buffer_read_i32(b)
            copyvec[0,3]=buffer_read_i32(b)
            copyvec[0,4]=buffer_read_i32(b)
            copyvec[0,5]=buffer_read_i32(b)
            copyvec[0,6]=buffer_read_i32(b)
            if (copymode==0) {
                i=1 repeat (cur) {
                    copyvec[i,0]=buffer_read_string(b)
                    copyvec[i,1]=get_object(copyvec[i,0]) if (copyvec[i,1]<0) {copymode=-1 exit}
                    copyvec[i,2]=buffer_read_i32(b)
                    copyvec[i,3]=buffer_read_i32(b)
                    copyvec[i,4]=buffer_read_float(b)
                    copyvec[i,5]=buffer_read_float(b)
                    copyvec[i,6]=buffer_read_float(b)
                    copyvec[i,7]=buffer_read_i32(b)
                    copyvec[i,8]=buffer_read_float(b)
                    copyvec[i,9]=buffer_read_string(b)
                    copyvec[i,10]=buffer_read_i32(b)

                    for (j=0;j<objfields[copyvec[i,1]];j+=1) {
                        copyvec[i,11+j*3]=buffer_read_u8(b) //field set flag
                        copyvec[i,12+j*3]=buffer_read_variable(b)
                        copyvec[i,13+j*3]=buffer_read_variable(b)
                    }
                i+=1}
            }
            if (copymode==1) {
                i=1 repeat (cur) {
                    copyvec[i,0]=buffer_read_string(b)
                    copyvec[i,1]=get_background(copyvec[i,0]) if (copyvec[i,1]<0) {copymode=-1 exit}
                    copyvec[i,2]=buffer_read_i32(b)
                    copyvec[i,3]=buffer_read_i32(b)
                    copyvec[i,4]=buffer_read_float(b)
                    copyvec[i,5]=buffer_read_float(b)
                    copyvec[i,6]=buffer_read_i32(b)
                    copyvec[i,7]=buffer_read_i32(b)
                    copyvec[i,8]=buffer_read_float(b)
                    copyvec[i,9]=buffer_read_i32(b)
                    copyvec[i,10]=buffer_read_i32(b)
                    copyvec[i,11]=buffer_read_i32(b)
                i+=1}
            }
            buffer_destroy(b)
        }
    }

    if (copyvec[0,0]) {
        if (copymode!=mode) show_message("Clipboard currently contains "+pick(copymode+1,"no data.","instance data. To paste, please switch to the instances tab.","tile data. To paste, please switch to the tiles tab."))
        else {
            with (instance) sel=0
            with (tileholder) sel=0
            if (keyboard_check(vk_alt)) {
                dx=global.mousex-copyvec[0,1]
                dy=global.mousey-copyvec[0,2]
            } else {
                dx=floorto(global.mousex-copyvec[0,1]+copyvec[0,5],gridx)
                dy=floorto(global.mousey-copyvec[0,2]+copyvec[0,6],gridy)
            }

            cur=1
            if (mode==0) repeat (copyvec[0,0]) {
                //note: if you have instances copied that would be invisible in the current view, they'l be visible
                o=instance_create(copyvec[cur,2]+dx,copyvec[cur,3]+dy,instance) get_uid(o)
                o.obj=copyvec[cur,1]
                o.objname=copyvec[cur,0]
                o.depth=copyvec[cur,10]
                o.sprite_index=objspr[o.obj]
                o.sprw=sprite_get_width(o.sprite_index)
                o.sprh=sprite_get_height(o.sprite_index)
                o.sprox=sprite_get_xoffset(o.sprite_index)
                o.sproy=sprite_get_yoffset(o.sprite_index)
                o.image_xscale=copyvec[cur,4]
                o.image_yscale=copyvec[cur,5]
                o.image_angle=copyvec[cur,6]
                o.image_blend=copyvec[cur,7]
                o.image_alpha=copyvec[cur,8]
                o.code=copyvec[cur,9]
                parse_code_into_fields(o,1)

                for (i=0;i<objfields[o.obj];i+=1) {
                    if (objfieldtype[o.obj,i]!="instance") {
                        o.fields[i,0]=copyvec[cur,11+i*3]
                        o.fields[i,1]=copyvec[cur,12+i*3]
                        o.fields[i,2]=copyvec[cur,13+i*3]
                        
                        if (o.fields[i,0]) o.hasfields=1
                    }
                }

                o.sel=1
                o.modified=1
                select=o
                cur+=1

                if (copyvec[0,0]==1) with (o) update_inspector()
            }
            if (mode==1) repeat (copyvec[0,0]) {
                o=instance_create(copyvec[cur,2]+dx,copyvec[cur,3]+dy,tileholder) get_uid(o)
                o.tilew=copyvec[cur,10]
                o.tileh=copyvec[cur,11]
                o.bgname=copyvec[cur,0]
                o.bg=copyvec[cur,1]
                o.tilesx=copyvec[cur,4]
                o.tilesy=copyvec[cur,5]
                o.image_xscale=o.tilesx*o.tilew
                o.image_yscale=o.tilesy*o.tileh
                o.image_blend=copyvec[cur,7]
                o.image_alpha=copyvec[cur,8]

                o.tlayer=ly_depth
                o.tile=tile_add(o.bg,copyvec[cur,6],copyvec[cur,9],o.tilew,o.tileh,o.x,o.y,ly_depth)
                tile_set_scale(o.tile,o.tilesx,o.tilesy)
                tile_set_blend(o.tile,o.image_blend)
                tile_set_alpha(o.tile,o.image_alpha)

                o.sel=1
                o.modified=1
                selectt=o
                cur+=1

                if (copyvec[0,0]==1) with (o) update_inspector()
            }
            begin_undo(act_destroy,"pasting "+pick(mode,"instances","tiles"),0)
            if (mode==0) {
                with (instance) if (modified) {add_undo(uid) modified=0}
            }
            if (mode==1) {
                with (tileholder) if (modified) {add_undo(uid) modified=0}
            }
            push_undo()
            update_instance_memory()
            update_selection_bounds()
        }
    }
}
