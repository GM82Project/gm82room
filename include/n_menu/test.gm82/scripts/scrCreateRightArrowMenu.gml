menu = N_Menu_CreateMenuBar();
right1 = N_Menu_CreatePopupMenu();
right3 = N_Menu_CreatePopupMenu();
rightpopup1 = N_Menu_CreatePopupMenu();
rightpopup2 = N_Menu_CreatePopupMenu();
rightpopup3 = N_Menu_CreatePopupMenu();
rightpopup4 = N_Menu_CreatePopupMenu();
rightpopup5 = N_Menu_CreatePopupMenu();
rightpopup6 = N_Menu_CreatePopupMenu();
rightpopup7 = N_Menu_CreatePopupMenu();

// menu
N_Menu_AddMenu(menu, right1, "right1");
rightok2 = N_Menu_AddItem(menu, "rightok2", "");
N_Menu_AddMenu(menu, right3, "right3");

// right1
N_Menu_AddMenu(right1, rightpopup1, "rightpopup1");
rightok4 = N_Menu_AddItem(right1, "rightok4", "");
N_Menu_AddMenu(right1, rightpopup4, "rightpopup4");

// right3
N_Menu_AddMenu(right3, rightpopup2, "rightpopup2");
N_Menu_AddMenu(right3, rightpopup3, "rightpopup3");
rightok7 = N_Menu_AddItem(right3, "rightok7", "");

// rightpopup1
rightok1 = N_Menu_AddItem(rightpopup1, "rightok1", "");

// rightpopup2
rightok3 = N_Menu_AddItem(rightpopup2, "rightok3", "");

// rightpopup3
rightok5 = N_Menu_AddItem(rightpopup3, "rightok5", "");

// rightpopup4
N_Menu_AddMenu(rightpopup4, rightpopup5, "rightpopup5");
rightok8 = N_Menu_AddItem(rightpopup4, "rightok8", "");
N_Menu_AddMenu(rightpopup4, rightpopup6, "rightpopup6");

// rightpopup5
rightok6 = N_Menu_AddItem(rightpopup5, "rightok6", "");

// rightpopup6
N_Menu_AddMenu(rightpopup6, rightpopup7, "rightpopup7");

// rightpopup7
rightok9 = N_Menu_AddItem(rightpopup7, "rightok9", "");
rightok10 = N_Menu_AddItem(rightpopup7, "rightok10", "");
rightok11 = N_Menu_AddItem(rightpopup7, "rightok11", "");
rightok12 = N_Menu_AddItem(rightpopup7, "rightok12", "");

N_Menu_ItemSetChecked(rightpopup1, rightok1, true);
N_Menu_ItemSetDefault(rightpopup3, rightok5);
N_Menu_ItemSetDisabled(right1, rightok4, true);
N_Menu_ItemSetRadioSelected(rightpopup7, rightok11, rightok10, rightok12);
N_Menu_ItemSetBitmap(rightpopup2, rightok3, face);
N_Menu_ItemSetBitmap(rightpopup5, rightok6, check);
