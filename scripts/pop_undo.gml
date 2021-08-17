var l,o,i,action,lmode,size,tilew,tileh;

if (!ds_stack_empty(undostack)) {
    l=ds_stack_pop(undostack)

    action=ds_list_find_value(l,0)
    lmode=ds_list_find_value(l,1)
    size=ds_list_size(l)-2
    i=2

    instance_activate_all()

    switch (action) {
        case act_destroy: {
            repeat (size) {
                with (ds_list_find_value(l,i)) instance_destroy()
                i+=1
            }
        }break
        case act_create: {
            if (lmode==0) repeat (size/9) {
                o=instance_create(ds_list_find_value(l,i+1),ds_list_find_value(l,i+2),instance)
                o.obj=ds_list_find_value(l,i)
                o.objname=ds_list_find_value(objects,o.obj)
                o.image_xscale=ds_list_find_value(l,i+3)
                o.image_yscale=ds_list_find_value(l,i+4)
                o.image_angle=ds_list_find_value(l,i+5)
                o.image_blend=ds_list_find_value(l,i+6)
                o.image_alpha=ds_list_find_value(l,i+7)
                o.code=ds_list_find_value(l,i+8)
                o.sprite_index=objspr[o.obj]
                o.sprw=sprite_get_width(o.sprite_index)
                o.sprh=sprite_get_height(o.sprite_index)
                o.sprox=sprite_get_xoffset(o.sprite_index)
                o.sproy=sprite_get_yoffset(o.sprite_index)
                i+=9
            }
            if (lmode==1) repeat (size/12) {
                o=instance_create(ds_list_find_value(l,i+1),ds_list_find_value(l,i+2),tileholder)
                o.bg=ds_list_find_value(l,i)
                o.bgname=ds_list_find_value(backgrounds,o.bg)
                o.tlayer=ds_list_find_value(l,i+3)
                tilew=ds_list_find_value(l,i+6)
                tileh=ds_list_find_value(l,i+7)
                o.tile=tile_add(o.bg,ds_list_find_value(l,i+4),ds_list_find_value(l,i+5),tilew,tileh,o.x,o.y,o.tlayer)
                o.tilesx=ds_list_find_value(l,i+8)
                o.tilesy=ds_list_find_value(l,i+9)
                o.image_xscale=o.tilesx*tilew
                o.image_yscale=o.tilesy*tileh
                o.image_blend=ds_list_find_value(l,i+10)
                o.image_alpha=ds_list_find_value(l,i+11)
                tile_set_scale(o.tile,o.tilesx,o.tilesy)
                tile_set_blend(o.tile,o.image_blend)
                tile_set_alpha(o.tile,o.image_alpha)
                i+=12
            }
        }break
    }

    ds_list_destroy(l)

    change_mode(mode)
}
