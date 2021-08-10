buttoncol=global.col_main

createui_main()

createui_object()     //mode 0
createui_tiles()      //mode 1
createui_background() //mode 2
createui_views()      //mode 3
createui_settings()   //mode 4

update_tilepanel()

with (Button) {
    if (object_index==Button && type==1) {
        //checkbox
        w=24
        h=24
    }

    if (extended && !extended_instancedata) alt="Please update gm82save!"

    image_xscale=w
    image_yscale=h
}
