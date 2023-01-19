var ret;

ret=get_background(argument0)
if (!bghastiles[micro_optimization_bgid]) {
    bghastiles[micro_optimization_bgid]=1
    fn=root+"cache\backgrounds\"+argument0+".bmp"
    if (icon_mode && file_exists(fn)) bgsmallicon[micro_optimization_bgid]=background_add(fn,0,0)
    else bgsmallicon[micro_optimization_bgid]=bgDefaultBgIcon
}

return ret
