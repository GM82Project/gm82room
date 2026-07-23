///unpack_tilesmart_data(background,string)

//format: ii|u,u,u(size times),v,v,v(size times),variant u,variant v
//ii = tile mode type, from -9 to 09.
//negative number means it's in manual mode.
var bg,str,g,r,u,v;

bg=argument0
str=argument1

if (string_char_at(str,3)=="|") {
    bg_tilemode[bg]=real(string_copy(str,1,2))

    if (bg_tilemode[bg]!=7 and bg_tilemode[bg]!=8) {
        string_token_start(string_delete(str,1,3),",")

        g=bg_tilemap[bg]
        r=pick(bg_tilemode[bg]-1,1,2,4,9,16,47)
        u=0 v=0 repeat (r) {
            ds_grid_set(g,u,v,real(string_token_next()))
        u+=1}
        u=0 v=1 repeat (r) {
            ds_grid_set(g,u,v,real(string_token_next()))
        u+=1}
    }
    ds_grid_set(g,47,0,real(string_token_next()))
    ds_grid_set(g,47,1,real(string_token_next()))
}
