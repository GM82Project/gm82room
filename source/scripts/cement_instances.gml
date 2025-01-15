var coll,checksel,deact,dcur;

dcur=0

checksel=!!num_selected()

//ok now let's play a game of how can i stop game maker from killing itself
//spoilers: i couldn't
with (instance) {
    xprevious=x
    yprevious=y
    memxsc=image_xscale
    memysc=image_yscale
    if (obj==objpal) {
        if (sel!=checksel || code!="") {
            //we don't want to glue unselected instances or instances that have code
            deact[dcur]=id dcur+=1
        } else {
            //remove duplicates first
            with (instance) if (obj==objpal && id<other.id)
                if (
                    x==other.x
                 && y==other.y
                 && image_xscale==other.image_xscale
                 && image_yscale==other.image_yscale
                 && image_angle==other.image_angle
                 && image_blend==other.image_blend
                 && image_alpha==other.image_alpha
                 && code==other.code
                ) {
                    instance_destroy()
                }
        }
    } else {
        //deactivate unrelated
        deact[dcur]=id dcur+=1
    }
}

repeat (dcur) {
    dcur-=1
    instance_deactivate_object(deact[dcur])
}

begin_undo(act_create,"",0)
repeat (8) {
    with (instance) {
        coll=instance_place(x+1,y,instance)
        if (coll) if (bbox_right<coll.bbox_left && sign(image_xscale)=sign(coll.image_xscale) && y=coll.y && image_yscale=coll.image_yscale) {
            image_xscale+=coll.image_xscale
            with (coll) {image_xscale=memxsc image_yscale=memysc add_undo_instance() instance_destroy()}
        }
    }
}
repeat (8) {
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

undotype="gluing instances"
undocombo=1
do_change_undo()
