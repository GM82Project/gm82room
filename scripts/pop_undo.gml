var l,o,i,uaction,lmode,size,tilew,tileh;

if (!ds_stack_empty(undostack)) {
    l=ds_stack_pop(undostack)
    with (Button) if (action="undo") {
        if (ds_stack_empty(undostack)) alt="Undo"
        else alt="Undo "+ds_list_find_value(ds_stack_top(undostack),0)+" ("+string(ds_stack_size(undostack))+")"
    }

    uaction=ds_list_find_value(l,1)
    lmode=ds_list_find_value(l,2)
    size=ds_list_size(l)-3
    i=3

    instance_activate_all()

    switch (uaction) {
        case act_destroy: {
            repeat (size) {
                with (ds_list_find_value(l,i)) instance_destroy()
                i+=1
            }
        }break
        case act_create: {
            if (lmode==0) repeat (size/10) {
                o=instance_create(ds_list_find_value(l,i+2),ds_list_find_value(l,i+3),instance)
                set_uid(o,ds_list_find_value(l,i))
                o.obj=ds_list_find_value(l,i+1)
                o.objname=ds_list_find_value(objects,o.obj)
                o.image_xscale=ds_list_find_value(l,i+4)
                o.image_yscale=ds_list_find_value(l,i+5)
                o.image_angle=ds_list_find_value(l,i+6)
                o.image_blend=ds_list_find_value(l,i+7)
                o.image_alpha=ds_list_find_value(l,i+8)
                o.code=ds_list_find_value(l,i+9)
                o.sprite_index=objspr[o.obj]
                o.sprw=sprite_get_width(o.sprite_index)
                o.sprh=sprite_get_height(o.sprite_index)
                o.sprox=sprite_get_xoffset(o.sprite_index)
                o.sproy=sprite_get_yoffset(o.sprite_index)
                i+=10
            }
            if (lmode==1) repeat (size/13) {
                o=instance_create(ds_list_find_value(l,i+2),ds_list_find_value(l,i+3),tileholder)
                set_uid(o,ds_list_find_value(l,i))
                o.bg=ds_list_find_value(l,i+1)
                o.bgname=ds_list_find_value(backgrounds,o.bg)
                o.tlayer=ds_list_find_value(l,i+4) o.depth=o.tlayer-0.01
                tilew=ds_list_find_value(l,i+7)
                tileh=ds_list_find_value(l,i+8)
                o.tile=tile_add(o.bg,ds_list_find_value(l,i+5),ds_list_find_value(l,i+6),tilew,tileh,o.x,o.y,o.tlayer)
                o.tilesx=ds_list_find_value(l,i+9)
                o.tilesy=ds_list_find_value(l,i+10)
                o.image_xscale=o.tilesx*tilew
                o.image_yscale=o.tilesy*tileh
                o.image_blend=ds_list_find_value(l,i+11)
                o.image_alpha=ds_list_find_value(l,i+12)
                tile_set_scale(o.tile,o.tilesx,o.tilesy)
                tile_set_blend(o.tile,o.image_blend)
                tile_set_alpha(o.tile,o.image_alpha)
                i+=13
            }
        }break
        case act_change: {
            if (lmode==0) repeat (size/9) {
                o=ds_map_find_value(uidmap,ds_list_find_value(l,i))
                o.x=ds_list_find_value(l,i+1)
                o.y=ds_list_find_value(l,i+2)
                o.image_xscale=ds_list_find_value(l,i+3)
                o.image_yscale=ds_list_find_value(l,i+4)
                o.image_angle=ds_list_find_value(l,i+5)
                o.image_blend=ds_list_find_value(l,i+6)
                o.image_alpha=ds_list_find_value(l,i+7)
                o.code=ds_list_find_value(l,i+8)
                i+=9
            }
            if (lmode==1) repeat (size/8) {
                o=ds_map_find_value(uidmap,ds_list_find_value(l,i))
                o.x=ds_list_find_value(l,i+1)
                o.y=ds_list_find_value(l,i+2)
                o.tlayer=ds_list_find_value(l,i+3) o.depth=o.tlayer-0.01
                o.tilesx=ds_list_find_value(l,i+4)
                o.tilesy=ds_list_find_value(l,i+5)
                o.image_xscale=o.tilesx*tile_get_width(o.tile)
                o.image_yscale=o.tilesy*tile_get_height(o.tile)
                o.image_blend=ds_list_find_value(l,i+6)
                o.image_alpha=ds_list_find_value(l,i+7)
                tile_set_scale(o.tile,o.tilesx,o.tilesy)
                tile_set_blend(o.tile,o.image_blend)
                tile_set_alpha(o.tile,o.image_alpha)
                i+=8
            }
        }break
        case act_global: {
            variable_global_set(ds_list_find_value(l,i),ds_list_find_value(l,i+1))
        }break
    }

    ds_list_destroy(l)

    update_instance_memory()

    change_mode(mode)
}
