phx_loadout_unitLevel is a variable that tracks the leadership level of the player
phx_loadout_unitLevel = 0 means player is not a PL, SL, TL or MGTL
phx_loadout_unitLevel = 1 means player is a TL or MGTL
phx_loadout_unitLevel = 2 means player is a PL or SL

Most uniform sets have a base set (in the \base\ directory) that is included after all other definitions.
The bases include backpack classes, pilot vest and headgear classes, and crewman helmet class definitions.
You can #include another uniform set into a new set to act as a base for the new set, and then just define changes.
