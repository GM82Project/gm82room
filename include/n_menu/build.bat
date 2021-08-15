call "%VS120COMNTOOLS%vsvars32.bat"

cl N_Menu.cpp /O2 /GS- /nologo /link gdi32.lib user32.lib /nologo /dll /out:N_Menu.dll

pause