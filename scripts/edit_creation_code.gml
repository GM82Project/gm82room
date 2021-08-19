var str;

str=""
if (num_selected()==1) with (instance) if (sel) str=code

str=external_code_editor(str)

begin_undo(act_change,"modifying creation code")

with (instance) if (sel) {if (code!=str) add_undo_instance_props() code=str}

push_undo()
