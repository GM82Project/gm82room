#define GMEXPORT extern "C" __declspec(dllexport)
#include <windows.h>

#define BASE_MENU_ID 2000

HWND hGmWnd;
WNDPROC oldGmWndProc;
double menuItem;

struct HandleList {
    HANDLE* handles;
    unsigned int count;
    unsigned int max;
};

HandleList menus;

unsigned int menuId = BASE_MENU_ID;

HandleList bitmaps;

HandleList toolWnds;

struct ToolWndData{
    const char* caption;
    int x;
    int y;
    int width;
};

struct ToolWndDragInfo{
    bool useDragRect;
    bool dragging;
    POINT startPt;
    RECT startRect;
    RECT oldRect;
};

ToolWndData toolData;

const char TOOLWND_CLASS_NAME[] = "N_Menu Tool Window Class";

void InitHandleList(HandleList* list){
    list->handles = NULL;
    list->count = 0;
    list->max = 0;
}

void AddHandle(HandleList* list,HANDLE handle){
    unsigned int index = list->count;
    list->count++;
    if(list->count > list->max){
        list->max+=512;
        list->handles = (HANDLE*)realloc(list->handles,list->max * sizeof(HANDLE));
    }
    list->handles[index] = handle;
}

#define HANDLE_NOT_FOUND 0xFFFFFFFFu
unsigned int FindHandleIndex(HandleList* list,HANDLE handle){
    for(unsigned int i = 0; i < list->count; i++){
        if(list->handles[i] == handle){
            return i;
        }
    }
    return HANDLE_NOT_FOUND;
}

void RemoveHandleIndex(HandleList* list,unsigned int index){
    list->count--;
    if(index != list->count){
        list->handles[index] = list->handles[list->count];
    }
}

void RemoveHandle(HandleList* list,HANDLE handle){
    unsigned int index = FindHandleIndex(list,handle);
    if(index != HANDLE_NOT_FOUND){
        RemoveHandleIndex(list,index);
    }
}

void ClearHandleList(HandleList* list){
    free(list->handles);
    InitHandleList(list);
}

HMENU GetMenu(HandleList* list,unsigned int index){
    return (HMENU)list->handles[index];
}

HBITMAP GetBitmap(HandleList* list,unsigned int index){
    return (HBITMAP)list->handles[index];
}

HWND GetWindow(HandleList* list,unsigned int index){
    return (HWND)list->handles[index];
}

LRESULT HandleNcActivate(HWND h,WPARAM w,LPARAM l){
    bool active = w ? true : false;
    for(unsigned int i = 0; i < toolWnds.count; i++){
        if((HWND)l == GetWindow(&toolWnds,i) || (HWND)l == hGmWnd){
            active = true;
            break;
        }
    }
    if((HWND)l == (HWND)-1){
        return DefWindowProc(h,WM_NCACTIVATE,active,0);
    }
    for(unsigned int i = 0; i < toolWnds.count; i++){
        if(GetWindow(&toolWnds,i) != h && GetWindow(&toolWnds,i) != (HWND)l){
            SendMessage(GetWindow(&toolWnds,i),WM_NCACTIVATE,active,(long)-1);
        }
    }
    if(hGmWnd != h && hGmWnd != (HWND)l){
        SendMessage(hGmWnd,WM_NCACTIVATE,active,(long)-1);
    }
    return DefWindowProc(h,WM_NCACTIVATE,active,l);
}

LRESULT HandleEnable(HWND h,WPARAM w,LPARAM l){
    for(unsigned int i = 0; i < toolWnds.count; i++){
        if(GetWindow(&toolWnds,i) != h){
            EnableWindow(GetWindow(&toolWnds,i),w ? true : false);
        }
    }
    return DefWindowProc(h,WM_ENABLE,w,l);
}

void DrawXorFrame(HWND h,RECT* rect){
    static WORD bitmap[] = {
        0x00AA,0x0055,0x00AA,0x0055,0x00AA,0x0055,0x00AA,0x0055
    };
    HDC hDC;
    HBITMAP hBitmap;
    HBRUSH hBrush;
    HANDLE hBrushOld;
    int border = 3;
    hDC = GetDC(0);
    int x = rect->left;
    int y = rect->top;
    int width = rect->right - rect->left;
    int height = rect->bottom - rect->top;
    hBitmap = CreateBitmap(8,8,1,1,bitmap);
    hBrush = CreatePatternBrush(hBitmap);
    SetBrushOrgEx(hDC,x,y,0);
    hBrushOld = SelectObject(hDC,hBrush);
    PatBlt(hDC,x + border,y,width - border,border,PATINVERT);
    PatBlt(hDC,x + width - border,y+border,border,height - border,PATINVERT);
    PatBlt(hDC,x,y + height - border,width - border,border,PATINVERT);
    PatBlt(hDC,x,y,border,height - border,PATINVERT);
    SelectObject(hDC,hBrushOld);
    DeleteObject(hBrush);
    DeleteObject(hBitmap);
    ReleaseDC(0,hDC);
}

