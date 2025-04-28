i=ds_list_find_index(objects,argument0)
if (i<0) return 0

return get_sprite(objmask[get_object(argument0)])
