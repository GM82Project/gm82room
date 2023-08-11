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
i.w=53

i=instance_create(53,32,Button)
i.spr=3
i.action="tile mode"
i.alt="Tiles"
i.w=54

i=instance_create(107,32,Button)
i.spr=28
i.action="path mode"
i.alt="Paths"
i.w=53

i=instance_create(0,64,Button)
i.spr=4
i.action="bg mode"
i.alt="Background"
i.w=53

i=instance_create(53,64,Button)
i.spr=6
i.action="view mode"
i.alt="Views"
i.w=54

i=instance_create(107,64,Button)
i.spr=21
i.action="settings mode"
i.alt="Room Settings"
i.w=53



i=instance_create(160+16,0,Button)
i.spr=27
i.action="undo"
i.alt="Undo (empty)"


//grid
i=instance_create(160+64,0,Button)
i.spr=1
i.action="toggle grid"
i.alt="Show grid"

i=instance_create(160+96,0,TextField)
i.action="grid x"
i.w=56
i.alt="Grid X"
i.maxlen=4
textfield_set("grid x",gridx)

i=instance_create(160+152,0,TextField)
i.action="grid y"
i.w=56
i.alt="Grid Y"
i.maxlen=4
textfield_set("grid y",gridy)

i=instance_create(160+208,0,Button)
i.spr=9
i.action="toggle crosshair"
i.alt="Show crosshair"


//show
i=instance_create(160+256,0,Button)
i.spr=2
i.action="view objects"
i.alt="Show instances"

i=instance_create(160+288,0,Button)
i.spr=7
i.action="view invis"
i.alt="Show instances of invisible objects"

i=instance_create(160+320,0,Button)
i.spr=8
i.action="view nospr"
i.alt="Show instances of objects without sprites"

i=instance_create(160+352,0,Button)
i.spr=3
i.action="view tiles"
i.alt="Show tiles"

i=instance_create(160+384,0,Button)
i.spr=4
i.action="view bgs"
i.alt="Show backgrounds"

i=instance_create(160+416,0,Button)
i.spr=5
i.action="view fgs"
i.alt="Show foregrounds"

i=instance_create(160+448,0,Button)
i.spr=6
i.action="view views"
i.alt="Show views"

i=instance_create(160+480,0,Button)
i.spr=28
i.action="view paths"
i.alt="Show paths"

i=instance_create(160+512,0,Button)
i.spr=35
i.action="view ref"
i.alt="Show reference image"

i=instance_create(160+544,0,Button)
i.spr=31
i.action="view draw"
i.alt="Enable realtime previews"


//view
i=instance_create(160+592,0,Button)
i.spr=10
i.action="reset view"
i.alt="Reset view"

i=instance_create(160+624,0,Button)
i.spr=11
i.action="zoom in"
i.alt="Zoom in"

i=instance_create(160+656,0,Button)
i.spr=12
i.action="zoom out"
i.alt="Zoom out"

i=instance_create(160+688,0,Button)
i.spr=16
i.action="interp"
i.alt="Smoothing"

//halp
i=instance_create(160+736,0,Button)
i.spr=22
i.action="help"
i.alt="Quick guide"

i=instance_create(160+768,0,Button)
i.spr=21
i.action="prefs"
i.alt="Preferences"

i=instance_create(160+800,0,Button)
i.spr=49
i.action="live"
i.alt="Start Live connection to game"
