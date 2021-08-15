
#define N_Menu_AddItem
if(string(argument2) == string(0)){
    return external_call(global._N_Menu_AddItem,argument0,string(argument1));
}else{
    return external_call(global._N_Menu_AddItem,argument0,string(argument1) + chr(9) + string(argument2));
}

#define N_Menu_AddMenu
return external_call(global._N_Menu_AddMenu,argument0,argument1,argument2);

#define N_Menu_AddSeparator
return external_call(global._N_Menu_AddSeparator,argument0);

#define N_Menu_AttachMenuBar
return external_call(global._N_Menu_AttachMenuBar,argument0,argument1);

#define N_Menu_CheckMenus
return external_call(global._N_Menu_CheckMenus);

#define N_Menu_CleanUp
external_call(global._N_Menu_CleanUp);
external_free(global._N_Menu_Dll);

#define N_Menu_CreateMenuBar
return external_call(global._N_Menu_CreateMenuBar);

#define N_Menu_CreatePopupMenu
return external_call(global._N_Menu_CreatePopupMenu);

#define N_Menu_CreateToolWindow
external_call(global._N_Menu_CreateToolWindow1,argument0,argument1,argument2,argument3);
return external_call(global._N_Menu_CreateToolWindow2,argument4,argument5);

#define N_Menu_DestroyBitmap
return external_call(global._N_Menu_DestroyBitmap,argument0);

#define N_Menu_DestroyMenu
return external_call(global._N_Menu_DestroyMenu,argument0,argument1);

#define N_Menu_DestroyToolWindow
return external_call(global._N_Menu_DestroyToolWindow,argument0);

#define N_Menu_GetMaxBitmapItemHeight
return external_call(global._N_Menu_GetMaxBitmapItemHeight);

#define N_Menu_GetMaxBitmapItemWidth
return external_call(global._N_Menu_GetMaxBitmapItemWidth);

#define N_Menu_GetMenuBarHeight
return external_call(global._N_Menu_GetMenuBarHeight);

#define N_Menu_GetToolWindowDragStyle
return external_call(global._N_Menu_GetToolWindowDragStyle,argument0);

#define N_Menu_GetToolWindowExists
return external_call(global._N_Menu_GetToolWindowExists,argument0);

