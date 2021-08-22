var f,f2,str,path,closed,precision,smooth;
var p,i,l,d,px,py,dx,dy,opx,opy,odx,ody;

f=file_text_open_read(root+"paths\index.yyd") do {pathname=file_text_read_string(f) file_text_readln(f)
    f2=file_text_open_read(root+"paths\"+pathname+"\path.txt")
    smooth=(string_delete(file_text_read_string(f2),1,11)=="1")
    file_text_readln(f2)
    closed=(string_delete(file_text_read_string(f2),1,7)=="1")
    file_text_readln(f2)
    precision=real((string_delete(file_text_read_string(f2),1,10)))
    file_text_readln(f2)
    str=string_delete(file_text_read_string(f2),1,11)
    file_text_close(f2)
    if (str==roomname) {
        path=path_add()
        model=d3d_model_create()
        paths[pathnum,0]=path
        paths[pathnum,1]=pathname
        paths[pathnum,2]=smooth
        paths[pathnum,3]=model
        pathnum+=1
        path_set_closed(path,closed)
        path_set_precision(path,precision)
        path_set_kind(path,smooth)
        f2=file_text_open_read(root+"paths\"+pathname+"\points.txt") do {str=file_text_read_string(f2) file_text_readln(f2)
            string_token_start(str,",")
            path_add_point(path,real(string_token_next()),real(string_token_next()),real(string_token_next()))
        } until (file_text_eof(f2)) file_text_close(f2)

        //generate model
        if (smooth) {
            //smooth path
            l=path_get_length(path)
            d3d_model_primitive_begin(model,pr_trianglelist)
            for (p=0;p<l;p+=4) {
                if (p>0) {
                    opx=px
                    opy=py
                }
                px=path_get_x(path,p/l)-0.5
                py=path_get_y(path,p/l)-0.5
                if (p>0) {
                    if (p>4) {
                        odx=dx
                        ody=dy
                    }
                    d=point_direction(opx,opy,px,py)-90
                    dx=lengthdir_x(1.5,d)
                    dy=lengthdir_y(1.5,d)
                    if (p>4) {
                        d3d_model_vertex_color(model,opx-odx,opy-ody,0,0,1)
                        d3d_model_vertex_color(model,opx+odx,opy+ody,0,0,1)
                        d3d_model_vertex_color(model,opx-dx,opy-dy,0,0,1)
                        d3d_model_vertex_color(model,opx-dx,opy-dy,0,0,1)
                        d3d_model_vertex_color(model,opx+odx,opy+ody,0,0,1)
                        d3d_model_vertex_color(model,opx+dx,opy+dy,0,0,1)
                    }
                    d3d_model_vertex_color(model,opx-dx,opy-dy,0,0,1)
                    d3d_model_vertex_color(model,opx+dx,opy+dy,0,0,1)
                    d3d_model_vertex_color(model,px-dx,py-dy,0,0,1)
                    d3d_model_vertex_color(model,px-dx,py-dy,0,0,1)
                    d3d_model_vertex_color(model,opx+dx,opy+dy,0,0,1)
                    d3d_model_vertex_color(model,px+dx,py+dy,0,0,1)
                }
            }
            d3d_model_primitive_end(model)
            d3d_model_primitive_begin(model,pr_trianglelist)
            for (p=0;p<l;p+=4) {
                if (p>0) {
                    opx=px
                    opy=py
                }
                px=path_get_x(path,p/l)-0.5
                py=path_get_y(path,p/l)-0.5
                if (p>0) {
                    if (p>4) {
                        odx=dx
                        ody=dy
                    }
                    d=point_direction(opx,opy,px,py)-90
                    dx=lengthdir_x(0.5,d)
                    dy=lengthdir_y(0.5,d)
                    if (p>4) {
                        d3d_model_vertex_color(model,opx-odx,opy-ody,0,$ffff,1)
                        d3d_model_vertex_color(model,opx+odx,opy+ody,0,$ffff,1)
                        d3d_model_vertex_color(model,opx-dx,opy-dy,0,$ffff,1)
                        d3d_model_vertex_color(model,opx-dx,opy-dy,0,$ffff,1)
                        d3d_model_vertex_color(model,opx+odx,opy+ody,0,$ffff,1)
                        d3d_model_vertex_color(model,opx+dx,opy+dy,0,$ffff,1)
                    }
                    d3d_model_vertex_color(model,opx-dx,opy-dy,0,$ffff,1)
                    d3d_model_vertex_color(model,opx+dx,opy+dy,0,$ffff,1)
                    d3d_model_vertex_color(model,px-dx,py-dy,0,$ffff,1)
                    d3d_model_vertex_color(model,px-dx,py-dy,0,$ffff,1)
                    d3d_model_vertex_color(model,opx+dx,opy+dy,0,$ffff,1)
                    d3d_model_vertex_color(model,px+dx,py+dy,0,$ffff,1)
                }
            }
            d3d_model_primitive_end(model)
        } else {
            //straight lines
            d3d_model_primitive_begin(model,pr_trianglelist)
            l=path_get_number(path)
            for (p=0;p<l;p+=1) {
                if (p>0) {
                    opx=px
                    opy=py
                }
                px=path_get_point_x(path,p)-0.5
                py=path_get_point_y(path,p)-0.5
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
                }
            }
            d3d_model_primitive_end(model)
            d3d_model_primitive_begin(model,pr_trianglelist)
            for (p=0;p<l;p+=1) {
                if (p>0) {
                    opx=px
                    opy=py
                }
                px=path_get_point_x(path,p)-0.5
                py=path_get_point_y(path,p)-0.5
                if (p>0) {
                    d=point_direction(opx,opy,px,py)-90
                    dx=lengthdir_x(0.5,d)
                    dy=lengthdir_y(0.5,d)
                    d3d_model_vertex_color(model,opx-dx,opy-dy,0,$ffff,1)
                    d3d_model_vertex_color(model,opx+dx,opy+dy,0,$ffff,1)
                    d3d_model_vertex_color(model,px-dx,py-dy,0,$ffff,1)
                    d3d_model_vertex_color(model,px-dx,py-dy,0,$ffff,1)
                    d3d_model_vertex_color(model,opx+dx,opy+dy,0,$ffff,1)
                    d3d_model_vertex_color(model,px+dx,py+dy,0,$ffff,1)
                }
            }
            d3d_model_primitive_end(model)
        }

        //draw points
        l=path_get_number(path)
        for (p=0;p<l;p+=1) {
            px=path_get_point_x(path,p)-0.5
            py=path_get_point_y(path,p)-0.5

            if (p>0) {
                d3d_model_primitive_begin(model,pr_trianglefan)
                for (i=0;i<8;i+=1) {
                    d3d_model_vertex_color(model,px+lengthdir_x(4,i*45),py+lengthdir_y(4,i*45),0,0,1)
                }
                d3d_model_primitive_end(model)
                d3d_model_primitive_begin(model,pr_trianglefan)
                for (i=0;i<8;i+=1) {
                    d3d_model_vertex_color(model,px+lengthdir_x(3,i*45),py+lengthdir_y(3,i*45),0,$ff0000,1)
                }
                d3d_model_primitive_end(model)
            } else {
                d3d_model_primitive_begin(model,pr_trianglefan)
                d3d_model_vertex_color(model,px-4,py-4,0,0,1)
                d3d_model_vertex_color(model,px+4,py-4,0,0,1)
                d3d_model_vertex_color(model,px+4,py+4,0,0,1)
                d3d_model_vertex_color(model,px-4,py+4,0,0,1)
                d3d_model_primitive_end(model)
                d3d_model_primitive_begin(model,pr_trianglefan)
                d3d_model_vertex_color(model,px-3,py-3,0,$8000,1)
                d3d_model_vertex_color(model,px+3,py-3,0,$8000,1)
                d3d_model_vertex_color(model,px+3,py+3,0,$8000,1)
                d3d_model_vertex_color(model,px-3,py+3,0,$8000,1)
                d3d_model_primitive_end(model)
            }
        }
        draw_set_color($ffffff)
    }
} until (file_text_eof(f)) file_text_close(f)
