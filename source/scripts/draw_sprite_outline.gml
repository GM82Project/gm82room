///draw_sprite_outline(sprite,image,x,y,xscale,yscale,angle,color,alpha)
var df,dx,dy;

df=floor(argument1)
dx=argument2+lengthdir_x(0.5*argument4,argument6)+lengthdir_x(0.5*argument5,argument6-90)
dy=argument3+lengthdir_y(0.5*argument4,argument6)+lengthdir_y(0.5*argument5,argument6-90)

draw_sprite_ext(argument0,df,dx+1,dy,argument4,argument5,argument6,0,argument8)
draw_sprite_ext(argument0,df,dx-1,dy,argument4,argument5,argument6,0,argument8)
draw_sprite_ext(argument0,df,dx,dy+1,argument4,argument5,argument6,0,argument8)
draw_sprite_ext(argument0,df,dx,dy-1,argument4,argument5,argument6,0,argument8)
draw_sprite_ext(argument0,df,dx,dy,argument4,argument5,argument6,argument7,argument8)
