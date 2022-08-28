var dx,dy,zm;

dx=argument0
dy=argument1

zm=max(0.5,zoom)
draw_rectangle(dx-8*zm,dy-8*zm,dx+8*zm,dy+8*zm,1)
draw_rectangle(dx-4*zm,dy-4*zm,dx+4*zm,dy+4*zm,1)
