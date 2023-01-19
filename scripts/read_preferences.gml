dir="SOFTWARE\Game Maker\Version 8.2\Preferences\"
grid=registry_read_dword(dir+"RoomGridOnOffDefault",0)
removeoutside=registry_read_dword(dir+"RemoveOutside",0)
fillwithcolor=registry_read_dword(dir+"FillRoomWithBackground",1)
fillcolor=registry_read_dword(dir+"RoomBackgroundFullColourDefault",$400040)
remember=registry_read_dword(dir+"RememberRoomSettings",0)
crosshair=registry_read_dword(dir+"RoomCrosshair",1)
interpolation=registry_read_dword(dir+"RoomSmooth",1)
codeeditor=registry_read_string_ext(dir,"CodeEditor")
startmax=registry_read_dword(dir+"RoomStartMax",0)
if (!file_exists(codeeditor)) codeeditor="notepad"
seen=registry_read_dword(dir+"NewRoomEditorSeen",0)
codeeditortype=registry_read_dword(dir+"GM82CodeEditorType",0)
colorpickertype=registry_read_dword(dir+"GM82ColorPickerType",0)

tilepickgrid=registry_read_dword(dir+"RoomTilePickerGrid",1)

theme_load()
