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
i.basealt="width"
i.w=72
i.maxlen=6
i.tagmode=4
textfield_set("room width",roomwidth)

i=instance_create(80,232,TextField)
i.action="room height"
i.basealt="height"
i.w=72
i.maxlen=6
i.tagmode=4
textfield_set("room height",roomheight)

i=instance_create(80,268,TextField)
i.action="room speed"
i.w=72
i.basealt="speed"
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


//chunks
i=instance_create(width-160+8,40,Button)
i.type=1
i.anchor=1
i.action="chunk crop"
i.text="Crop"
i.alt="Export only part of the room"
i.tagmode=4

i=instance_create(width-160+8,68,TextField)
i.action="chunk x"
i.basealt="x"
i.anchor=1
i.displen=6
i.w=72
i.tagmode=4

i=instance_create(width-80,68,TextField)
i.action="chunk y"
i.basealt="y"
i.anchor=1
i.displen=6
i.w=72
i.tagmode=4

//scale
i=instance_create(width-160+8,104,TextField)
i.action="chunk w"
i.basealt="width"
i.displen=6
i.anchor=1
i.w=72
i.tagmode=4

i=instance_create(width-80,104,TextField)
i.action="chunk h"
i.basealt="height"
i.displen=6
i.anchor=1
i.w=72
i.tagmode=4

i=instance_create(width-160+8,140,Button)
i.action="chunk export"
i.text="Export"
i.alt="Save part of the room to a chunk file"
i.anchor=1
i.w=72
i.tagmode=4

i=instance_create(width-80,140,Button)
i.action="chunk import"
i.text="Import"
i.alt="Load and paste a chunk file"
i.anchor=1
i.w=72
i.tagmode=4

update_settingspanel()
