o=instance_create(argument0,argument1,instance) get_uid(o)
o.obj=obj
o.objname=ds_list_find_value(objects,o.obj)
o.depth=objdepth[o.obj]
o.sprite_index=objspr[o.obj]
o.sprw=sprite_get_width(o.sprite_index)
o.sprh=sprite_get_height(o.sprite_index)
o.sprox=sprite_get_xoffset(o.sprite_index)
o.sproy=sprite_get_yoffset(o.sprite_index)
parse_code_into_fields(o,0)
o.sel=1
o.modified=1
o.image_xscale=gridx/o.sprw
o.image_yscale=gridy/o.sprh
