dir="SOFTWARE\Game Maker\Version 8.2\Preferences\"
registry_write_dword(dir+"GM82CustomThemeIndex",theme)
if (theme==2) {
    registry_write_dword(dir+"GM82CustomThemeColorLow",global.col_low)
    registry_write_dword(dir+"GM82CustomThemeColorMain",global.col_main)
    registry_write_dword(dir+"GM82CustomThemeColorHigh",global.col_high)
    registry_write_dword(dir+"GM82CustomThemeColorText",global.col_text)
    registry_write_dword(dir+"GM82CustomThemeButtonType",themebutton)
}