LRESULT CALLBACK GmWndProc(HWND h,UINT u,WPARAM w,LPARAM l){
    switch(u){
        case WM_COMMAND:
            menuItem = LOWORD(w);
            return CallWindowProc(oldGmWndProc,h,u,w,l);
        break;
        case WM_ENABLE:
            return HandleEnable(h,w,l);
        break;
        case WM_NCACTIVATE:
            return HandleNcActivate(h,w,l);
        break;
    }
    return CallWindowProc(oldGmWndProc,h,u,w,l);
}

LRESULT CALLBACK hToolWndProc(HWND h,UINT u,WPARAM w,LPARAM l){
    switch(u){
        case WM_COMMAND:
            SendMessage(hGmWnd,WM_COMMAND,w,l);
        break;
        case WM_KEYDOWN:
            SendMessage(hGmWnd,WM_KEYDOWN,w,l);
        break;
        case WM_KEYUP:
            SendMessage(hGmWnd,WM_KEYUP,w,l);
        break;
        case WM_CHAR:
            SendMessage(hGmWnd,WM_CHAR,w,l);
        break;
        case WM_NCACTIVATE:
            return HandleNcActivate(h,w,l);
        break;
        case WM_NCLBUTTONDOWN:
            ToolWndDragInfo* dragInfo;
            dragInfo = reinterpret_cast<ToolWndDragInfo*>(GetWindowLongPtr(h,GWLP_USERDATA));
            if(dragInfo->useDragRect && w == HTCAPTION){
                SetWindowPos(h,HWND_TOP,0,0,0,0,SWP_NOMOVE | SWP_NOSIZE);
                GetWindowRect(h,&dragInfo->startRect);
                DrawXorFrame(h,&dragInfo->startRect);
                GetCursorPos(&dragInfo->startPt);
                SetCapture(h);
                dragInfo->dragging = true;
                dragInfo->oldRect = dragInfo->startRect;
                return 0;
            }
        break;
        case WM_LBUTTONUP:
            dragInfo = reinterpret_cast<ToolWndDragInfo*>(GetWindowLongPtr(h,GWLP_USERDATA));
            if(dragInfo->useDragRect && dragInfo->dragging){
                dragInfo->dragging = false;
                DrawXorFrame(h,&dragInfo->oldRect);
                POINT pt;
                RECT dragRect;
                GetCursorPos(&pt);
                CopyRect(&dragRect,&dragInfo->startRect);
                OffsetRect(&dragRect,pt.x - dragInfo->startPt.x,pt.y - dragInfo->startPt.y);
                SetWindowPos(h,0,dragInfo->oldRect.left,dragInfo->oldRect.top,0,0,SWP_NOSIZE | SWP_NOACTIVATE | SWP_NOZORDER | SWP_DRAWFRAME | SWP_NOSENDCHANGING);
                ReleaseCapture();
            }
        break;
        case WM_MOUSEMOVE:
            dragInfo = reinterpret_cast<ToolWndDragInfo*>(GetWindowLongPtr(h,GWLP_USERDATA));
            if(dragInfo->useDragRect && dragInfo->dragging){
                POINT pt;
                RECT dragRect;
                GetCursorPos(&pt);
                CopyRect(&dragRect,&dragInfo->startRect);
                OffsetRect(&dragRect,pt.x - dragInfo->startPt.x,pt.y - dragInfo->startPt.y);
                if(!EqualRect(&dragRect,&dragInfo->oldRect)){
                    DrawXorFrame(h,&dragInfo->oldRect);
                    DrawXorFrame(h,&dragRect);
                }
                dragInfo->oldRect = dragRect;
            }
        break;
        case WM_DESTROY:
            dragInfo = reinterpret_cast<ToolWndDragInfo*>(GetWindowLongPtr(h,GWLP_USERDATA));
            delete dragInfo;
            RemoveHandle(&toolWnds,h);
        break;
    }
    return DefWindowProc(h,u,w,l);
}

