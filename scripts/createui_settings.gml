//settings mode
i=instance_create(8,128,TextField)
i.action="room caption"
i.w=160-16
i.tagmode=4
i.displen=13
i.type=4
textfield_set("room caption",roomcaption)

i=instance_create(8,200,TextField)
i.action="room width"
i.alt="Width"
i.w=72
i.tagmode=4
textfield_set("room width",roomwidth)

i=instance_create(80,200,TextField)
i.action="room height"
i.alt="Height"
i.w=72
i.tagmode=4
textfield_set("room height",roomheight)

i=instance_create(80,236,TextField)
i.action="room speed"
i.w=72
i.tagmode=4
textfield_set("room speed",roomspeed)

i=instance_create(8,272,Button)
i.type=1
i.action="room persist"
i.text="Persistent"
i.alt="Make this room remember its state when leaving it"
i.tagmode=4

i=instance_create(0,304,Button)
i.action="room code"
i.text="Room code"
i.w=160
i.tagmode=4
i.alt=roomcode
