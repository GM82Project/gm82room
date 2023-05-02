i=instance_create(0,96,Button)
i.spr=19
i.action="pathscrolup"
i.w=160
i.h=24
i.tagmode=5

i=instance_create(0,height-276-48,Button)
i.spr=20
i.action="pathscroldown"
i.w=160
i.h=24
i.tagmode=5
i.anchor=2

i=instance_create(0,height-276-24,TextField)
i.action="path name"
i.basealt="Path"
i.type=3
i.dynamic=1
i.maxlen=14
i.w=160
i.tagmode=5
i.anchor=2
textfield_set("path name","")

i=instance_create(8,height-164+72,Button)
i.type=1
i.dynamic=1
i.action="path smooth"
i.text="Smooth"
i.alt="Path uses a bezier curve instead of straight lines"
i.tagmode=5
i.anchor=2

i=instance_create(8,height-164+100,Button)
i.type=1
i.dynamic=1
i.action="path closed"
i.text="Closed"
i.alt="The last point connects to the first point"
i.tagmode=5
i.anchor=2

i=instance_create(116,height-164+124,TextField)
i.action="path precision"
i.w=36
i.dynamic=1
i.basealt="How many bezier iterations are used on a smooth path"
i.maxlen=4
textfield_set("path precision","")
i.tagmode=5
i.anchor=2

i=instance_create(8,height-180+4,TextField)
i.action="path x"
i.basealt="x"
i.w=72
i.maxlen=6
i.dynamic=1
i.tagmode=5
i.anchor=2
textfield_set("path x","")

i=instance_create(80,height-180+4,TextField)
i.action="path y"
i.basealt="y"
i.w=72
i.maxlen=6
i.dynamic=1
i.tagmode=5
i.anchor=2
textfield_set("path y","")

i=instance_create(80,height-180+40,TextField)
i.action="path speed"
i.w=72
i.basealt="speed"
i.maxlen=4
i.dynamic=1
i.tagmode=5
i.anchor=2
textfield_set("path speed","")

i=instance_create(40,height-280+36+8,TextField)
i.action="path point"
i.w=80
i.basealt="point"
i.maxlen=4
i.dynamic=1
i.tagmode=5
i.anchor=2
textfield_set("path point","")

i=instance_create(8,height-280+36+8,Button)
i.spr=37
i.action="path point-"
i.tagmode=5
i.anchor=2

i=instance_create(40+80,height-280+36+8,Button)
i.spr=38
i.action="path point+"
i.tagmode=5
i.anchor=2
