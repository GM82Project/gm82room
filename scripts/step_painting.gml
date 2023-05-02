if (keyboard_check(vk_alt)) {
    dx=global.mousex
    dy=global.mousey
} else {
    dx=floorto(global.mousex,gridx)
    dy=floorto(global.mousey,gridy)
}
if (dx!=paintx || dy!=painty || paint=2) {
    paint=1
    paintx=dx
    painty=dy
    yes=1
    if (mode==0) {
        if (objpal!=noone) {
            if (overlap_check) {
                sprite_index=objspr[objpal]
                x=paintx
                y=painty
                reduce_collision()
                with (instance) if (obj=objpal) if (instance_place(x,y,Controller)) {
                    yes=0
                }
                restore_collision()
            }
            if (yes) {
                o=instance_create(dx,dy,instance) get_uid(o)
                o.obj=objpal
                o.objname=ds_list_find_value(objects,o.obj)
                o.depth=objdepth[o.obj]
                o.sprite_index=objspr[o.obj]
                o.sprw=sprite_get_width(o.sprite_index)
                o.sprh=sprite_get_height(o.sprite_index)
                o.sprox=sprite_get_xoffset(o.sprite_index)
                o.sproy=sprite_get_yoffset(o.sprite_index)
                parse_code_into_fields(o,0)
                select=o
                o.sel=1
                o.modified=1
                with (o) update_inspector()
            }
        }
    }
    if (mode==1) {
        if (tilebgpal!=noone) {
            tex=bg_background[tilebgpal]
            if (tile_overlap_check) {
                sprite_index=spr1x1
                image_xscale=curtilew
                image_yscale=curtileh
                x=paintx
                y=painty
                reduce_collision()
                with (tileholder) if (bg=tex) if (instance_place(x,y,Controller)) {
                    yes=0
                }
                restore_collision()
            }
            if (yes) {
                o=instance_create(dx,dy,tileholder) get_uid(o)
                o.bgname=tilebgname
                o.bg=tex
                o.tilew=curtilew
                o.tileh=curtileh
                o.image_xscale=o.tilew
                o.image_yscale=o.tileh
                o.tile=tile_add(tex,curtilex,curtiley,o.tilew,o.tileh,paintx,painty,ly_depth)
                o.tlayer=ly_depth o.depth=ly_depth-0.01
                selectt=o
                o.sel=1
                o.modified=1
                with (o) update_inspector()
            }
        }
    }
    update_instance_memory()
}
if (!direct_mbleft) {
    paint=0
    begin_undo(act_destroy,"drawing "+pick(mode,"instances","tiles"),0)
    if (mode==0) {
        with (instance) if (modified) {add_undo(uid) modified=0}
    }
    if (mode==1) {
        with (tileholder) if (modified) {add_undo(uid) modified=0}
    }
    push_undo()
}
