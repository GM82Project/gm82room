var coll,checksel;

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
            alarm[0]=1
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
        alarm[0]=1
    }
}

//schedule it for next frame because deactivation and etc blegh
alarm[2]=2
