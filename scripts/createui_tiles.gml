//tile mode

i=instance_create(0,96,TextField)
i.action="tile bg name"
i.type=3
i.maxlen=14
i.w=160
i.tagmode=1


i=instance_create(0,128,Button)
i.spr=19
i.action="tile palscrolup"
i.w=160
i.h=24
i.tagmode=1

i=instance_create(0,height-160-56,Button)
i.spr=20
i.action="tile palscroldown"
i.w=160
i.h=24
i.anchor=2
i.tagmode=1

i=instance_create(8,height-32,Button)
i.type=1
i.anchor=2
i.action="tile overlap check"
i.text="No overlap"
i.alt="Avoid placing tiles that overlap existing#tiles of the same layer"
i.tagmode=1


//inspector
i=instance_create(width-160,0,TextField)
i.action="current tile bg name"
i.type=2
i.anchor=1
i.dynamic=1
i.maxlen=14
i.w=160
i.tagmode=1

//position
i=instance_create(width-160+8,64,TextField)
i.action="tile x"
i.alt="x"
i.anchor=1
i.dynamic=1
i.displen=6
i.w=72
i.tagmode=1

i=instance_create(width-80,64,TextField)
i.action="tile y"
i.alt="y"
i.anchor=1
i.dynamic=1
i.displen=6
i.w=72
i.tagmode=1

i=instance_create(width-64,100,Button)
i.action="tile snap"
i.text="Snap"
i.anchor=1
i.dynamic=1
i.w=56
i.h=24
i.tagmode=1

//scale
i=instance_create(width-160+8,164,TextField)
i.action="tile xs"
i.alt="xscale"
i.dynamic=1
i.extended=1
i.displen=6
i.anchor=1
i.w=72
i.tagmode=1

i=instance_create(width-80,164,TextField)
i.action="tile ys"
i.alt="yscale"
i.dynamic=1
i.extended=1
i.displen=6
i.anchor=1
i.w=72
i.tagmode=1

i=instance_create(width-160+8+8,192+8,Button)
i.action="tile flip xs"
i.text="Flip"
i.alt="Flip horizontally"
i.anchor=1
i.dynamic=1
i.extended=1
i.w=56
i.h=24
i.tagmode=1

i=instance_create(width-80+8,192+8,Button)
i.action="tile flip ys"
i.text="Flip"
i.alt="Flip vertically"
i.anchor=1
i.dynamic=1
i.extended=1
i.w=56
i.h=24
i.tagmode=1

//blend
i=instance_create(width-160+8,264,TextField)
i.action="tile col"
i.alt="Color"
i.anchor=1
i.dynamic=1
i.extended=1
i.type=1
i.text=string(global.col_main)
i.w=72
i.tagmode=1

i=instance_create(width-160+8+72,264,TextField)
i.action="tile alpha"
i.alt="Alpha"
i.anchor=1
i.dynamic=1
i.extended=1
i.maxval=255
i.w=72
i.tagmode=1

//layers
i=instance_create(width-160,336,Button)
i.spr=19
i.action="layerscrolup"
i.w=160
i.h=24
i.anchor=1
i.tagmode=1

i=instance_create(width-160,height-100,Button)
i.spr=20
i.action="layerscroldown"
i.w=160
i.h=24
i.anchor=3
i.tagmode=1

i=instance_create(width-152,height-68,TextField)
i.action="layer depth"
i.w=144
i.maxlen=10
i.anchor=3
i.tagmode=1

i=instance_create(width-160+8+8,height-32,Button)
i.action="layer dupe"
i.text="Dupe"
i.anchor=3
i.w=56
i.h=24
i.tagmode=1

i=instance_create(width-80+8,height-32,Button)
i.action="layer delete"
i.text="Del"
i.anchor=3
i.w=56
i.h=24
i.tagmode=1
