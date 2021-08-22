dir="SOFTWARE\Game Maker\Version 8.2\Preferences\"
registry_write_dword(dir+"RoomCrosshair",crosshair)
registry_write_dword(dir+"RoomSmooth",interpolation)
registry_write_dword(dir+"RoomGridOnOffDefault",grid)
if (!seen) registry_write_dword(dir+"NewRoomEditorSeen",1)
