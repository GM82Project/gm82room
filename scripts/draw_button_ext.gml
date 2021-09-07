///draw_button_ext(x,y,w,h,up,color)
var dx,dy,w,h,up,col,u,v,down,spr;

dx=argument0
dy=argument1
w=argument2
h=argument3

up=argument4
col=argument5

if (col!=noone) {
    draw_sprite_ext(spr1x1,0,dx,dy,w,h,0,col,1)
}

down=!up*2

draw_sprite_part(buttontex,down,0,0,4,4,dx,dy)
draw_sprite_part(buttontex,down,76,0,4,4,dx+w-4,dy)
draw_sprite_part(buttontex,down,0,21,4,4,dx,dy+h-4)
draw_sprite_part(buttontex,down,76,21,4,4,dx+w-4,dy+h-4)

draw_sprite_part_ext(buttontex,down,4,0,72,4,dx+4,dy,(w-8)/72,1,$ffffff,1)
draw_sprite_part_ext(buttontex,down,4,21,72,4,dx+4,dy+h-4,(w-8)/72,1,$ffffff,1)
draw_sprite_part_ext(buttontex,down,0,4,4,17,dx,dy+4,1,(h-8)/17,$ffffff,1)
draw_sprite_part_ext(buttontex,down,76,4,4,17,dx+w-4,dy+4,1,(h-8)/17,$ffffff,1)
