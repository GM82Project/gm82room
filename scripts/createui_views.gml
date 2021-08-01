//view mode

i=instance_create(8,104,Button)
i.type=1
i.action="enable views"
i.text="Use Views"
i.tagmode=3

i=instance_create(0,136,Button) i.action="vwselect" i.actionid=0 i.text="0" i.tagmode=3 i.w=40
i=instance_create(40,136,Button) i.action="vwselect" i.actionid=1 i.text="1" i.tagmode=3 i.w=40
i=instance_create(80,136,Button) i.action="vwselect" i.actionid=2 i.text="2" i.tagmode=3 i.w=40
i=instance_create(120,136,Button) i.action="vwselect" i.actionid=3 i.text="3" i.tagmode=3 i.w=40
i=instance_create(0,168,Button) i.action="vwselect" i.actionid=4 i.text="4" i.tagmode=3 i.w=40
i=instance_create(40,168,Button) i.action="vwselect" i.actionid=5 i.text="5" i.tagmode=3 i.w=40
i=instance_create(80,168,Button) i.action="vwselect" i.actionid=6 i.text="6" i.tagmode=3 i.w=40
i=instance_create(120,168,Button) i.action="vwselect" i.actionid=7 i.text="7" i.tagmode=3 i.w=40

i=instance_create(8,208,Button)
i.type=1
i.action="view visible"
i.text="Visible"
i.tagmode=3

//room
i=instance_create(8,260,TextField)
i.action="view x"
i.alt="x"
i.w=72
i.tagmode=3

i=instance_create(8,292,TextField)
i.action="view y"
i.alt="y"
i.w=72
i.tagmode=3

i=instance_create(80,260,TextField)
i.action="view w"
i.alt="width"
i.w=72
i.tagmode=3

i=instance_create(80,292,TextField)
i.action="view h"
i.alt="height"
i.w=72
i.tagmode=3

//port
i=instance_create(8,352,TextField)
i.action="view xp"
i.alt="x"
i.w=72
i.tagmode=3

i=instance_create(8,384,TextField)
i.action="view yp"
i.alt="y"
i.w=72
i.tagmode=3

i=instance_create(80,352,TextField)
i.action="view wp"
i.alt="width"
i.w=72
i.tagmode=3

i=instance_create(80,384,TextField)
i.action="view hp"
i.alt="height"
i.w=72
i.tagmode=3

//following

i=instance_create(8,444,TextField)
i.action="view follow"
i.type=3
i.maxlen=13
i.w=160-16
i.tagmode=3


i=instance_create(8,476,TextField)
i.action="view hbor"
i.alt="h border"
i.w=72
i.tagmode=3

i=instance_create(8,508,TextField)
i.action="view vbor"
i.alt="v border"
i.w=72
i.tagmode=3

i=instance_create(80,476,TextField)
i.action="view hspeed"
i.alt="hspeed"
i.w=72
i.tagmode=3

i=instance_create(80,508,TextField)
i.action="view vspeed"
i.alt="vspeed"
i.w=72
i.tagmode=3

update_viewpanel()
