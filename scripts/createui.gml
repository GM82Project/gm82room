global.col_low=$203020
global.col_main=$404040
global.col_high=$607060

buttoncol=global.col_main

draw_set_font(fntCode)

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


//inspector
i=instance_create(width-32,0,Button)
i.spr=13
i.action="copy object"
i.alt="Copy object name"
i.anchor=1

//position
i=instance_create(width-160+8,64,TextField)
i.action="inst x"
i.alt="X coordinate"
i.anchor=1
i.dynamic=1
i.w=72

i=instance_create(width-80,64,TextField)
i.action="inst y"
i.alt="Y coordinate"
i.anchor=1
i.dynamic=1
i.w=72

i=instance_create(width-64,100,Button)
i.action="inst snap"
i.text="Snap"
i.anchor=1
i.dynamic=1
i.w=56
i.h=24

//scale
i=instance_create(width-160+8,164,TextField)
i.action="inst xs"
i.alt="X scale"
i.dynamic=1
i.anchor=1
i.w=72

i=instance_create(width-80,164,TextField)
i.action="inst ys"
i.alt="Y scale"
i.dynamic=1
i.anchor=1
i.w=72

i=instance_create(width-160+8+8,192+8,Button)
i.action="inst flip xs"
i.text="Flip"
i.alt="Flip horizontally"
i.anchor=1
i.dynamic=1
i.w=56
i.h=24

i=instance_create(width-80+8,192+8,Button)
i.action="inst flip ys"
i.text="Flip"
i.alt="Flip vertically"
i.anchor=1
i.dynamic=1
i.w=56
i.h=24

//rotation
i=instance_create(width-160+8,264,TextField)
i.action="inst ang"
i.alt="Angle"
i.anchor=1
i.dynamic=1
i.w=72

i=instance_create(width-80+4,260+4,Button)
i.action="inst rot left"
i.alt="Rotate left"
i.spr=14
i.anchor=1
i.dynamic=1

i=instance_create(width-80+8+32,260+4,Button)
i.action="inst rot right"
i.alt="Rotate right"
i.spr=15
i.anchor=1
i.dynamic=1

//blend
i=instance_create(width-160+8,336,TextField)
i.action="inst col"
i.alt="Color"
i.anchor=1
i.dynamic=1
i.type=1
i.text=string($c0c0c0)
i.w=72

i=instance_create(width-160+8+72,336,TextField)
i.action="inst alpha"
i.alt="Alpha"
i.anchor=1
i.dynamic=1
i.maxval=255
i.w=72

//creation code
i=instance_create(width-160,376,Button)
i.action="inst code"
i.text="Creation code"
i.anchor=1
i.dynamic=1
i.w=160

with (Button) event_user(1)
