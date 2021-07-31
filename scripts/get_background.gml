var i;

if (argument0=="") return bgDefault

i=ds_list_find_index(backgrounds,argument0)
if (!bgloaded[i]) {
    bg_tex[i]=background_add(root+"backgrounds\"+argument0+".png",0,0)
    if (bg_tex[i]==-1) bg_tex[i]=bgDefault
    bgloaded[i]=1
}
return bg_tex[i]
