globalvar mspal;

//microsoft palette
mspal[ 0]=$ff8080 mspal[ 1]=$ffff80 mspal[ 2]=$80ff80 mspal[ 3]=$00ff80 mspal[ 4]=$80ffff mspal[ 5]=$0080ff mspal[ 6]=$ff80c0 mspal[ 7]=$ff80ff
mspal[ 8]=$ff0000 mspal[ 9]=$ffff00 mspal[10]=$80ff00 mspal[11]=$00ff40 mspal[12]=$00ffff mspal[13]=$0080c0 mspal[14]=$8080c0 mspal[15]=$ff00ff
mspal[16]=$804040 mspal[17]=$ff8040 mspal[18]=$00ff00 mspal[19]=$008080 mspal[20]=$004080 mspal[21]=$8080ff mspal[22]=$800040 mspal[23]=$ff0080
mspal[24]=$800000 mspal[25]=$ff8000 mspal[26]=$008000 mspal[27]=$008040 mspal[28]=$0000ff mspal[29]=$0000a0 mspal[30]=$800080 mspal[31]=$8000ff
mspal[32]=$400000 mspal[33]=$804000 mspal[34]=$004000 mspal[35]=$004040 mspal[36]=$000080 mspal[37]=$000040 mspal[38]=$400040 mspal[39]=$400080
mspal[40]=$000000 mspal[41]=$808000 mspal[42]=$808040 mspal[43]=$808080 mspal[44]=$408080 mspal[45]=$c0c0c0 mspal[46]=$400040 mspal[47]=$ffffff

for (i=0;i<48;i+=1) mspal[i]=rgb_to_bgr(mspal[i])
