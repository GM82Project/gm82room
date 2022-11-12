var ret;

ret=get_background(argument0)
if (!bghastiles[micro_optimization_bgid]) {
    bghastiles[micro_optimization_bgid]=1
    if (icon_mode) bgsmallicon[micro_optimization_bgid]=background_add(root+"cache\backgrounds\"+argument0+".bmp",0,0)
    else bgsmallicon[micro_optimization_bgid]=bgDefaultBgIcon
}

return ret
