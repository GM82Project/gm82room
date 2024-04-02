var count;
count=0
if (mode==0) with (instance) count+=!!sel
if (mode==1) with (tileholder) count+=!!sel
if (mode==5) count=ds_list_size(path_sel)
return count