/*! \mainpage N_Menu
    N_Menu is a fast, easy to use Windows API menu toolkit for Game Maker. It supports
    item icons, check items, radio buttons, default items, sub menus, tool windows which
    can have menus placed on them, and much more!<br><br>
    You can find a list of functions <a class="el" href="group___n___menu.html">
    here</a>. */

//! \defgroup N_Menu N_Menu functions

/*! \ingroup N_Menu
    This function adds an item to a menu and returns the ID of the added item
    which is returned by N_Menu_CheckMenus() whenever the item was selected. 
    Returns 0 if the function fails for any reason.*/
GMEXPORT double N_Menu_AddItem(double menu,const char* text){
    if(AppendMenu((HMENU)(DWORD)menu,MF_STRING,menuId,text)){
        return(menuId++);
    }else{
        return(0);
    }
}

/*! \ingroup N_Menu
    Adds a menu to another menu. The first parameter can be either a menu bar or
    another menu (for a submenu). Returns the ID of the menu that was added, or 
    0 if the function fails for any reason. */
GMEXPORT double N_Menu_AddMenu(double menuTo,double menuFrom,const char* text){
    if(AppendMenu((HMENU)(DWORD)menuTo,MF_STRING | MF_POPUP,(UINT)menuFrom,text)){
        return(menuFrom);
    }else{
        return(0);
    }
}

/*! \ingroup N_Menu
    Adds a separator to a menu (it cannot be used on a menu bar). This function
    returns the ID of the separator on sucess and 0 if it fails for any reason.*/
GMEXPORT double N_Menu_AddSeparator(double menu){
    if(AppendMenu((HMENU)(DWORD)menu,MF_SEPARATOR,menuId++,"")){
        return(menuId++);
    }else{
        return(0);
    }
}

/*! \ingroup N_Menu
    Attaches a menu bar to windows that have no menu bar, and removes and
    destroys the menu bar of windows that have a menu bar. parent must not be 0! */
GMEXPORT double N_Menu_AttachMenuBar(double parent,double menu){
    HMENU hOldMenu = GetMenu((HWND)(DWORD)parent);
    if(hOldMenu != NULL){
        SetMenu((HWND)(DWORD)parent,(HMENU)NULL);
        DestroyMenu(hOldMenu);
    }
    return SetMenu((HWND)(DWORD)parent,(HMENU)(DWORD)menu);
}

/*! \ingroup N_Menu
    Call this every step. If no menu item was selected, 0 is returned. If there was,
    the ID of the seleted item is returned. */
GMEXPORT double N_Menu_CheckMenus(){
    double temp = menuItem;
    menuItem = 0;
    return temp;
}

/*! \ingroup N_Menu
    Call this either when you are done using N_Menu or at the end of the game.
    You MUST call this function to clean up resources! Note: This function is
    not availible in the extension version because all initialization and
    cleanup are done automatically from the extension. */
GMEXPORT double N_Menu_CleanUp(){
    if(!SetMenu(hGmWnd,0)){
        return 0;
    }
    SetWindowLong(hGmWnd,GWL_WNDPROC,(long)oldGmWndProc);
    for(unsigned int i = 0; i < menus.count; i++){
        if(IsMenu(GetMenu(&menus,i))){
            DestroyMenu(GetMenu(&menus,i));
        }
    }
    ClearHandleList(&menus);
    menuId = BASE_MENU_ID;
    for(unsigned int i = 0; i < bitmaps.count; i++){
        DeleteObject(GetBitmap(&bitmaps,i));
    }
    ClearHandleList(&bitmaps);
    for(unsigned int i = 0; i < toolWnds.count; i++){
        if(IsWindow(GetWindow(&toolWnds,i))){
            DestroyWindow(GetWindow(&toolWnds,i));
            i--;                                    // hToolWndProc removes window from toolWnds
        }
    }
    ClearHandleList(&toolWnds);
    UnregisterClass(TOOLWND_CLASS_NAME,GetModuleHandle(0));
    return 1;
}

/*! \ingroup N_Menu
    This function creates a menu bar and returns a handle to it. */
GMEXPORT double N_Menu_CreateMenuBar(){
    HMENU menu = CreateMenu();
    AddHandle(&menus,menu);
    return(DOUBLE)(DWORD)menu;
}

/*! \ingroup N_Menu
    This function creates a popup menu and returns a handle to it. Popup menus
    can be attached to menu bars or to another popup menu as a submenu. */
GMEXPORT double N_Menu_CreatePopupMenu(){
    HMENU menu = CreatePopupMenu();
    AddHandle(&menus,menu);
    return(DOUBLE)(DWORD)menu;
}

