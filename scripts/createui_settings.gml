//settings mode
i=instance_create(8,128,TextField)
i.action="room caption"
i.w=160-16
i.tagmode=4
i.type=4
textfield_set("room caption",roomcaption)

i=instance_create(8,200,TextField)
i.action="room width"
i.alt="Width"
i.w=72
i.tagmode=4
textfield_set("room width",roomwidth)

i=instance_create(80,200,TextField)
i.action="room height"
i.alt="Height"
i.w=72
i.tagmode=4
textfield_set("room height",roomheight)

i=instance_create(80,236,TextField)
i.action="room speed"
i.w=72
i.tagmode=4
textfield_set("room speed",roomspeed)

i=instance_create(8,272,Button)
i.type=1
i.action="room persist"
i.text="Persistent"
i.alt="Make this room remember its state when leaving it"
i.tagmode=4

i=instance_create(0,304,Button)
i.action="room code"
i.text="Room code"
i.w=160
i.tagmode=4

/*

//inspector
i=instance_create(width-160,0,TextField)
i.action="object name"
i.type=2
i.anchor=1
i.dynamic=1
i.maxlen=11
i.w=128
i.tagmode=0

i=instance_create(width-32,0,Button)
i.spr=13
i.action="copy object"
i.alt="Copy object name"
i.anchor=1
i.dynamic=1
i.tagmode=0

//position
i=instance_create(width-160+8,64,TextField)
i.action="inst x"
i.alt="x"
i.anchor=1
i.dynamic=1
i.w=72
i.tagmode=0

i=instance_create(width-80,64,TextField)
i.action="inst y"
i.alt="y"
i.anchor=1
i.dynamic=1
i.w=72
i.tagmode=0

i=instance_create(width-64,100,Button)
i.action="inst snap"
i.text="Snap"
i.anchor=1
i.dynamic=1
i.w=56
i.h=24
i.tagmode=0

//scale
i=instance_create(width-160+8,164,TextField)
i.action="inst xs"
i.alt="xscale"
i.dynamic=1
i.anchor=1
i.w=72
i.tagmode=0

i=instance_create(width-80,164,TextField)
i.action="inst ys"
i.alt="yscale"
i.dynamic=1
i.anchor=1
i.w=72
i.tagmode=0

i=instance_create(width-160+8+8,192+8,Button)
i.action="inst flip xs"
i.text="Flip"
i.alt="Flip horizontally"
i.anchor=1
i.dynamic=1
i.w=56
i.h=24
i.tagmode=0

i=instance_create(width-80+8,192+8,Button)
i.action="inst flip ys"
i.text="Flip"
i.alt="Flip vertically"
i.anchor=1
i.dynamic=1
i.w=56
i.h=24
i.tagmode=0

//rotation
i=instance_create(width-160+8,264,TextField)
i.action="inst ang"
i.anchor=1
i.dynamic=1
i.w=72
i.tagmode=0

i=instance_create(width-80+4,260+4,Button)
i.action="inst rot left"
i.alt="Rotate left"
i.spr=14
i.anchor=1
i.dynamic=1
i.tagmode=0

i=instance_create(width-80+8+32,260+4,Button)
i.action="inst rot right"
i.alt="Rotate right"
i.spr=15
i.anchor=1
i.dynamic=1
i.tagmode=0

//blend
i=instance_create(width-160+8,336,TextField)
i.action="inst col"
i.alt="Color"
i.anchor=1
i.dynamic=1
i.type=1
i.text=string(global.col_main)
i.w=72
i.tagmode=0

i=instance_create(width-160+8+72,336,TextField)
i.action="inst alpha"
i.alt="Alpha"
i.anchor=1
i.dynamic=1
i.maxval=255
i.w=72
i.tagmode=0
