//background mode
i=instance_create(8,108,Button)
i.type=1
i.action="clear bg"
i.text="Clear"
i.alt="Clear background with a color"
i.tagmode=2

i=instance_create(96,104,TextField)
i.action="bgcol"
i.alt="Background color"
i.type=1
i.text=string(background_color)
i.w=56
i.tagmode=2

i=instance_create(0,144,Button) i.action="bgselect" i.actionid=0 i.text="0" i.tagmode=2 i.w=40
i=instance_create(40,144,Button) i.action="bgselect" i.actionid=1 i.text="1" i.tagmode=2 i.w=40
i=instance_create(80,144,Button) i.action="bgselect" i.actionid=2 i.text="2" i.tagmode=2 i.w=40
i=instance_create(120,144,Button) i.action="bgselect" i.actionid=3 i.text="3" i.tagmode=2 i.w=40
i=instance_create(0,176,Button) i.action="bgselect" i.actionid=4 i.text="4" i.tagmode=2 i.w=40
i=instance_create(40,176,Button) i.action="bgselect" i.actionid=5 i.text="5" i.tagmode=2 i.w=40
i=instance_create(80,176,Button) i.action="bgselect" i.actionid=6 i.text="6" i.tagmode=2 i.w=40
i=instance_create(120,176,Button) i.action="bgselect" i.actionid=7 i.text="7" i.tagmode=2 i.w=40

i=instance_create(8,216,TextField)
i.action="bg name"
i.type=3
i.maxlen=13
i.w=160-16
i.tagmode=2
//textfield_set("bgname",bg_name[bg_current])

i=instance_create(8,260,Button)
i.type=1
i.action="bg visible"
i.text="Visible"
i.tagmode=2

i=instance_create(8,288,Button)
i.type=1
i.action="bg fore"
i.text="Foreground"
i.tagmode=2

i=instance_create(8,316,Button)
i.type=1
i.action="bg tileh"
i.text="Tile H"
i.tagmode=2

i=instance_create(8,344,Button)
i.type=1
i.action="bg tilev"
i.text="Tile V"
i.tagmode=2

i=instance_create(8,372,Button)
i.type=1
i.action="bg stretch"
i.text="Stretch"
i.tagmode=2

i=instance_create(8,432,TextField)
i.action="bg xpos"
i.w=72
i.tagmode=2

i=instance_create(80,432,TextField)
i.action="bg ypos"
i.w=72
i.tagmode=2

i=instance_create(8,500,TextField)
i.action="bg hsp"
i.w=72
i.tagmode=2

i=instance_create(80,500,TextField)
i.action="bg vsp"
i.w=72
i.tagmode=2

update_backgroundpanel()
