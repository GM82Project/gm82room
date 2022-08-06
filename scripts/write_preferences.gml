dir="SOFTWARE\Game Maker\Version 8.2\Preferences\"
registry_write_dword(dir+"RoomCrosshair",crosshair)
registry_write_dword(dir+"RoomSmooth",interpolation)
registry_write_dword(dir+"RoomGridOnOffDefault",grid)
if (!seen) registry_write_dword(dir+"NewRoomEditorSeen",1)

registry_write_dword(dir+"GM82CustomThemeIndex",theme)
if (theme==2) {
    registry_write_dword(dir+"GM82CustomThemeColorLow",global.col_low)
    registry_write_dword(dir+"GM82CustomThemeColorMain",global.col_main)
    registry_write_dword(dir+"GM82CustomThemeColorHigh",global.col_high)
    registry_write_dword(dir+"GM82CustomThemeColorText",global.col_text)
    registry_write_dword(dir+"GM82CustomThemeButtonType",themebutton)
}

registry_write_dword(dir+"GM82CodeEditorType",codeeditortype)
registry_write_dword(dir+"GM82ColorPickerType",colorpickertype)
