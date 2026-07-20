///unpack_tilesmart_data(background,string)

//format: ii|u,u,u, v,v,v...
//ii = tile mode type, from -6 to 06.
var g,r,u,v;

if (string_char_at(argument1,3)=="|") {
    bg_tilemode[argument0]=real(string_copy(argument1,1,2))

    if (bg_tilemode[argument0]!=6 and bg_tilemode[argument0]!=7) {
        string_token_start(string_delete(argument1,1,3),",")

        g=bg_tilemap[argument0]
        r=pick(bg_tilemode[argument0]-1,2,4,9,16,47)
        u=0 v=0 repeat (r) {
            ds_grid_set(g,u,v,real(string_token_next()))
        u+=1}
        u=0 v=1 repeat (r) {
            ds_grid_set(g,u,v,real(string_token_next()))
        u+=1}
    }
}
