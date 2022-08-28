///room_shift(x,y)

instance_activate_all()

with (instance) {x+=argument0 y+=argument1}
with (tileholder) {x+=argument0 y+=argument1 tile_set_position(tile,x,y)}

xgo+=argument0
ygo+=argument1