/*! \ingroup N_Menu
    This function creates a tool window which a menu can be attached to. If dragStyle is
    true, the window will use the xor rectangle drag style common to older windows sytems
    instead of standard drag style. */
double N_Menu_CreateToolWindow(const char* caption,double x,double y, double width, double height,double dragStyle){
    return 0;
}

GMEXPORT double N_Menu_CreateToolWindow1(const char* caption,double x,double y,double width){
    toolData.caption = caption;
    toolData.x = (int)x;
    toolData.y = (int)y;
    toolData.width = (int)width;
    return 0;
}

GMEXPORT double N_Menu_CreateToolWindow2(double height,double dragStyle){
    RECT tempRect = { 0,0,toolData.width,height == -1 ? GetSystemMetrics(SM_CYMENU) : (int)height };
    AdjustWindowRectEx(&tempRect,WS_VISIBLE | WS_POPUP | WS_SYSMENU | WS_CAPTION,FALSE,WS_EX_TOOLWINDOW);
    HWND window = CreateWindowEx(WS_EX_TOOLWINDOW,TOOLWND_CLASS_NAME,toolData.caption,
        WS_VISIBLE | WS_POPUP | WS_SYSMENU | WS_CAPTION | WS_CLIPCHILDREN | WS_CLIPSIBLINGS,
        toolData.x,toolData.y,tempRect.right - tempRect.left,tempRect.bottom - tempRect.top,hGmWnd,NULL,GetModuleHandle(0),NULL);
    SetWindowPos(window,HWND_TOP,0,0,0,0,SWP_NOMOVE | SWP_NOSIZE | SWP_NOACTIVATE);
    SendMessage(hGmWnd,WM_NCACTIVATE,true,(LPARAM)window);
    ToolWndDragInfo* dragInfo = new ToolWndDragInfo;
    dragInfo->useDragRect = dragStyle > 0 ? true : false;
    dragInfo->dragging = false;
    SetWindowLongPtr(window,GWLP_USERDATA,(long)dragInfo);
    AddHandle(&toolWnds,window);
    return(double)(DWORD)window;
}

/*! \ingroup N_Menu
    Deletes a bitmap previously created with N_Menu_LoadBitmap. */
GMEXPORT double N_Menu_DestroyBitmap(double bitmap){
    for(unsigned int i = 0; i < bitmaps.count; i++){
        if(GetBitmap(&bitmaps,i) == (HBITMAP)(DWORD)bitmap){
            DeleteObject(GetBitmap(&bitmaps,i));
            DrawMenuBar(hGmWnd);
            RemoveHandleIndex(&bitmaps,i);
            i--;
        }
    }
    return 0;
}

/*! \ingroup N_Menu
    Destroys a menu previously created with N_Menu_CreatePopupMenu. If the menu
    was in a menu bar, it is first removed from its parent and then destroyed.
    If you're trying to remove a submenu from another menu, you should use
    N_Menu_RemoveItem instead. If the menu does not have a parent (ex a
    right click menu) pass 0 for the parent. */
GMEXPORT double N_Menu_DestroyMenu(double parent,double menu){
    for(unsigned int i = 0; i < menus.count; i++){
        if(GetMenu(&menus,i) == (HMENU)(DWORD)menu){
            DestroyMenu(GetMenu(&menus,i));
            DrawMenuBar(hGmWnd);
            RemoveHandleIndex(&menus,i);
            i--;
        }
    }
    return 0;
}

/*! \ingroup N_Menu
    Destroys a tool window previously created with N_Menu_CreateToolWindow. */
GMEXPORT double N_Menu_DestroyToolWindow(double wnd){
    if(IsWindow((HWND)(DWORD)wnd)){
        return DestroyWindow((HWND)(DWORD)wnd);
    }
    return 0;
}

/*! \ingroup N_Menu
    Returns the maximum width of a menu item bitmap. */
GMEXPORT double N_Menu_GetMaxBitmapItemWidth(){
    return LOWORD(GetMenuCheckMarkDimensions());
}

/*! \ingroup N_Menu
    Returns the maximum height of a menu item bitmap. */
GMEXPORT double N_Menu_GetMaxBitmapItemHeight(){
    return HIWORD(GetMenuCheckMarkDimensions());
}

/*! \ingroup N_Menu
    Returns the height of a Windows menu bar on the current operating system and with
    the current theme. */
