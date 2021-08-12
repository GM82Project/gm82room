var dy,loaded,i;

with (Controller) {
    objpal=argument0

    loaded=0
    for (i=0;i<objpal;i+=1) if (objloaded[i]) loaded+=1

    dy=40*(loaded div 4)+20
    palettescrollgo=clamp((height-120-136)/2-dy,-(palettesize+1)*32+(height-120-136),0)
}