#define N_Menu_Init
global._N_Menu_Dll = "N_Menu.dll";
global._N_Menu_AddItem = external_define(global._N_Menu_Dll,"N_Menu_AddItem",dll_cdecl,ty_real,2,ty_real,ty_string);
global._N_Menu_AddMenu = external_define(global._N_Menu_Dll,"N_Menu_AddMenu",dll_cdecl,ty_real,3,ty_real,ty_real,ty_string);
global._N_Menu_AddSeparator = external_define(global._N_Menu_Dll,"N_Menu_AddSeparator",dll_cdecl,ty_real,1,ty_real);
global._N_Menu_AttachMenuBar = external_define(global._N_Menu_Dll,"N_Menu_AttachMenuBar",dll_cdecl,ty_real,2,ty_real,ty_real);
global._N_Menu_CheckMenus = external_define(global._N_Menu_Dll,"N_Menu_CheckMenus",dll_cdecl,ty_real,0);
global._N_Menu_CleanUp = external_define(global._N_Menu_Dll,"N_Menu_CleanUp",dll_cdecl,ty_real,0);
global._N_Menu_CreateMenuBar = external_define(global._N_Menu_Dll,"N_Menu_CreateMenuBar",dll_cdecl,ty_real,0);
global._N_Menu_CreatePopupMenu = external_define(global._N_Menu_Dll,"N_Menu_CreatePopupMenu",dll_cdecl,ty_real,0);
global._N_Menu_CreateToolWindow1 = external_define(global._N_Menu_Dll,"N_Menu_CreateToolWindow1",dll_cdecl,ty_real,4,ty_string,ty_real,ty_real,ty_real);
global._N_Menu_CreateToolWindow2 = external_define(global._N_Menu_Dll,"N_Menu_CreateToolWindow2",dll_cdecl,ty_real,2,ty_real,ty_real);
global._N_Menu_DestroyMenu = external_define(global._N_Menu_Dll,"N_Menu_DestroyMenu",dll_cdecl,ty_real,2,ty_real,ty_real);
global._N_Menu_DestroyBitmap = external_define(global._N_Menu_Dll,"N_Menu_DestroyBitmap",dll_cdecl,ty_real,1,ty_real);
global._N_Menu_DestroyToolWindow = external_define(global._N_Menu_Dll,"N_Menu_DestroyToolWindow",dll_cdecl,ty_real,1,ty_real);
global._N_Menu_GetMaxBitmapItemWidth = external_define(global._N_Menu_Dll,"N_Menu_GetMaxBitmapItemWidth",dll_cdecl,ty_real,0);
global._N_Menu_GetMaxBitmapItemHeight = external_define(global._N_Menu_Dll,"N_Menu_GetMaxBitmapItemHeight",dll_cdecl,ty_real,0);
global._N_Menu_GetMenuBarHeight = external_define(global._N_Menu_Dll,"N_Menu_GetMenuBarHeight",dll_cdecl,ty_real,0);
global._N_Menu_GetToolWindowDragStyle = external_define(global._N_Menu_Dll,"N_Menu_GetToolWindowDragStyle",dll_cdecl,ty_real,1,ty_real);
global._N_Menu_GetToolWindowExists = external_define(global._N_Menu_Dll,"N_Menu_GetToolWindowExists",dll_cdecl,ty_real,1,ty_real);
global._N_Menu_Init = external_define(global._N_Menu_Dll,"N_Menu_Init",dll_cdecl,ty_real,1,ty_real);
global._N_Menu_ItemGetChecked = external_define(global._N_Menu_Dll,"N_Menu_ItemGetChecked",dll_cdecl,ty_real,2,ty_real,ty_real);
global._N_Menu_ItemGetDefault = external_define(global._N_Menu_Dll,"N_Menu_ItemGetDefault",dll_cdecl,ty_real,1,ty_real);
global._N_Menu_ItemGetDisabled = external_define(global._N_Menu_Dll,"N_Menu_ItemGetDisabled",dll_cdecl,ty_real,2,ty_real,ty_real);
global._N_Menu_ItemGetText = external_define(global._N_Menu_Dll,"N_Menu_ItemGetText",dll_cdecl,ty_string,2,ty_real,ty_real);
global._N_Menu_ItemSetBitmap = external_define(global._N_Menu_Dll,"N_Menu_ItemSetBitmap",dll_cdecl,ty_real,3,ty_real,ty_real,ty_real);
global._N_Menu_ItemSetChecked = external_define(global._N_Menu_Dll,"N_Menu_ItemSetChecked",dll_cdecl,ty_real,3,ty_real,ty_real,ty_real);
global._N_Menu_ItemSetDefault = external_define(global._N_Menu_Dll,"N_Menu_ItemSetDefault",dll_cdecl,ty_real,2,ty_real,ty_real);
global._N_Menu_ItemSetDisabled = external_define(global._N_Menu_Dll,"N_Menu_ItemSetDisabled",dll_cdecl,ty_real,3,ty_real,ty_real,ty_real);
global._N_Menu_ItemSetRadioSelected = external_define(global._N_Menu_Dll,"N_Menu_ItemSetRadioSelected",dll_cdecl,ty_real,4,ty_real,ty_real,ty_real,ty_real);
global._N_Menu_ItemSetText = external_define(global._N_Menu_Dll,"N_Menu_ItemSetText",dll_cdecl,ty_string,3,ty_real,ty_real,ty_string);
global._N_Menu_LoadBitmap = external_define(global._N_Menu_Dll,"N_Menu_LoadBitmap",dll_cdecl,ty_real,1,ty_string);
global._N_Menu_RemoveItem = external_define(global._N_Menu_Dll,"N_Menu_RemoveItem",dll_cdecl,ty_real,2,ty_real,ty_real);
global._N_Menu_SetGmWindowHandle = external_define(global._N_Menu_Dll,"N_Menu_SetGmWindowHandle",dll_cdecl,ty_real,1,ty_real);
global._N_Menu_ShowPopupMenu = external_define(global._N_Menu_Dll,"N_Menu_ShowPopupMenu",dll_cdecl,ty_real,5,ty_real,ty_real,ty_real,ty_real,ty_real);
global._N_Menu_SetToolWindowDragStyle = external_define(global._N_Menu_Dll,"N_Menu_SetToolWindowDragStyle",dll_cdecl,ty_real,2,ty_real,ty_real);
return external_call(global._N_Menu_Init,window_handle());

#define N_Menu_ItemGetChecked
return external_call(global._N_Menu_ItemGetChecked,argument0,argument1);

#define N_Menu_ItemGetDefault
return external_call(global._N_Menu_ItemGetDefault,argument0);

#define N_Menu_ItemGetDisabled
return external_call(global._N_Menu_ItemGetDisabled,argument0,argument1);

#define N_Menu_ItemGetText
return external_call(global._N_Menu_ItemGetText,argument0,argument1);

#define N_Menu_ItemSetBitmap
return external_call(global._N_Menu_ItemSetBitmap,argument0,argument1,argument2);

#define N_Menu_ItemSetChecked
return external_call(global._N_Menu_ItemSetChecked,argument0,argument1,argument2);

#define N_Menu_ItemSetDefault
return external_call(global._N_Menu_ItemSetDefault,argument0,argument1);

#define N_Menu_ItemSetDisabled
return external_call(global._N_Menu_ItemSetDisabled,argument0,argument1,argument2);

#define N_Menu_ItemSetRadioSelected
return external_call(global._N_Menu_ItemSetRadioSelected,argument0,argument1,argument2,argument3);

#define N_Menu_ItemSetText
return external_call(global._N_Menu_ItemSetText,argument0,argument1,argument2);

#define N_Menu_LoadBitmap
return external_call(global._N_Menu_LoadBitmap,argument0);

#define N_Menu_RemoveItem
return external_call(global._N_Menu_RemoveItem,argument0,argument1);

#define N_Menu_SetGmWindowHandle
return external_call(global._N_Menu_SetGmWindowHandle,argument0);

#define N_Menu_SetToolWindowDragStyle
return external_call(global._N_Menu_SetToolWindowDragStyle,argument0,argument1);

#define N_Menu_ShowPopupMenu
return external_call(global._N_Menu_ShowPopupMenu,argument0,argument1,argument2,argument3,argument4);