GMEXPORT double N_Menu_GetMenuBarHeight(){
    return(double)GetSystemMetrics(SM_CYMENU);
}

/*! \ingroup N_Menu
    Returns true if the tool window is using the rectangle style dragging. The function
    returns false if the window is using traditional Windows style dragging. */
GMEXPORT double N_Menu_GetToolWindowDragStyle(double toolWnd,double dragStyle){
    ToolWndDragInfo* dragInfo = (ToolWndDragInfo*)GetWindowLongPtr((HWND)(DWORD)toolWnd,GWLP_USERDATA);
    return dragInfo->useDragRect;
}

/*! \ingroup N_Menu
    Returns whether or not a tool window exists. Useful for triggering some event
    if the window is closed. */
GMEXPORT double N_Menu_GetToolWindowExists(double toolWnd){
    return IsWindow((HWND)(DWORD)toolWnd) ? 1 : 0;
}

/*! \ingroup N_Menu
    Initializes N_Menu. Be sure to pass the Game Maker window handle! Note: This
    function is not availible in the extension version because all initialization
    and cleanup are done automatically from the extension. */
GMEXPORT double N_Menu_Init(double wnd){
    hGmWnd = (HWND)(DWORD)wnd;
    oldGmWndProc = (WNDPROC)SetWindowLong(hGmWnd,GWL_WNDPROC,(long)GmWndProc);
    WNDCLASSEX wndClassEx;
    ZeroMemory(&wndClassEx,sizeof(wndClassEx));
    wndClassEx.cbSize = sizeof(wndClassEx);
    wndClassEx.style = 0;
    wndClassEx.lpfnWndProc = hToolWndProc;
    wndClassEx.cbClsExtra = 0;
    wndClassEx.cbWndExtra = 0;
    wndClassEx.hInstance = GetModuleHandle(0);
    wndClassEx.hIcon = 0;
    wndClassEx.hCursor = LoadCursor(NULL,IDC_ARROW);
    wndClassEx.hbrBackground = (HBRUSH)(COLOR_BTNFACE+1);
    wndClassEx.lpszMenuName    = 0;
    wndClassEx.lpszClassName = TOOLWND_CLASS_NAME;
    wndClassEx.hIconSm = 0;
    if(!RegisterClassEx(&wndClassEx)){
        return 0;
    }
    InitHandleList(&menus);
    InitHandleList(&bitmaps);
    InitHandleList(&toolWnds);
    return 1;
}

/*! \ingroup N_Menu
    Returns true if the menu item is checked, otherwise false. */
GMEXPORT double N_Menu_ItemGetChecked(double menu,double item){
    return(GetMenuState((HMENU)(DWORD)menu,(UINT)item,MF_BYCOMMAND) == MF_CHECKED ? 1 : 0);
}

/*! \ingroup N_Menu
    Returns true if the menu item is set as default, false otherwise. */
GMEXPORT double N_Menu_ItemGetDefault(double menu){
    return GetMenuDefaultItem((HMENU)(DWORD)menu,FALSE,GMDI_USEDISABLED);
}

/*! \ingroup N_Menu
    Returns true if the menu item is disabled, false otherwise. */
GMEXPORT double N_Menu_ItemGetDisabled(double menu,double item){
    return(EnableMenuItem((HMENU)(DWORD)menu,(UINT)item,MF_BYCOMMAND) == MF_ENABLED ? 0 : 1);
}

/*! \ingroup N_Menu
    This function returns the text of the menu item. */
GMEXPORT char* N_Menu_ItemGetText(double menu,double item){
    static char text[1024];
    if(GetMenuString((HMENU)(DWORD)menu,(UINT)item,text,1023,MF_BYCOMMAND)){
        return text;
    }
    return "";
}

/*! \ingroup N_Menu
    This function sets the bitmap of a menu item. This must be a bitmap loaded with
    N_Menu_LoadBitmap, it cannot be a sprite! */
GMEXPORT double N_Menu_ItemSetBitmap(double menu,double item,double bitmap){
    return SetMenuItemBitmaps((HMENU)(DWORD)menu,(UINT)item,MF_BYCOMMAND,(HBITMAP)(DWORD)bitmap,(HBITMAP)(DWORD)bitmap);
}

/*! \ingroup N_Menu
    If checked is true, this will check the menu item. If it is false, the menu item
    will be unchecked. */
GMEXPORT double N_Menu_ItemSetChecked(double menu,double item,double checked){
    CheckMenuItem((HMENU)(DWORD)menu,(UINT)item,MF_BYCOMMAND | (checked ? MF_CHECKED : MF_UNCHECKED));
    return checked;
}

