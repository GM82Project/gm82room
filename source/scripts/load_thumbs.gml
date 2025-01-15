directory_create(root+"cache")

if (directory_exists(root+"cache\backgrounds") && directory_exists(root+"cache\sprites")) {
    icon_mode=1
} else if (!file_exists(root+"cache\ignore_warning")) {
    if (show_question("Error loading icons: GM82 cache is missing, try to Save As the project to fix this.##You can still edit, but icons won't be displayed for resources.##Would you like to disable this warning?")) {
        file_create(root+"cache\ignore_warning")
    }
}

thumbmap=ds_map_create()

directory_create(program_directory+"\cache")

folder_menuicon=create_menu_bitmap(sprMenuButtons,55)
sprite_menuicon=create_menu_bitmap(sprFieldIcons,5)
sound_menuicon=create_menu_bitmap(sprFieldIcons,6)
background_menuicon=create_menu_bitmap(sprFieldIcons,7)
path_menuicon=create_menu_bitmap(sprFieldIcons,8)
script_menuicon=create_menu_bitmap(sprFieldIcons,9)
font_menuicon=create_menu_bitmap(sprFieldIcons,10)
timeline_menuicon=create_menu_bitmap(sprFieldIcons,11)
object_menuicon=create_menu_bitmap(sprFieldIcons,12)
room_menuicon=create_menu_bitmap(sprFieldIcons,13)
datafile_menuicon=create_menu_bitmap(sprFieldIcons,14)
constant_menuicon=create_menu_bitmap(sprFieldIcons,15)

thumbcount=12
