///bresenham(x0, y0, x1, y1, script, args...)
var x0,y0,x1,y1,dx,sx,dy,sy,error;

x0=argument[0]
y0=argument[1]
x1=argument[2]
y1=argument[3]

dx=abs(x1-x0)
sx=sign(x1-x0)
dy=-abs(y1-y0)
sy=sign(y1-y0)

error=dx+dy

while (true) {
    script_execute(argument[4],x0,y0,argument[5])//,argument[6],argument[7])
    e2=error*2
    if (e2>=dy) {
        if (x0==x1) break
        error+=dy
        x0+=sx
    }
    if (e2<=dx) {
        if (y0==y1) break
        error+=dx
        y0+=sy
    }
}