/*! \ingroup N_Menu
    This function sets a menu item as the default item for the menu. If 0 is passed
    and an item in the menu is set as default, it will be returned to the normal state. */
GMEXPORT double N_Menu_ItemSetDefault(double menu,double item){
    return SetMenuDefaultItem((HMENU)(DWORD)menu,(UINT)item,FALSE);
}

/*! \ingroup N_Menu
    If disabled is true, the menu item will be disabled. If it is false, it will be
    enabled. */
GMEXPORT double N_Menu_ItemSetDisabled(double menu,double item,double disabled){
    return EnableMenuItem((HMENU)(DWORD)menu,(UINT)item,MF_BYCOMMAND | (disabled ? MF_GRAYED | MF_DISABLED : MF_ENABLED));
}

/*! \ingroup N_Menu
    This sets an item as selected radio style. Pass the first and last item in the radio
    group in the first and last arguements. */
GMEXPORT double N_Menu_ItemSetRadioSelected(double menu,double item,double first,double last){
    return CheckMenuRadioItem((HMENU)(DWORD)menu,(UINT)first,(UINT)last,(UINT)item,MF_BYCOMMAND);
}

/*! \ingroup N_Menu
    This function sets the text of a menu item. */
GMEXPORT char* N_Menu_ItemSetText(double menu,double item,const char* text){
    ModifyMenu((HMENU)(DWORD)menu,(UINT)item,MF_BYCOMMAND,(UINT)item,text);
    return "";
}

/*! \ingroup N_Menu
    This function loads a bitmap with the filename fileName and returns its handle.
    This HAS to be a bitmap (.bmp) file! */
GMEXPORT double N_Menu_LoadBitmap(const char* fileName){
    HBITMAP bitmap = (HBITMAP)LoadImageA(NULL,fileName,IMAGE_BITMAP,0,0,LR_LOADFROMFILE | LR_CREATEDIBSECTION);
    AddHandle(&bitmaps,bitmap);
    return (double)(DWORD)bitmap;
}

/*! \ingroup N_Menu
    This function removes an item or submenu from a menu. It can also be used to
    remove a popup menu from a menu bar. When removing a submenu from a menu or
    a popup menu from a menu bar, this function automatically destroys it and
    frees its memory, so N_Menu_DestroyMenu should not be called for the removed
    menu. */
GMEXPORT double N_Menu_RemoveItem(double parent,double item){
    DeleteMenu((HMENU)(DWORD)parent,(UINT)item,MF_BYCOMMAND);
    DrawMenuBar(hGmWnd);
    return 0;
}

/*! \ingroup N_Menu
    Here you can change the N_Menu's internally stored handle to the Game Maker window.
    That handle is the one you passed in N_Menu_Init. */
GMEXPORT double N_Menu_SetGmWindowHandle(double handle){
    hGmWnd = (HWND)(DWORD)handle;
    oldGmWndProc = (WNDPROC)SetWindowLong(hGmWnd,GWL_WNDPROC,(long)GmWndProc);
    return 0;
}

/*! \ingroup N_Menu
    This function sets the drag style of a tool window. If dragStyle is true, the tool
    window will use rectangle style dragging. If it is false, normal Windows style
    dragging will be used. */
GMEXPORT double N_Menu_SetToolWindowDragStyle(double toolWnd,double dragStyle){
    ToolWndDragInfo* dragInfo = (ToolWndDragInfo*)GetWindowLongPtr((HWND)(DWORD)toolWnd,GWLP_USERDATA);
    dragInfo->useDragRect = dragStyle > 0 ? true : false;
    return 0;
}

/*! \ingroup N_Menu
    This function shows a popup menu created with N_Menu_CreatePopupMenu at the
    specified location. If type is 1, the menu will be center aligned on the cursor.
    If it is 2, it will be right aligned, and if it is 3, it will be left aligned.
    Pass 0 for the default (whatever is best). */
GMEXPORT double N_Menu_ShowPopupMenu(double parent,double menu,double x,double y,double type){
    UINT flags;
    switch((INT)type){
        case 1:
            flags = TPM_CENTERALIGN;
        break;
        case 2:
            flags = TPM_RIGHTALIGN;
        break;
        default:
            flags = TPM_LEFTALIGN;
        break;
    }
    TrackPopupMenu((HMENU)(DWORD)menu,flags,(INT)x,(INT)y,0,(HWND)(DWORD)parent,NULL);
    return 0;
}
