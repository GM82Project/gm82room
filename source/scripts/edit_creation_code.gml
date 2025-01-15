var str;

str=""
if (num_selected()==1) with (instance) if (sel) str=code

str=external_code_editor(str)

begin_undo(act_change,"modifying instance creation code",0)

with (instance) if (sel) {if (code!=str) add_undo_instance_props() code=str update_inspector()}

push_undo()
