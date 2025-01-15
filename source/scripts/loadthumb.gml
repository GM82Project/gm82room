if (ds_map_exists(thumbmap,argument0))
    return ds_map_find_value(thumbmap,argument0)

var th;th=N_Menu_LoadBitmap(argument0)
ds_map_add(thumbmap,argument0,th)
return th
