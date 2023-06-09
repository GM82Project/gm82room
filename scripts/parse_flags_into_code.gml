var str,flag;

str=""

flag="/*gm82room flag*/"

i=0 repeat (8) {
    if (frac(bg_hspeed[i])!=0) {str+=flag+"background_hspeed["+string(i)+"]="+string_better(bg_hspeed[i])+lf bg_hspeed[i]=0}
    if (frac(bg_vspeed[i])!=0) {str+=flag+"background_vspeed["+string(i)+"]="+string_better(bg_vspeed[i])+lf bg_vspeed[i]=0}
i+=1}

return str
