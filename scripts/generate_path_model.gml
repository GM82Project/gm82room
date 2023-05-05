///generate_path_model(path)
var path,model,smooth,length,pointnum,closed,stepsize,p,i,d,px,py,dx,dy,opx,opy,odx,ody,col,v,thin,iter,op;

path=paths[argument0,0]
model=paths[argument0,3]

thin=(path_thin && path==current_path)

d3d_model_clear(model)

smooth=path_get_kind(path)
length=path_get_length(path)
pointnum=path_get_number(path)
closed=path_get_closed(path)

yellow=$ffff
if (path==current_path) yellow=$ff00ff

//generate model
if (smooth) {
    //smooth path
    stepsize=max(4,length/1000)
    if (!thin) {
        d3d_model_primitive_begin(model,pr_trianglelist)
        v=0
        for ({p=0 iter=0};p<=length+stepsize;{p+=stepsize iter+=1}) {
            if (iter>0) {
                opx=px
                opy=py
            }
            op=min(1,p/length)
            px=path_get_x(path,op)-0.5
            py=path_get_y(path,op)-0.5
            if (iter>0) {
                if (iter>1) {
                    odx=dx
                    ody=dy
                }
                d=point_direction(opx,opy,px,py)-90
                dx=lengthdir_x(1.5,d)
                dy=lengthdir_y(1.5,d)
                if (iter>1) {
                    d3d_model_vertex_color(model,opx-odx,opy-ody,0,0,1)
                    d3d_model_vertex_color(model,opx+odx,opy+ody,0,0,1)
                    d3d_model_vertex_color(model,opx-dx,opy-dy,0,0,1)
                    d3d_model_vertex_color(model,opx-dx,opy-dy,0,0,1)
                    d3d_model_vertex_color(model,opx+odx,opy+ody,0,0,1)
                    d3d_model_vertex_color(model,opx+dx,opy+dy,0,0,1)
                    v+=6
                }
                d3d_model_vertex_color(model,opx-dx,opy-dy,0,0,1)
                d3d_model_vertex_color(model,opx+dx,opy+dy,0,0,1)
                d3d_model_vertex_color(model,px-dx,py-dy,0,0,1)
                d3d_model_vertex_color(model,px-dx,py-dy,0,0,1)
                d3d_model_vertex_color(model,opx+dx,opy+dy,0,0,1)
                d3d_model_vertex_color(model,px+dx,py+dy,0,0,1)
                v+=6

                if (v>31700) {
                    d3d_model_primitive_end(model)
                    d3d_model_primitive_begin(model,pr_trianglelist)
                    v=0
                }
            }
        }
        d3d_model_primitive_end(model)
    }

    if (thin) d3d_model_primitive_begin(model,pr_linelist)
    else d3d_model_primitive_begin(model,pr_trianglelist)
    v=0
    for ({p=0 iter=0};p<=length+stepsize;{p+=stepsize iter+=1}) {
        if (iter>0) {
            opx=px
            opy=py
        }
        op=min(1,p/length)
        px=path_get_x(path,op)-0.5
        py=path_get_y(path,op)-0.5
        if (iter>0) {
            if (iter>1) {
                odx=dx
                ody=dy
            }
            d=point_direction(opx,opy,px,py)-90
            dx=lengthdir_x(0.5,d)
            dy=lengthdir_y(0.5,d)
            if (iter>1) {
                if (thin) {
                    d3d_model_vertex_color(model,opx,opy,0,$ff00ff,1)
                    d3d_model_vertex_color(model,px,py,0,$ff00ff,1)
                    v+=2
                } else {
                    d3d_model_vertex_color(model,opx-odx,opy-ody,0,yellow,1)
                    d3d_model_vertex_color(model,opx+odx,opy+ody,0,yellow,1)
                    d3d_model_vertex_color(model,opx-dx,opy-dy,0,yellow,1)
                    d3d_model_vertex_color(model,opx-dx,opy-dy,0,yellow,1)
                    d3d_model_vertex_color(model,opx+odx,opy+ody,0,yellow,1)
                    d3d_model_vertex_color(model,opx+dx,opy+dy,0,yellow,1)
                    v+=6
                }
            }
            if (!thin) {
                d3d_model_vertex_color(model,opx-dx,opy-dy,0,yellow,1)
                d3d_model_vertex_color(model,opx+dx,opy+dy,0,yellow,1)
                d3d_model_vertex_color(model,px-dx,py-dy,0,yellow,1)
                d3d_model_vertex_color(model,px-dx,py-dy,0,yellow,1)
                d3d_model_vertex_color(model,opx+dx,opy+dy,0,yellow,1)
                d3d_model_vertex_color(model,px+dx,py+dy,0,yellow,1)
                v+=6
            }

            if (v>31700) {
                d3d_model_primitive_end(model)
                if (thin) d3d_model_primitive_begin(model,pr_linelist)
                else d3d_model_primitive_begin(model,pr_trianglelist)
                v=0
            }
        }
    }
    d3d_model_primitive_end(model)
} else {
    //straight lines
    if (!thin) {
        d3d_model_primitive_begin(model,pr_trianglelist)
        v=0
        for (p=0;p<pointnum+closed;p+=1) {
            if (p>0) {
                opx=px
                opy=py
            }
            px=path_get_point_x(path,p mod pointnum)-0.5
            py=path_get_point_y(path,p mod pointnum)-0.5
            if (p>0) {
                d=point_direction(opx,opy,px,py)-90
                dx=lengthdir_x(1.5,d)
                dy=lengthdir_y(1.5,d)
                d3d_model_vertex_color(model,opx-dx,opy-dy,0,0,1)
                d3d_model_vertex_color(model,opx+dx,opy+dy,0,0,1)
                d3d_model_vertex_color(model,px-dx,py-dy,0,0,1)
                d3d_model_vertex_color(model,px-dx,py-dy,0,0,1)
                d3d_model_vertex_color(model,opx+dx,opy+dy,0,0,1)
                d3d_model_vertex_color(model,px+dx,py+dy,0,0,1)
                v+=6

                if (v>31700) {
                    d3d_model_primitive_end(model)
                    d3d_model_primitive_begin(model,pr_trianglelist)
                    v=0
                }
            }
        }
        d3d_model_primitive_end(model)
    }

    if (thin) d3d_model_primitive_begin(model,pr_linelist)
    else d3d_model_primitive_begin(model,pr_trianglelist)
    v=0
    for (p=0;p<pointnum+closed;p+=1) {
        if (p>0) {
            opx=px
            opy=py
        }
        px=path_get_point_x(path,p mod pointnum)-0.5
        py=path_get_point_y(path,p mod pointnum)-0.5
        if (p>0) {
            d=point_direction(opx,opy,px,py)-90
            dx=lengthdir_x(0.5,d)
            dy=lengthdir_y(0.5,d)
            if (thin) {
                d3d_model_vertex_color(model,opx,opy,0,$ff00ff,1)
                d3d_model_vertex_color(model,px,py,0,$ff00ff,1)
                v+=2
            } else {
                d3d_model_vertex_color(model,opx-dx,opy-dy,0,yellow,1)
                d3d_model_vertex_color(model,opx+dx,opy+dy,0,yellow,1)
                d3d_model_vertex_color(model,px-dx,py-dy,0,yellow,1)
                d3d_model_vertex_color(model,px-dx,py-dy,0,yellow,1)
                d3d_model_vertex_color(model,opx+dx,opy+dy,0,yellow,1)
                d3d_model_vertex_color(model,px+dx,py+dy,0,yellow,1)
                v+=6
            }

            if (v>31700) {
                d3d_model_primitive_end(model)
                if (thin) d3d_model_primitive_begin(model,pr_linelist)
                else d3d_model_primitive_begin(model,pr_trianglelist)
                v=0
            }
        }
    }
    d3d_model_primitive_end(model)
}

