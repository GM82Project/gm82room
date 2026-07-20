//fills the tilemap with a copy of the background
var g,w,i,u,v;

if (tilebgpal!=noone) {
    g=bg_tilemap[tilebgpal]
    if (ds_grid_get_max(g,0,0,46,1)!=noone)
        if (!show_question("This tileset already has mappings.##Are you sure you want to overwrite with a copy fill?"))
            exit

    bgw=background_get_width(bg_background[tilebgpal])
    bgh=background_get_height(bg_background[tilebgpal])

    w=pick(bg_tilemode[tilebgpal]-1,1,2,3,4,7)
    i=0 repeat (pick(bg_tilemode[tilebgpal]-1,2,4,9,16,47)) {
        o=i if (o>=27) o+=1 if (o>=36) o+=1
        u=o mod w
        v=o div w
        if (u*gx<bgw and v*gy<bgh) {
            ds_grid_set(g,i,0,u*gx)
            ds_grid_set(g,i,1,v*gy)
        }
    i+=1}
    check_tilemap_complete()
}
