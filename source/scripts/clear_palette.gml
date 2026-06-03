var i;

i=0 repeat (objects_length) {
    objloaded[i]=0
i+=1}

instance_activate_object(instance)

with (instance) objloaded[obj]=1

change_mode(0)
