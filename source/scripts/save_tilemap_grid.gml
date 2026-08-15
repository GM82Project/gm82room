///save_tilemap_grid(background)
var str,g,u,v,g,r,md;

str=""
md=bg_tilemode[argument0]

//mode
if (md<0) str+=string(md) else str+="0"+string(md)

str+="|"
md=abs(md)

//no options for pattern and random
if (md==7 or md==8) return str

//save cells
g=bg_tilemap[argument0]
r=pick(md-1,1,2,4,9,16,47)
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
