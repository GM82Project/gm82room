var newlayer;

if (layersize>=900) show_message("Sorry, there's a hard cap of 900 layers.##How did you get here?")

if (layersize==0) newlayer=1000000
else newlayer=ds_list_find_value(layers,layersize-1)-100
while (ds_list_find_index(layers,newlayer)!=-1) newlayer-=100

ds_list_add(layers,newlayer)
ly_current=layersize
ly_depth=ds_list_find_value(layers,ly_current)

layersize+=1
