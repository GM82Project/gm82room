/*

the undo system is a clusterfuck and i hate it. it's hard to understand, and i wish i'd implemented it some other way.
it essentially pushes changes into a list, with some header information if the actions are linked,
so undoing would undo multiple actions in a row until it runs out of linked actions.

the path editor is unfinished, still missing any kind of undo system, could probably just shove the
entire path in the undo stack.

the new autotiler is also missing an undo system currently.

the way it marks the project as modified is kind of weird, it marks it when the undo system has entries.

button tagmode is the mode associated with that button, so 0 = objects 1 = tiles etc.
however, tagmode -2 is used for the special textfields inside the tilepanel.
