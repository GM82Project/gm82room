///update_instance_memory([inst/tile])
if (argument_count) with (argument[0]) {
    if (object_index==instance) {
        savex=x
        savey=y
        savez=depth
        savexscale=image_xscale
        saveyscale=image_yscale
        saveangle=image_angle
        saveblend=image_blend
        savealpha=image_alpha
        savecode=code
    }
    if (object_index==tileholder) {
        savex=x
        savey=y
        savelayer=tlayer
        savexscale=tilesx
        saveyscale=tilesy
        saveblend=image_blend
        savealpha=image_alpha
    }
    exit
}

with (instance) {
    savex=x
    savey=y
    savez=depth
    savexscale=image_xscale
    saveyscale=image_yscale
    saveangle=image_angle
    saveblend=image_blend
    savealpha=image_alpha
    savecode=code
}
with (tileholder) {
    savex=x
    savey=y
    savelayer=tlayer
    savexscale=tilesx
    saveyscale=tilesy
    saveblend=image_blend
    savealpha=image_alpha
}
