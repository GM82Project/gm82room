textfield_set("bgcol",backgroundcolor)
textfield_set("bg name",bg_source[bg_current])
textfield_set("bg xpos",bg_xoffset[bg_current])
textfield_set("bg ypos",bg_yoffset[bg_current])
textfield_set("bg hsp",bg_hspeed[bg_current])
textfield_set("bg vsp",bg_vspeed[bg_current])
textfield_set("bg xsc",bg_xscale[bg_current])
textfield_set("bg ysc",bg_yscale[bg_current])
textfield_set("bg blend",bg_blend[bg_current])
textfield_set("bg alpha",bg_alpha[bg_current])

with (Button) if (action=="bg xsc" || action=="bg ysc") gray=bg_stretch[bg_current]
