save_room(0)

gm=program_directory+"\GameMaker.exe"

if (!file_exists(gm)) {
    roaming=directory_previous(directory_previous(directory_previous(temp_directory)))+"Roaming\"

    gm=registry_read_sz("SOFTWARE\Game Maker\Version 8.2\Preferences\Directory")

    if (gm==undefined) {show_message("Error building: Can't find Game Maker 8.2. Please try reinstalling the program.") exit}

    gm+="GameMaker.exe"
}

exe=temp_directory+"\"+filename_change_ext(pjfile,".exe")
if (file_exists(exe)) file_delete(exe)
sleep(1)
while (file_exists(exe)) exe=temp_directory+"\a"+string(irandom_range(100000,999999))+".exe"

wdir=working_directory
set_working_directory(root)

execute_program(gm,qt+root+pjfile+qt+" --build "+qt+exe+qt,1)
sleep(100)
if (file_exists(exe)) execute_program(exe,"",0)

set_working_directory(wdir)
