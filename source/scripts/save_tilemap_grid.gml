///save_tilemap_grid(background)
var str,g,u,v,g,r;

str=""

//mode
if (bg_tilemode[argument0]<0) str+=string(bg_tilemode[argument0]) else str+="0"+string(bg_tilemode[argument0])

str+="|"

//no options for pattern and random
if (bg_tilemode[argument0]==7 or bg_tilemode[argument0]==8) return str

//save cells
g=bg_tilemap[argument0]
r=pick(bg_tilemode[tilebgpal]-1,1,2,4,9,16,47)
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
