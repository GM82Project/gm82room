var newlayer;

if (layersize>=900) show_message("Sorry, there's a hard cap of 900 layers.##How did you get here?")

newlayer=ds_list_find_value(layers,layersize-1)-100
while (ds_list_find_index(layers,newlayer)!=-1) newlayer-=100

ds_list_add(layers,newlayer)
ly_current=layersize

layersize+=1
