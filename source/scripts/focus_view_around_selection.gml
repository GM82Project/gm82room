with (Controller) {
    if (selection) {
        xgo=selleft+(selwidth div 2)
        ygo=seltop+(selheight div 2)
    } else {
        if (!select) exit

        selwidth=select.bbox_right+1-select.bbox_left
        selheight=select.bbox_bottom+1-select.bbox_top
        xgo=mean(select.bbox_left,select.bbox_right+1)
        ygo=mean(select.bbox_top,select.bbox_bottom+1)
    }

    while ((selwidth)/zoomgo>width-400 or (selheight)/zoomgo>height-200) zoomgo*=1.2
    zoomcenter=1
}
