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
remoutside=registry_read_dword(dir+"RemoveOutside",0)

codeeditortype=registry_read_dword(dir+"GM82CodeEditorType",0)
colorpickertype=registry_read_dword(dir+"GM82ColorPickerType",0)

tilepickgrid=registry_read_dword(dir+"RoomTilePickerGrid",1)
outroomgrid=registry_read_dword(dir+"GM82DrawGridOutsideRoom",1)
do_autosaves=registry_read_dword(dir+"GM82RoomAutosave",1)
hide3dgizmo=registry_read_dword(dir+"GM82RoomHide3dGizmo",0)
cropbackgrounds=registry_read_dword(dir+"GM82RoomCropBackgrounds",1)
swaprmb=registry_read_dword(dir+"GM82RoomSwapRMB",1)
rmbalwaysdel=registry_read_dword(dir+"GM82RoomRMBAlwaysDel",0)
skipwarnings=registry_read_dword(dir+"GM82RoomSkipWarnings",0)
skiprecenter=registry_read_dword(dir+"GM82RoomSkipRecenter",0)
dotilecrop=registry_read_dword(dir+"GM82RoomDoTileCrop",1)

screen_grid_width=registry_read_dword(dir+"GM82RoomScreenGridWidth",registry_read_dword(dir+"DefRoomW",800))
screen_grid_height=registry_read_dword(dir+"GM82RoomScreenGridHeight",registry_read_dword(dir+"DefRoomH",608) )
screen_grid_draw=registry_read_dword(dir+"GM82RoomScreenGridDraw",0)
nodescpreview=registry_read_dword(dir+"GM82RoomNoDescPreview",0)

for (i=0;i<16;i+=1) customcolors[i]=registry_read_dword(dir+"RoomCustomColors"+string(i),0)

theme_load()
