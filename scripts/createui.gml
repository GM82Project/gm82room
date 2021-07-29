buttoncol=global.col_main

//ok
i=instance_create(0,0,Button)
i.spr=0
i.action="save and quit"
i.alt="Save and close"
i.w=160


//tabs
i=instance_create(0,32,Button)
i.spr=2
i.action="object mode"
i.alt="Instances"
i.w=80

i=instance_create(80,32,Button)
i.spr=3
i.action="tile mode"
i.alt="Tiles"
i.w=80

i=instance_create(0,64,Button)
i.spr=4
i.action="bg mode"
i.alt="Backgrounds"
i.w=80

i=instance_create(80,64,Button)
i.spr=6
i.action="view mode"
i.alt="Views"
i.w=80


//grid
i=instance_create(160+16,0,Button)
i.spr=1
i.action="toggle grid"
i.alt="Show grid"

i=instance_create(160+48,0,TextField)
i.action="grid x"
i.w=56
i.alt="Grid X"
i.text=string(gridx)
i.maxlen=4

i=instance_create(160+104,0,TextField)
i.action="grid y"
i.w=56
i.alt="Grid Y"
i.text=string(gridy)
i.maxlen=4

i=instance_create(160+160,0,Button)
i.spr=9
i.action="toggle crosshair"
i.alt="Show crosshair"


//show
i=instance_create(160+208,0,Button)
i.spr=2
i.action="view objects"
i.alt="Show instances"

i=instance_create(160+240,0,Button)
i.spr=3
i.action="view tiles"
i.alt="Show tiles"

i=instance_create(160+272,0,Button)
i.spr=4
i.action="view bgs"
i.alt="Show backgrounds"

i=instance_create(160+304,0,Button)
i.spr=5
i.action="view fgs"
i.alt="Show foregrounds"

i=instance_create(160+336,0,Button)
i.spr=6
i.action="view views"
i.alt="Show views"

i=instance_create(160+368,0,Button)
i.spr=7
i.action="view invis"
i.alt="Show instances of invisible objects"

i=instance_create(160+400,0,Button)
i.spr=8
i.action="view nospr"
i.alt="Show instances of objects without sprites"


//view
i=instance_create(160+448,0,Button)
i.spr=10
i.action="reset view"
i.alt="Reset view"

i=instance_create(160+480,0,Button)
i.spr=11
i.action="zoom in"
i.alt="Zoom in"

i=instance_create(160+512,0,Button)
i.spr=12
i.action="zoom out"
i.alt="Zoom out"

i=instance_create(160+544,0,Button)
i.spr=16
i.action="interp"
i.alt="Smoothing"


//object mode
i=instance_create(0,96,Button)
i.spr=19
i.action="palscrolup"
i.w=160
i.h=24

i=instance_create(0,height-100,Button)
i.spr=20
i.action="palscroldown"
i.w=160
i.h=24
i.anchor=2

i=instance_create(8,height-76+8,TextField)
i.action="palette name"
i.type=3
i.anchor=2
i.dynamic=1
i.maxlen=13
i.w=160-16
i.tagmode=0
textfield_set("palette name",ds_list_find_value(objects,objpal))

i=instance_create(8,height-76+12+32,Button)
i.type=1
i.anchor=2
i.action="overlap check"
i.text="No overlap"
i.alt="Avoid placing instances that overlap existing#instances of the same object type"
i.tagmode=0


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

//creation code
i=instance_create(width-160,376,Button)
i.action="inst code"
i.text="Creation code"
i.anchor=1
i.dynamic=1
i.w=160
i.tagmode=0

with (Button) event_user(1)
