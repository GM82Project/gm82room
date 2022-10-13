var fn;

fn=get_open_filename("Images|*.jpg;*.jpeg;*.png;*.gif;*.bmp","")

if (file_exists(fn)) {
    if (ref_tex!=noone) background_delete(ref_tex)
    ref_tex=background_add(fn,0,0)
    ref_loaded=1
    view[8]=1
}
