//sets objpal and updates the hotbar
var i,j;

//check if the object already exists in the palette, swap if so
i=1 repeat (9) {
    if (objhotbar[i]==argument0) {
    j=1 repeat (9) {
        if (objhotbar[j]==objpal) {objhotbar[i]=objhotbar[j] objhotbar[j]=argument0 objpal=argument0 exit}
    j+=1}
    objpal=argument0 exit}
i+=1}

//check if the palette has empty spots and put it there
i=1 repeat (9) {
    if (objhotbar[i]==noone) {objhotbar[i]=argument0 objpal=argument0 exit}
i+=1}

//put it in the current slot
i=1 repeat (9) {
    if (objhotbar[i]==objpal) {objhotbar[i]=argument0 objpal=argument0 exit}
i+=1}
