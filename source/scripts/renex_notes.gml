/*

the undo system works by pushing values into a list, and then pushing that list into a stack.
when an undo action has multiple packets, they are marked as linked, so that undoing would
keep going through packets in a row until it runs out of linked packets.

the path editor is unfinished, still missing any kind of undo system, could probably just shove the
entire path in the undo stack.

the new autotiler is also missing an undo system currently.

the way it marks the project as modified is kind of weird, it marks it when the undo system has entries.

button tagmode is the mode associated with that button, so 0 = objects 1 = tiles etc.
however, tagmode -2 is used for the special textfields inside the tilepanel.
