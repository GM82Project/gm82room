with (TextField) if (action=argument0) {
    if (is_real(argument1)) text=string_copy(string_better(argument1),1,maxlen)
    else text=string_copy(argument1,1,maxlen)
    if (type==2 || type==3) {if (string_length(argument1)>maxlen) alt=argument1 else alt=""}
    active=0
    event_user(4)
}
