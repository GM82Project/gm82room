//background mode
i=instance_create(8,104,Button)
i.type=1
i.action="clear bg"
i.text="Color"
i.alt="Draw background color"
i.tagmode=2

i=instance_create(96,100,TextField)
i.action="bgcol"
i.alt="Background color"
i.type=1
i.text=string(background_color)
i.w=60
i.tagmode=2

i=instance_create(0,136,Button) i.action="bgselect" i.actionid=0 i.text="0" i.tagmode=2 i.w=40
i=instance_create(40,136,Button) i.action="bgselect" i.actionid=1 i.text="1" i.tagmode=2 i.w=40
i=instance_create(80,136,Button) i.action="bgselect" i.actionid=2 i.text="2" i.tagmode=2 i.w=40
i=instance_create(120,136,Button) i.action="bgselect" i.actionid=3 i.text="3" i.tagmode=2 i.w=40
i=instance_create(0,168,Button) i.action="bgselect" i.actionid=4 i.text="4" i.tagmode=2 i.w=40
i=instance_create(40,168,Button) i.action="bgselect" i.actionid=5 i.text="5" i.tagmode=2 i.w=40
i=instance_create(80,168,Button) i.action="bgselect" i.actionid=6 i.text="6" i.tagmode=2 i.w=40
i=instance_create(120,168,Button) i.action="bgselect" i.actionid=7 i.text="7" i.tagmode=2 i.w=40

i=instance_create(8,208,TextField)
i.action="bg name"
i.type=3
i.maxlen=13
i.w=160-16
i.tagmode=2
//textfield_set("bgname",bg_name[bg_current])

i=instance_create(8,244,Button)
i.type=1
i.action="bg visible"
i.text="Visible"
i.tagmode=2

i=instance_create(8,272,Button)
i.type=1
i.action="bg fore"
i.text="Foreground"
i.tagmode=2

i=instance_create(8,300,Button)
i.type=1
i.action="bg tileh"
i.text="Tile H"
i.tagmode=2

i=instance_create(8,328,Button)
i.type=1
i.action="bg tilev"
i.text="Tile V"
i.tagmode=2

i=instance_create(8,356,Button)
i.type=1
i.action="bg stretch"
i.text="Stretch"
i.tagmode=2

i=instance_create(8,408,TextField)
i.action="bg xpos"
i.alt="x"
i.w=72
i.tagmode=2

i=instance_create(80,408,TextField)
i.action="bg ypos"
i.alt="y"
i.w=72
i.tagmode=2

i=instance_create(8,468,TextField)
i.action="bg hsp"
i.alt="hspeed"
i.w=72
i.tagmode=2

i=instance_create(80,468,TextField)
i.action="bg vsp"
i.alt="vspeed"
i.w=72
i.tagmode=2

update_backgroundpanel()
