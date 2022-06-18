var l,o,i,j,uaction,lmode,size,tilew,tileh,combo,size;

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
            if (lmode==0) do {
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
                o.order=ds_list_find_value(l,i+10)

                o.sprite_index=objspr[o.obj]
                o.sprw=sprite_get_width(o.sprite_index)
                o.sprh=sprite_get_height(o.sprite_index)
                o.sprox=sprite_get_xoffset(o.sprite_index)
                o.sproy=sprite_get_yoffset(o.sprite_index)
                parse_code_into_fields(o)
                i+=11

                //read fields
                for (j=0;j<objfields[o.obj];j+=1) {
                    o.fields[j,0]=ds_list_find_value(l,i) i+=1
                    if (o.fields[j,0]) {//only read fields if they're set
                        o.fields[j,1]=ds_list_find_value(l,i) i+=1
                        if (objfieldtype[o.obj,j] == "xy") {//only read second part for coordinate type
                            o.fields[j,2]=ds_list_find_value(l,i) i+=1
                        }
                    }
                }
            } until (i>=size)

            if (lmode==1) repeat (size/14) {
                o=instance_create(ds_list_find_value(l,i+3),ds_list_find_value(l,i+4),tileholder)
                set_uid(o,ds_list_find_value(l,i))
                o.bg=ds_list_find_value(l,i+1)
                o.bgname=ds_list_find_value(l,i+2)
                o.tlayer=ds_list_find_value(l,i+5) o.depth=o.tlayer-0.01
                o.tilew=ds_list_find_value(l,i+8)
                o.tileh=ds_list_find_value(l,i+9)
                o.tile=tile_add(o.bg,ds_list_find_value(l,i+6),ds_list_find_value(l,i+7),o.tilew,o.tileh,o.x,o.y,o.tlayer)
                o.tilesx=ds_list_find_value(l,i+10)
                o.tilesy=ds_list_find_value(l,i+11)
                o.image_blend=ds_list_find_value(l,i+12)
                o.image_alpha=ds_list_find_value(l,i+13)
                o.order=ds_list_find_value(l,i+14)

                o.image_xscale=o.tilesx*o.tilew
                o.image_yscale=o.tilesy*o.tileh

                tile_set_scale(o.tile,o.tilesx,o.tilesy)
                tile_set_blend(o.tile,o.image_blend)
                tile_set_alpha(o.tile,o.image_alpha)
                i+=15
            }
        }break
        case act_change: {
            if (lmode==0) do {
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

                //read fields
                for (j=0;j<objfields[o.obj];j+=1) {
                    o.fields[j,0]=ds_list_find_value(l,i) i+=1
                    if (o.fields[j,0]) {//only read fields if they're set
                        o.fields[j,1]=ds_list_find_value(l,i) i+=1
                        if (objfieldtype[o.obj,j] == "xy") {//only read second part for coordinate type
                            o.fields[j,2]=ds_list_find_value(l,i) i+=1
                        }
                    }
                }
            } until (i>=size)

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
        case act_alchemy: {
            var name;name=ds_list_find_value(l,i)
            var obj;obj=ds_list_find_value(l,i+1)
            i+=2
            repeat ((size-2)) {
                o=ds_map_find_value(uidmap,ds_list_find_value(l,i))
                o.obj=obj
                o.objname=name

                o.depth=objdepth[o.obj]
                o.sprite_index=objspr[o.obj]
                o.sprw=sprite_get_width(o.sprite_index)
                o.sprh=sprite_get_height(o.sprite_index)
                o.sprox=sprite_get_xoffset(o.sprite_index)
                o.sproy=sprite_get_yoffset(o.sprite_index)

                i+=1
            }
        }break
    }

    total_undo_size-=ds_list_find_value(l,ds_list_size(l)-1)

    ds_list_destroy(l)

    update_undo_button()

    update_instance_memory()

    if (mode==0) with (select) update_inspector()
    if (mode==1) with (selectt) update_inspector()

    change_mode(mode)
    if (combo) pop_undo()
}
