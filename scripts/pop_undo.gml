var l,o,i,uaction,lmode,size,tilew,tileh,combo,size;

size=ds_list_size(undostack)
if (size) {
    l=ds_list_find_value(undostack,size-1)
    ds_list_delete(undostack,size-1)

    uaction=ds_list_find_value(l,0)
    combo=ds_list_find_value(l,2)
    lmode=ds_list_find_value(l,3)
    size=ds_list_size(l)-5
    i=4

    instance_activate_all()

    switch (uaction) {
        case act_destroy: {
            repeat (size) {
                with (ds_map_find_value(uidmap,ds_list_find_value(l,i))) instance_destroy()
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
                tile_set_position(o.tile,o.x,o.y)
                tile_set_depth(o.tile,o.tlayer)
                tile_set_scale(o.tile,o.tilesx,o.tilesy)
                tile_set_blend(o.tile,o.image_blend)
                tile_set_alpha(o.tile,o.image_alpha)
                i+=8
            }
        }break
        case act_global: {
            variable_global_set(ds_list_find_value(l,i),ds_list_find_value(l,i+1))
        }break
        case act_globalvec: {
            repeat (size/3) {
                variable_global_array_set(ds_list_find_value(l,i),ds_list_find_value(l,i+1),ds_list_find_value(l,i+2))
                i+=3
            }
        }break
    }

    total_undo_size-=ds_list_find_value(l,ds_list_size(l)-1)

    ds_list_destroy(l)

    update_undo_button()

    update_instance_memory()

    change_mode(mode)
    if (combo) pop_undo()
}
