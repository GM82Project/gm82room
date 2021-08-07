with (TextField) if (action=argument0) {
    text=string_copy(string_better(argument1),1,maxlen)
    if (type==2 || type==3) {if (string_length(argument1)>maxlen) alt=argument1 else alt=""}
    active=0
    event_user(4)
}
