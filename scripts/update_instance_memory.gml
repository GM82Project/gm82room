if (mode==0) {
    with (instance) {
        savex=x
        savey=y
        savexscale=image_xscale
        saveyscale=image_yscale
        saveangle=image_angle
        saveblend=image_blend
        savealpha=image_alpha
        savecode=code
    }
}
if (mode==1) {
    with (tileholder) {
        savex=x
        savey=y
        savelayer=tlayer
        savexscale=tilesx
        saveyscale=tilesy
        saveblend=image_blend
        savealpha=image_alpha
    }
}
