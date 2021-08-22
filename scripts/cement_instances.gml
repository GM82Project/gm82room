var coll,checksel;

checksel=!!num_selected()

//ok now let's play a game of how can i stop game maker from killing itself
with (instance) {
    xprevious=x
    yprevious=y
    memxsc=image_xscale
    memysc=image_yscale
    if (obj!=objpal || sel!=checksel || code!="") {x=-max_int y=-max_int}
}
instance_deactivate_region(max_int-10000,max_int-10000,20000,20000,1,1)

begin_undo(act_create,"gluing instances",0)
repeat (8) {
    with (instance) {
        coll=instance_place(x+1,y,instance)
        if (coll) if (bbox_right<coll.bbox_left && sign(image_xscale)=sign(coll.image_xscale) && y=coll.y && image_yscale=coll.image_yscale) {
            image_xscale+=coll.image_xscale
            with (coll) {image_xscale=memxsc image_yscale=memysc add_undo_instance() instance_destroy()}
        }
    }
    with (instance) {
        coll=instance_place(x,y+1,instance)
        if (coll) if (bbox_bottom<coll.bbox_top && sign(image_yscale)=sign(coll.image_yscale) && x=coll.x && image_xscale=coll.image_xscale) {
            image_yscale+=coll.image_yscale
            with (coll) {image_xscale=memxsc image_yscale=memysc add_undo_instance() instance_destroy()}
        }
    }
}
push_undo()

change_mode(mode)

with (instance) {x=xprevious y=yprevious}

do_change_undo("",1)