//draw points
for (p=(!smooth);p<pointnum;p+=1) {
    px=path_get_point_x(path,p)-0.5
    py=path_get_point_y(path,p)-0.5

    if (!thin) {
        d3d_model_primitive_begin(model,pr_trianglefan)
        for (i=0;i<8;i+=1) {
            d3d_model_vertex_color(model,px+lengthdir_x(4,i*45),py+lengthdir_y(4,i*45),0,0,1)
        }
        d3d_model_primitive_end(model)
    }

    if (thin) d3d_model_primitive_begin(model,pr_linestrip)
    else d3d_model_primitive_begin(model,pr_trianglefan)
    if (p=0) col=$8000 else col=$ff0000
    for (i=0;i<8+thin;i+=1) {
        d3d_model_vertex_color(model,px+lengthdir_x(3,i*45),py+lengthdir_y(3,i*45),0,col,1)
    }
    d3d_model_primitive_end(model)
}

//draw square start point
px=path_get_x(path,0)-0.5
py=path_get_y(path,0)-0.5

if (!thin) {
    d3d_model_primitive_begin(model,pr_trianglefan)
    d3d_model_vertex_color(model,px-4,py-4,0,0,1)
    d3d_model_vertex_color(model,px+4,py-4,0,0,1)
    d3d_model_vertex_color(model,px+4,py+4,0,0,1)
    d3d_model_vertex_color(model,px-4,py+4,0,0,1)
    d3d_model_primitive_end(model)
}

if (thin) {
    d3d_model_primitive_begin(model,pr_linestrip)
    d3d_model_vertex_color(model,px-3,py-3,0,$8000,1)
    d3d_model_vertex_color(model,px+3,py-3,0,$8000,1)
    d3d_model_vertex_color(model,px+3,py+3,0,$8000,1)
    d3d_model_vertex_color(model,px-3,py+3,0,$8000,1)
    d3d_model_vertex_color(model,px-3,py-3,0,$8000,1)
} else {
    d3d_model_primitive_begin(model,pr_trianglefan)
    d3d_model_vertex_color(model,px-3,py-3,0,$8000,1)
    d3d_model_vertex_color(model,px+3,py-3,0,$8000,1)
    d3d_model_vertex_color(model,px+3,py+3,0,$8000,1)
    d3d_model_vertex_color(model,px-3,py+3,0,$8000,1)
}
d3d_model_primitive_end(model)

d3d_model_draw(model,0,0,0,-1)
