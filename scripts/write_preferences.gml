dir="SOFTWARE\Game Maker\Version 8.2\Preferences\"
registry_write_dword(dir+"RoomCrosshair",crosshair)
registry_write_dword(dir+"RoomStartMax",startmax)
registry_write_dword(dir+"RoomSmooth",interpolation)
registry_write_dword(dir+"RoomGridOnOffDefault",grid)
registry_write_dword(dir+"RoomTilePickerGrid",tilepickgrid)
if (!seen) registry_write_dword(dir+"NewRoomEditorSeen",1)

registry_write_dword(dir+"GM82CodeEditorType",codeeditortype)
registry_write_dword(dir+"GM82ColorPickerType",colorpickertype)
registry_write_dword(dir+"GM82DrawGridOutsideRoom",outroomgrid)

theme_save()
