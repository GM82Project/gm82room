var layer,newlayer;

layer=ds_list_find_value(layers,ly_current)

add_tile_layer()

newlayer=ds_list_find_value(layers,layersize-1)

selectt=noone
with (tileholder) sel=0

with (tileholder) if (tlayer==layer) {
    o=instance_copy(0)
    o.tlayer=newlayer
    o.tile=tile_add(bg,tile_get_left(tile),tile_get_top(tile),tilew,tileh,x,y,newlayer)
    tile_set_blend(o.tile,image_blend)
    tile_set_alpha(o.tile,image_alpha)
    tile_set_scale(o.tile,tilesx,tilesy)
}

change_mode(mode)
update_tilepanel()
