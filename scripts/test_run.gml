save_room(0)

roaming=directory_previous(directory_previous(directory_previous(temp_directory)))+"Roaming\"

gm=registry_read_sz("SOFTWARE\Game Maker\Version 8.2\Preferences\Directory")

if (gm==undefined) {show_message("Error building: Can't find Game Maker 8.2 in the registry.") exit}

gm+="GameMaker.exe"

exe=temp_directory+"\"+filename_change_ext(pjfile,".exe")

wdir=working_directory
set_working_directory(root)

execute_program(gm,qt+root+pjfile+qt+" --build "+qt+exe+qt,1)
sleep(100)
if (file_exists(exe)) execute_program(exe,"",0)

set_working_directory(wdir)
