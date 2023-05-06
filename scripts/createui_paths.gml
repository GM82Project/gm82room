i=instance_create(0,96,Button)
i.spr=19
i.action="pathscrolup"
i.w=160
i.h=24
i.tagmode=5

i=instance_create(0,height-276-52,Button)
i.spr=20
i.action="pathscroldown"
i.w=160
i.h=24
i.tagmode=5
i.anchor=2

i=instance_create(0,height-276-28,TextField)
i.action="path name"
i.basealt="Path"
i.type=3
i.dynamic=1
i.maxlen=14
i.w=160
i.tagmode=5
i.anchor=2
textfield_set("path name","")

i=instance_create(160-32-8,height-164+72-172,Button)
i.spr=25
i.dynamic=1
i.action="path destroy"
i.alt="Delete path"
i.tagmode=5
i.anchor=2

    i=instance_create(8,height-164+72-172,Button)
    i.type=1
    i.dynamic=1
    i.action="path smooth"
    i.text="Smooth"
    i.alt="Path uses a bezier curve instead of straight lines"
    i.tagmode=5
    i.anchor=2

    i=instance_create(8,height-164+100-172,Button)
    i.type=1
    i.dynamic=1
    i.action="path closed"
    i.text="Closed"
    i.alt="The last point connects to the first point"
    i.tagmode=5
    i.anchor=2

    i=instance_create(120,height-164+124-172,TextField)
    i.action="path precision"
    i.w=32
    i.dynamic=1
    i.basealt="How many bezier iterations are used on a smooth path"
    i.maxlen=4
    textfield_set("path precision","")
    i.tagmode=5
    i.anchor=2

i=instance_create(8,height-180+4+100,TextField)
i.action="path x"
i.basealt="x"
i.w=72
i.maxlen=6
i.dynamic=1
i.tagmode=5
i.anchor=2
textfield_set("path x","")

i=instance_create(80,height-180+4+100,TextField)
i.action="path y"
i.basealt="y"
i.w=72
i.maxlen=6
i.dynamic=1
i.tagmode=5
i.anchor=2
textfield_set("path y","")

i=instance_create(80,height-180+40+100,TextField)
i.action="path speed"
i.w=72
i.basealt="speed"
i.maxlen=4
i.dynamic=1
i.tagmode=5
i.anchor=2
textfield_set("path speed","")

i=instance_create(40,height-280+44+100,TextField)
i.action="path point"
i.w=80
i.maxlen=4
i.dynamic=1
i.tagmode=5
i.anchor=2
textfield_set("path point","")

i=instance_create(160-48-8,height-280+16+100,Button)
i.w=24
i.h=24
i.spr=40
i.dynamic=1
i.action="path point add"
i.alt="Dupe point"
i.tagmode=5
i.anchor=2

i=instance_create(160-24-8,height-280+16+100,Button)
i.w=24
i.h=24
i.spr=41
i.dynamic=1
i.action="path point del"
i.alt="Delete point"
i.tagmode=5
i.anchor=2


i=instance_create(8,height-280+44+100,Button)
i.spr=37
i.dynamic=1
i.action="path point-"
i.tagmode=5
i.anchor=2

i=instance_create(40+80,height-280+44+100,Button)
i.spr=38
i.dynamic=1
i.action="path point+"
i.tagmode=5
i.anchor=2


//inspector
i=instance_create(width-160+8,8,Button)
i.w=144
i.spr=42
i.action="path clear"
i.text="  Clear"
i.alt=""
i.tagmode=5
i.anchor=1

i=instance_create(width-160+8,8+32,Button)
i.w=144
i.spr=43
i.action="path reverse"
i.text="  Reverse"
i.alt=""
i.tagmode=5
i.anchor=1

i=instance_create(width-160+8,8+64,Button)
i.w=144
i.spr=44
i.action="path shift"
i.text="  Shift"
i.alt=""
i.tagmode=5
i.anchor=1

i=instance_create(width-160+8,8+96,Button)
i.w=72
i.spr=45
i.action="path fliph"
i.text=" Flip"
i.alt="Flip horizontally"
i.tagmode=5
i.anchor=1

i=instance_create(width-160+8+72,8+96,Button)
i.w=72
i.spr=46
i.action="path flipv"
i.text=" Flip"
i.alt="Flip vertically"
i.tagmode=5
i.anchor=1

i=instance_create(width-160+8,8+128,Button)
i.w=144
i.spr=47
i.action="path rotate"
i.text="  Rotate"
i.alt=""
i.tagmode=5
i.anchor=1

i=instance_create(width-160+8,8+160,Button)
i.w=144
i.spr=48
i.action="path scale"
i.text="  Scale"
i.alt=""
i.tagmode=5
i.anchor=1

i=instance_create(width-160+8,8+192+4,Button)
i.type=1
i.action="path thin"
i.text="Thin lines"
i.alt="Draw the current path with#thin lines to help visibility"
i.tagmode=5
i.anchor=1
