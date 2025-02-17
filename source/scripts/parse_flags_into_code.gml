var str,flag;

str=""

flag="/*gm82room flag*/"

i=0 repeat (8) {
    if (frac(bg_hspeed[i])!=0) str+=flag+"background_hspeed["+string(i)+"]="+string_better_lim(bg_hspeed[i])+lf
    if (frac(bg_vspeed[i])!=0) str+=flag+"background_vspeed["+string(i)+"]="+string_better_lim(bg_vspeed[i])+lf
    if (bg_blend[i]!=$ffffff) str+=flag+"background_blend["+string(i)+"]="+string_better_lim(bg_blend[i])+lf
    if (bg_alpha[i]!=1) str+=flag+"background_alpha["+string(i)+"]="+string_better_lim(bg_alpha[i])+lf
    if (!bg_stretch[i]) {
        //we don't save scale data if stretch is checked
        if (bg_xscale[i]!=1) str+=flag+"background_xscale["+string(i)+"]="+string_better_lim(bg_xscale[i])+lf 
        if (bg_yscale[i]!=1) str+=flag+"background_yscale["+string(i)+"]="+string_better_lim(bg_yscale[i])+lf 
    }
i+=1}

return str
