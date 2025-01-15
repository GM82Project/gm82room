var newlayer;

if (layersize>=900) show_message("Sorry, there's a hard cap of 900 layers.##How did you get here?")

if (layersize==0) newlayer=1000
else newlayer=ds_list_find_value(layers,layersize-1)-100
while (ds_list_find_index(layers,newlayer)!=-1) newlayer-=100

ds_list_add(layers,newlayer)

ds_list_sort(layers,1)
layersize=ds_list_size(layers)

ly_current=ds_list_find_index(layers,newlayer)

ly_depth=newlayer
