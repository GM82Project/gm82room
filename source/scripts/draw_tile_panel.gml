draw_button_ext(x,y,w,h,1,global.col_main)
draw_button_ext(x+w-36,y+4,32,32,!grab,global.col_main)
draw_sprite(sprMenuButtons,36,x+w-20,y+20)
draw_button_ext(x+4,y+36,w-8,h-36-4,0,global.col_main)

if (tilebgpal!=noone) {
    tex=bg_background[tilebgpal]
    bgw=background_get_width(tex)
    bgh=background_get_height(tex)
    bgname=ds_list_find_value(backgrounds,tilebgpal)
    d3d_set_viewport(x+8,y+32+8,w-16,h-32-16)
    d3d_set_projection_ortho(round(xgo-(w-16)*z/2),round(ygo-(h-32-16)*z/2),(w-16)*z,(h-32-16)*z,0)
    texture_set_interpolation(0)
    draw_set_color(global.col_text)
    draw_set_valign(1)
    draw_text(4,-16,bgname)
    draw_text(4,bgh+16,string(bgw)+"x"+string(bgh))
    draw_set_valign(0)
    draw_set_color($ffffff)
    draw_background(tex,0,0)

    //grid
    draw_set_blend_mode_ext(10,1)
    x1=ox
    y1=oy
    x2=background_get_width(tex)
    y2=background_get_height(tex)
    if (sx || sy || ox || oy) {
        for (u=x1;u<=x2-gx;u+=gx+sx) for (v=y1;v<=y2-gy;v+=gy+sy) {
            draw_rectangle(u-0.5,v-0.5,u+gx-0.5,v+gy-0.5,1)
        }
    } else {
        draw_primitive_begin(pr_linelist)
        if (tilepickgrid) {
            vc=0
            for (i=x1;i<=x2;i+=gx) {draw_vertex(i-0.5,y1-0.5) draw_vertex(i-0.5,y2-0.5) vc+=2 if (vc>998) {vc=0 draw_primitive_end() draw_primitive_begin(pr_linelist)}}
            for (i=y1;i<=y2;i+=gy) {draw_vertex(x1-0.5,i-0.5) draw_vertex(x2-0.5,i-0.5) vc+=2 if (vc>998) {vc=0 draw_primitive_end() draw_primitive_begin(pr_linelist)}}
        }
        draw_primitive_end()
    }
    draw_set_blend_mode(0)

    //draw tilemap ui
    texture_set_interpolation(0)

    draw_seta(1,1)
    dx=0 dy=-64 draw_button_ext(dx,dy,80,32,bg_tilemode[tilebgpal],global.col_main) draw_text(dx+40,dy+16,"Manual")
    dx=88 dy=-64 draw_button_ext(dx,dy,80,32,!bg_tilemode[tilebgpal],global.col_main) draw_text(dx+40,dy+16,"Smart")
    draw_seta(0,0)

    with (TextField) if (tagmode==-2) button_draw()

    draw_seta(0,1)
    dx=-112 dy=0
    draw_text(dx,dy-16,"Grid")
    dy=64
    draw_text(dx,dy-16,"Offset")
    dy=128
    draw_text(dx,dy-16,"Separation")

    m=bg_tilemode[tilebgpal]
    if (m) {
        //draw autotiler ui

        texture_set_interpolation(0)
        mw=max(176,bgw+32,string_width(bgname)+8)
        draw_set_halign(0)
        draw_text(mw+4,-16,tile_mode_name(m))
        draw_text(mw+4,-120,"Smart tiler mode")
        draw_set_halign(1)

        dy=-104
        dx=mw     draw_button_ext(dx,dy,40,32,m!=1,global.col_main) draw_text(dx+20,dy+16,"1")
        dx=mw+48  draw_button_ext(dx,dy,40,32,m!=2,global.col_main) draw_text(dx+20,dy+16,"2")
        dx=mw+96  draw_button_ext(dx,dy,40,32,m!=3,global.col_main) draw_text(dx+20,dy+16,"4")
        dx=mw+144 draw_button_ext(dx,dy,40,32,m!=4,global.col_main) draw_text(dx+20,dy+16,"9")
        dy=-64
        dx=mw     draw_button_ext(dx,dy,40,32,m!=5,global.col_main) draw_text(dx+20,dy+16,"16")
        dx=mw+48  draw_button_ext(dx,dy,40,32,m!=6,global.col_main) draw_text(dx+20,dy+16,"47")
        dx=mw+96  draw_button_ext(dx,dy,40,32,m!=7,global.col_main) draw_text(dx+20,dy+16,"R")
        dx=mw+144 draw_button_ext(dx,dy,40,32,m!=8,global.col_main) draw_text(dx+20,dy+16,"?")


        if (bg_tilemode[tilebgpal]!=7 and bg_tilemode[tilebgpal]!=8) {
            ref=pick(bg_tilemode[tilebgpal]-1,bgTiler1,bgTiler2,bgTiler4,bgTiler9,bgTiler16,bgTiler47)
            xsc=gx/32
            ysc=gy/32
            texture_set_interpolation(1)
            draw_background_ext(ref,mw,0,xsc,ysc,0,$ffffff,1)
            texture_set_interpolation(0)

            //draw tile mappings
            size=pick(bg_tilemode[tilebgpal]-1,1,1,2,3,4,7)
            i=0 repeat (pick(bg_tilemode[tilebgpal]-1,1,2,4,9,16,47)) {
                o=i if (o>=27) o+=1 if (o>=36) o+=1
                u=o mod size
                v=o div size
                targx=ds_grid_get(bg_tilemap[tilebgpal],i,0)
                targy=ds_grid_get(bg_tilemap[tilebgpal],i,1)
                if (targx!=noone and targy!=noone)
                    draw_background_part(tex,targx,targy,gx,gy,mw+u*gx,v*gx)
            i+=1}


            if (hide_smartmap) {
                draw_background_ext(ref,mw,0,xsc,ysc,0,$ffffff,1)
                //draw template over tiles
            } else if (point_in_rectangle(mouse_wx,mouse_wy,x+8,y+32+8,x+8+w-8-8,y+32+8+h-32-16)) {
                clickx=(mouse_wx-(x+8))*z+xgo-(w-16)*z/2
                clicky=(mouse_wy-(y+40))*z+ygo-(h-32-16)*z/2

                //draw variant
                dy=background_get_height(ref)*ysc+32

                vu=ds_grid_get(bg_tilemap[tilebgpal],47,0)
                vv=ds_grid_get(bg_tilemap[tilebgpal],47,1)
                if (vu>1 or vv>1) {
                    vw=bgw/vu
                    vh=bgh/vv
                    v=0 repeat (vv) {
                        u=0 repeat (vu) {
                            if (u or v) draw_rect(u*vw-0.5,v*vh-0.5,vw,vh,$808080,0.75)
                        u+=1}
                    v+=1}
                }

                if (point_in_rectangle(clickx,clicky,mw,dy+64,mw+64,dy+128)) {
                    draw_set_color_sel()
                    vu=ds_grid_get(bg_tilemap[tilebgpal],47,0)
                    vv=ds_grid_get(bg_tilemap[tilebgpal],47,1)
                    vw=bgw/vu
                    vh=bgh/vv
                    v=0 repeat (vv) {
                        u=0 repeat (vu) {
                            draw_rectangle(u*vw-0.5,v*vh-0.5,(u+1)*vw-0.5,(v+1)*vh-0.5,1)
                        u+=1}
                    v+=1}
                    draw_set_color($ffffff)
                } else {
                    if (vu>1 or vv>1) {
                        draw_rectangle(0-0.5,0-0.5,vw-0.5,vh-0.5,1)
                    }

                    //draw current mapping
                    draw_set_color_sel()
                    draw_rectangle(mw+atcx*gx-0.5,atcy*gy-0.5,mw+(atcx+1)*gx-0.5,(atcy+1)*gy-0.5,1)
                    index=atcx+atcy*pick(bg_tilemode[tilebgpal]-1,1,1,2,3,4,7)
                    if (index>27) index-=1 if (index>35) index-=1
                    targx=ds_grid_get(bg_tilemap[tilebgpal],index,0)
                    targy=ds_grid_get(bg_tilemap[tilebgpal],index,1)
                    if (targx!=noone and targy!=noone) {
                        draw_rectangle(targx-0.5,targy-0.5,targx+gx-0.5,targy+gy-0.5,1)
                        draw_arrow(mw+(atcx+0.5)*gx-0.5,(atcy+0.5)*gy-0.5,targx+0.5*gx-0.5,targy+0.5*gy-0.5,8)
                    } else {
                        if (point_in_rectangle(clickx,clicky,0,0,background_get_width(tex),background_get_height(tex)))
                            draw_arrow(mw+(atcx+0.5)*gx-0.5,(atcy+0.5)*gy-0.5,clickx-0.5,clicky-0.5,8)
                    }
                    draw_set_color($ffffff)
                }
            }

            dy=background_get_height(ref)*ysc+32
            if (bg_tilemode[tilebgpal]!=1) {
                dx=mw    draw_button_ext(dx,dy,64,32,!hide_smartmap,global.col_main) draw_text(dx+32,dy+16,"Hide")
                dx=mw+72 draw_button_ext(dx,dy,64,32,1,global.col_main) draw_text(dx+32,dy+16,"Fill")
                dx=mw+144 draw_button_ext(dx,dy,64,32,1,global.col_main) draw_text(dx+32,dy+16,"Clear")
            }
            draw_set_halign(0)
            if (tilemap_complete==0) draw_text(mw+4,dy-16,"Click on the background to map tiles")
            if (tilemap_complete==-1) draw_text(mw+4,dy-16,"Error: tiles mapped outside variant area")

            draw_text(mw+4,dy+48,"Variant mode")
            draw_background(bgVariant,mw,dy+64)
            u=ds_grid_get(bg_tilemap[tilebgpal],47,0)
            v=ds_grid_get(bg_tilemap[tilebgpal],47,1)
            draw_rectangle(mw-0.5,dy+64-0.5,mw+16*u-0.5,dy+64+16*v-0.5,1)
        }
    } else {
        //normal mode rectangle
        draw_set_color_sel()
        draw_rectangle(curtilex-0.5,curtiley-0.5,curtilex+curtilew-0.5,curtiley+curtileh-0.5,1)
        draw_set_color($ffffff)
    }

    draw_reset()

    with (TextField) if (focus and alt!="" and tagmode==-2) drawtooltip_tilepanel(alt)

    texture_set_interpolation(1)

    end_trim()
}
