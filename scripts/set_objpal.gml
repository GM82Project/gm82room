//sets objpal and updates the hotbar

//check if the object already exists in the palette
i=1 repeat (9) {
    if (objhotbar[i]==argument0) {objpal=argument0 exit}
i+=1}

//check if the palette has empty spots and put it there
i=1 repeat (9) {
    if (objhotbar[i]==noone) {objhotbar[i]=argument0 objpal=argument0 exit}
i+=1}

//put it in the current slot
i=1 repeat (9) {
    if (objhotbar[i]==objpal) {objhotbar[i]=argument0 objpal=argument0 exit}
i+=1}
