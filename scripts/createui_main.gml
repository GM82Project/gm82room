//ok
i=instance_create(0,0,Button)
i.spr=0
i.action="save and quit"
i.alt="Save and close"
i.w=80


//tabs
i=instance_create(80,0,Button)
i.spr=21
i.action="settings mode"
i.alt="Settings"
i.w=80

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
i.spr=7
i.action="view invis"
i.alt="Show instances of invisible objects"

i=instance_create(160+272,0,Button)
i.spr=8
i.action="view nospr"
i.alt="Show instances of objects without sprites"

i=instance_create(160+304,0,Button)
i.spr=3
i.action="view tiles"
i.alt="Show tiles"

i=instance_create(160+336,0,Button)
i.spr=4
i.action="view bgs"
i.alt="Show backgrounds"

i=instance_create(160+368,0,Button)
i.spr=5
i.action="view fgs"
i.alt="Show foregrounds"

i=instance_create(160+400,0,Button)
i.spr=6
i.action="view views"
i.alt="Show views"


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
