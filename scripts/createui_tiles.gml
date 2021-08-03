//tile mode

i=instance_create(0,96,TextField)
i.action="tile bg name"
i.type=3
i.maxlen=13
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


i=instance_create(width-160,32,Button)
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
