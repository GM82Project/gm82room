//reduce collision by 1 pixel on each side to account for instance rotation bounding box issues

var l,t,r,b,w,h;

l=bbox_left
t=bbox_top

sw=(sprite_get_bbox_right(sprite_index)+1)-sprite_get_bbox_left(sprite_index)
sh=(sprite_get_bbox_bottom(sprite_index)+1)-sprite_get_bbox_top(sprite_index)

image_xscale=(sw*image_xscale-2)/sw
image_yscale=(sh*image_yscale-2)/sh

x+=l+1-bbox_left
y+=t+1-bbox_top

//:weary:
