dir="SOFTWARE\Game Maker\Version 8.2\Preferences\"
theme=registry_read_dword(dir+"GM82CustomThemeIndex",0)
if (theme==2) {
    global.col_low=registry_read_dword(dir+"GM82CustomThemeColorLow",$203020)
    global.col_main=registry_read_dword(dir+"GM82CustomThemeColorMain",$404040)
    global.col_high=registry_read_dword(dir+"GM82CustomThemeColorHigh",$607060)
    global.col_text=registry_read_dword(dir+"GM82CustomThemeColorText",$ffffff)
    themebutton=median(0,registry_read_dword(dir+"GM82CustomThemeButtonType",1),2)
}
