var error,count,dx,dy,dw,dh,l,t,r,b,lm,rm,tm,bm,o;

error=""
count=0

with (instance) if (sel and image_angle==0) {
    count+=ceil(sprite_width/gridx)*ceil(sprite_height/gridy)
}

if (count>1000)
    if (!show_question("WARNING: your current selection with the set grid size ("+string(gridx)+","+string(gridy)+") will cause "+string(count)+" new instances to be created.##Are you sure you want to continue?"))
        exit

begin_undo(act_create,"",0)
with (instance) if (sel) {
    if (image_angle!=0) error+="instance "+uid+" at ("+string(x)+","+string(y)+") is rotated and can't be gigaknifed#"
    else {
        //split by grid

        dx=x
        dy=y
        dw=sprite_width
        dh=sprite_height

        l=dx
        t=dy
        r=l+dw
        b=t+dh

        lm=ceilto(l,gridx)
        tm=ceilto(t,gridy)
        rm=floorto(r,gridx)
        bm=floorto(b,gridy)

        short=floorto(t,gridy)==floorto(b,gridy)
        thin=floorto(r,gridx)==floorto(l,gridx)

        if (short && thin) {
            //too small to gigaknife
            continue
        } else if (short) {
            //3-slice a wide box

            //left
            o=create_french_fry(l,t)
            o.image_yscale=(b-t)/o.sprh

        } else if (thin) {
            //we have ourselves tall man
        } else if (!short && !thin) {
            //we 9-slice dat shizz
            if (dx mod gridx and dy mod gridy) {
                //top left
                create_french_fry(l,t)
            }
            if ((dx+dw) mod gridx and dy mod gridy) {
                //top right
                o=create_french_fry(rm,t)
                o.image_xscale=(r-rm)/o.sprw
            }
            if (dx mod gridx and (dy+dh) mod gridy) {
                //bottom left
                o=create_french_fry(l,bm)
                o.image_yscale=(b-bm)/o.sprh
            }
            if ((dx+dw) mod gridx and (dy+dh) mod gridy) {
                //bottom right
                o=create_french_fry(rm,bm)
                o.image_xscale=(r-rm)/o.sprw
                o.image_yscale=(b-bm)/o.sprh
            }

            if (dx mod gridx) {
                //left
                v=tm repeat ((bm-tm) div gridy) {
                    create_french_fry(l,v)
                v+=gridy}
            }
            if ((dx+dw) mod gridx) {
                //right
                v=tm repeat ((bm-tm) div gridy) {
                    o=create_french_fry(rm,v)
                    o.image_xscale=(r-rm)/o.sprw
                v+=gridy}
            }
            if (dy mod gridy) {
                //top
                u=lm repeat ((rm-lm) div gridx) {
                    create_french_fry(u,t)
                u+=gridx}
            }
            if ((dy+dh) mod gridy) {
                //bottom
                u=lm repeat ((rm-lm) div gridx) {
                    o=create_french_fry(u,bm)
                    o.image_yscale=(b-bm)/o.sprh
                u+=gridx}
            }

            //middle bit
            v=tm repeat ((bm-tm) div gridy) {
                u=lm repeat ((rm-lm) div gridx) {
                    create_french_fry(u,v)
                u+=gridx}
            v+=gridy}
        }

        add_undo_instance()
        instance_destroy()
    }
}
push_undo()

begin_undo(act_destroy,"Subdivide instances",1)
    with (instance) if (modified) {add_undo(uid) modified=0 sel=1}
push_undo()

change_mode(mode)

if (error!="") show_message("There were errors using the Gigaknife tool:##"+error)
