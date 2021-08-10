//settings mode

i=instance_create(0,96,TextField)
i.action="room name"
i.type=3
i.dynamic=1
i.maxlen=14
i.w=160
i.tagmode=4
textfield_set("room name",roomname)

i=instance_create(8,160,TextField)
i.action="room caption"
i.w=160-16
i.tagmode=4
i.displen=13
i.type=4
textfield_set("room caption",roomcaption)

i=instance_create(8,232,TextField)
i.action="room width"
i.alt="Width"
i.w=72
i.maxlen=6
i.tagmode=4
textfield_set("room width",roomwidth)

i=instance_create(80,232,TextField)
i.action="room height"
i.alt="Height"
i.w=72
i.maxlen=6
i.tagmode=4
textfield_set("room height",roomheight)

i=instance_create(80,268,TextField)
i.action="room speed"
i.w=72
i.maxlen=4
i.tagmode=4
textfield_set("room speed",roomspeed)

i=instance_create(8,304,Button)
i.type=1
i.action="room persist"
i.text="Persistent"
i.alt="Make this room remember its state when leaving it"
i.tagmode=4

i=instance_create(8,332,Button)
i.type=1
i.action="room clear"
i.text="Clear"
i.alt="Clear window before drawing"
i.tagmode=4

i=instance_create(0,364,Button)
i.action="room code"
i.text="Room code"
i.w=160
i.tagmode=4
i.alt=roomcode
