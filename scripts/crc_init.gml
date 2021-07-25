//(c) juju adams
//adapted to gm8 by renex
var polynomial,i,crc;

polynomial=$EDB88320

for (i=0;i<=$FF;i+=1) {
    crc=i
    repeat (8) {
        if (crc&1) {
            crc=(crc>>1)^polynomial
        } else {
            crc=crc>>1
        }
    }
    global.crc32table[i]=crc
}
