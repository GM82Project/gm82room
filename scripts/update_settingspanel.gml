textfield_set("chunk x",chunkleft)
textfield_set("chunk y",chunktop)

textfield_set("chunk w",chunkwidth)
textfield_set("chunk h",chunkheight)

textfield_set("room caption",roomcaption)
textfield_set("room width",roomwidth-roomleft)
textfield_set("room height",roomheight-roomtop)
textfield_set("room speed",roomspeed)

textfield_set("ref alpha",ref_alpha)
textfield_set("ref angle",ref_angle)
if (ref_loaded) textfield_set("ref xscale",ref_w/ref_u) else textfield_set("ref xscale",1)
if (ref_loaded) textfield_set("ref yscale",ref_h/ref_v) else textfield_set("ref yscale",1)

with (Button) if (action="room code") alt=roomcode
