var yes,cur,minselx,maxselx,minsely,maxsely,dx,dy;

if (keyboard_check(vk_control) && keyboard_check_pressed(ord("A"))) {
    if (mode==0) with (instance) sel=1
    if (mode==1) with (tileholder) sel=1
}
if (keyboard_check(vk_control) && keyboard_check_pressed(ord("C")) || keyboard_check_pressed(ord("X"))) {
    cur=0
    minselx=99999999
    minsely=99999999
    maxselx=-minselx
    maxsely=-minsely
    yes=(keyboard_check_pressed(ord("X")))
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
        if (yes) instance_destroy()
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
        if (yes) instance_destroy()
    }
    if (cur>0) {
        copymode=mode
        copyvec[0,0]=cur
        copyvec[0,1]=minselx
        copyvec[0,2]=minsely
        copyvec[0,3]=maxselx
        copyvec[0,4]=maxsely
    }
}
if (keyboard_check(vk_control) && keyboard_check_pressed(ord("V"))) {
    if (copymode!=mode) show_message("Clipboard currently contains "+pick(copymode+1,"no data.","instance data. To paste, please switch to the instance tab.","tile data. To paste, please switch to the tiles tab."))
    else {
        yes=copyvec[0,0]
        with (TextField) if (active) yes=0
        if (yes) {
            with (instance) sel=0
            with (tileholder) sel=0
            if (keyboard_check(vk_alt)) {
                dx=mouse_x-copyvec[0,1]
                dy=mouse_y-copyvec[0,2]
            } else {
                dx=floorto(mouse_x-copyvec[0,1],gridx)
                dy=floorto(mouse_y-copyvec[0,2],gridy)
            }

            cur=1
            if (mode==0) repeat (copyvec[0,0]) {
                //note: if you have instances copied that would be invisible in the current view, they'l be visible anyway
                o=instance_create(copyvec[cur,2]+dx,copyvec[cur,3]+dy,instance)
                o.obj=copyvec[cur,1]
                o.objname=copyvec[cur,0]
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
                o.sel=1
                select=o
                cur+=1
            }
            if (mode==1) repeat (copyvec[0,0]) {
                o=instance_create(copyvec[cur,2]+dx,copyvec[cur,3]+dy,tileholder)
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
                tile_set_scale(o.tile,copyvec[cur,4],copyvec[cur,5])
                tile_set_blend(o.tile,image_blend)
                tile_set_alpha(o.tile,image_alpha)

                o.sel=1
                selectt=o
                cur+=1
            }
        }
    }
}
