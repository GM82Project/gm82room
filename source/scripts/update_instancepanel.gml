if (mode==0) {
    with (Instancepanel) {
        if (!open) exit

        oh=h
        h=height-64
        image_yscale=h

        if (h!=oh or updatew) event_user(0)

        w=max(178,min(width-160-160-400,w))
        image_xscale=w
    }

    with (Button) if (action=="ilistscrolup" or action=="ilistscroldown") {w=Instancepanel.w image_xscale=w}
}
