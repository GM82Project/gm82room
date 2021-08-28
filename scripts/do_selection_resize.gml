var sx,sy;

sx=chunkwidth/Controller.storex
sy=chunkheight/Controller.storey

x=chunkleft-grabx*sx
y=chunktop-graby*sy

image_xscale=grabw*sx
image_yscale=grabh*sy

if (!mouse_check_direct(mb_left) || !mouse_check_button(mb_left)) {
    selresize=0
    do_change_undo("resizing "+pick(mode,"instances","tiles","","","chunk"),0)
}
