///save_tilemap_grid(background)
var str,g,u,v,g,r,mode;

str=""
mode=bg_tilemode[argument0]

//mode
if (mode<0) str+=string(mode) else str+="0"+string(mode)

str+="|"
mode=abs(mode)

//no options for pattern and random
if (mode==7 or mode==8) return str

//save cells
g=bg_tilemap[argument0]
r=pick(mode-1,1,2,4,9,16,47)
u=0 v=0 repeat (r) {
    b=ds_grid_get(g,u,v)
    if (b==noone) str+="," else str+=string(b)+","
u+=1}
u=0 v=1 repeat (r) {
    b=ds_grid_get(g,u,v)
    if (b==noone) str+="," else str+=string(b)+","
u+=1}

//variant
str+=string(ds_grid_get(g,47,0))+","+string(ds_grid_get(g,47,1))

return str
