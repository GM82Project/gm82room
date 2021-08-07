var layer,newlayer;

layer=ds_list_find_value(layers,ly_current)

selectt=noone
with (tileholder) sel=0

tile_layer_delete(layer)

ds_list_delete(layers,ly_current)
layersize-=1

ly_current=min(ly_current,layersize-1)

with (tileholder) if (tlayer==layer) {
    instance_destroy()
}

if (layersize==0) add_tile_layer()

change_mode(mode)
