var sx,sy;

if (mode==4) {
    sx=chunkwidth/Controller.storex
    sy=chunkheight/Controller.storey

    x=chunkleft-grabx*sx
    y=chunktop-graby*sy
} else {
    sx=selwidth/Controller.storex
    sy=selheight/Controller.storey

    x=selleft-grabx*sx
    y=seltop-graby*sy
}

image_xscale=grabw*sx
image_yscale=grabh*sy

event_user(1)

if (!mouse_check_direct(mb_left) || !mouse_check_button(mb_left)) {
    selresize=0
    x=round(x)
    y=round(y)
    do_change_undo("resizing "+pick(mode,"instances","tiles","","","chunk"),0)
}
