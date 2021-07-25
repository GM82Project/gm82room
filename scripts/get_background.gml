var i;

//with (Controller) {
    i=ds_list_find_index(backgrounds,argument0)
    if (!bgloaded[i]) {
        bgtex[i]=background_add(root+"backgrounds\"+argument0+".png",0,0)
        bgloaded[i]=1
    }
    return bgtex[i]
//}
