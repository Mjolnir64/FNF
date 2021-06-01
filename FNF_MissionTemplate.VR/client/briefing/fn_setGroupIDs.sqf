// F3 Set Group IDs
// Credits: Please see the F3 online manual (http://www.ferstaberinde.com/f3/en/)
// This script has been modified from it's original form.
//
// IF YOU GET A MESSAGE SIMILAR TO:
// [setGroupIDs] No radio freq found for group - '%1'
// SEE THE README.MD FILE IN THIS FILE'S FOLDER
// ====================================================================================

_groups = nil;
_groups = [
    // ====================================================================================
    // - format: [group,groupID,phx_LongName,unitSize,radioSettings]
    // group: defined in initialization field of units in editor. Also used as the group's identifier in scripts ex: Red_HQ = group this;
    // groupID: ID given to group for use in things such as GPS, nametags, etc. (string)
    // phx_LongName: Longer version of the groupID used in things such as the radios, etc. (string)
    // unitSize: Number telling what level the group is. Company = 3, Platoon = 2, Squad = 1, Fireteam = 0 (0-3)
    // radioSettings: Tells radio script which channels to set for group. [altChannel,mainChannel,[channelArray]] (array)
    //     343 channel: channel for 343, 152 chan multiplied by 17 + this value.
    //     152 channel: channel for 152, 1-99. multiplied by 17 to determine 343 channel.
    //     117 channel: which LR channel will be tuned if applicable

    // BLUFOR
    ["Blue_CC","CMD","Company Command",3, [0, 1, 1]],

    //1st Platoon
    ["Blue_P1HQ","P1HQ","1st Platoon", 2, [0, 2, 1]],

    //not used
    ["Blue_Pilot","P","Pilots",0, [0.5, 3, 2]],

    ["Blue_A","A","Alpha Squad",1, [0, 3, 2]],
    ["Blue_A1","A1","Alpha One",0, [0.1, 3, 2]],
    ["Blue_A2","A2","Alpha Two",0, [0.2, 3, 2]],

    ["Blue_B","B","Bravo Squad",1, [0, 4, 2]],
    ["Blue_B1","B1","Bravo One",0, [0.1, 4, 2]],
    ["Blue_B2","B2","Bravo Two",0, [0.2, 4, 2]],

    ["Blue_C","C","Charlie Squad",1, [0, 5, 2]],
    ["Blue_C1","C1","Charlie One",0, [0.1, 5, 2]],
    ["Blue_C2","C2","Charlie Two",0, [0.2, 5, 2]],

    //2nd Platoon
    ["Blue_P2HQ","P2HQ","2nd Platoon",2, [0, 6, 1]],

    ["Blue_D","D","Delta Squad",1, [0, 7, 6]],
    ["Blue_D1","D1","Delta One",0, [0.1, 7, 6]],
    ["Blue_D2","D2","Delta Two",0, [0.2, 7, 6]],

    ["Blue_E","E","Echo Squad",1, [0, 8, 6]],
    ["Blue_E1","E1","Echo One",0, [0.1, 8, 6]],
    ["Blue_E2","E2","Echo Two",0, [0.2, 8, 6]],

    ["Blue_F","F","Foxtrot Squad",1, [0, 9, 6]],
    ["Blue_F1","F1","Foxtrot One",0, [0.1, 9, 6]],
    ["Blue_F2","F2","Foxtrot Two",0, [0.2, 9, 6]],

    //Vehicle teams - under Company
    ["Blue_G","G","Golf Squad (Vic)",1, [0, 10, 1]],
    ["Blue_G1","G1","Golf One (Vic)",0, [0.1, 10, 1]],
    ["Blue_G2","G2","Golf Two (Vic)",0, [0.2, 10, 1]],
    ["Blue_G3","G3","Golf Three (Vic)",0, [0.3, 10, 1]],
    ["Blue_G4","G4","Golf Four (Vic)",0, [0.4, 10, 1]],

    //Pilot teams - under Company
    ["Blue_H","H","Hotel Squad (Air)",1, [0, 11, 1]],
    ["Blue_H1","H1","Hotel One (Air)",0, [0.1, 11, 1]],
    ["Blue_H2","H2","Hotel Two (Air)",0, [0.2, 11, 1]],
    ["Blue_H3","H3","Hotel Three (Air)",0, [0.3, 11, 1]],

    // REDFOR
    ["Red_CC","CMD","Company Command",3, [1, 8, [0, 1, 2, 3, 4, 5, 6, .1]] ],
    ["Red_CR","X","X-Ray (Recon)",1, [1, 8, [0, 1, 2, 3, 4, 5, 6, .2]] ],

    //1st Platoon
    ["Red_P1HQ","P1HQ","1st Platoon",2, [2, 1, [0, 1, 2, 3, 4]] ],

    //not used
    ["Red_Pilot","P","Pilots",0, [1, 2, [1, 2, 3, 4, .1]] ],

    ["Red_A","A","Alpha Squad",1, [2, 1, [1, 2, 2.1, 2.2]] ],
    ["Red_A1","A1","Alpha One",0, [2, 1, [2, 2.1, 2.2]] ],
    ["Red_A2","A2","Alpha Two",0, [3, 1, [2, 2.1, 2.2]] ],

    ["Red_B","B","Bravo Squad",1, [2, 1, [1, 3, 3.1, 3.2]] ],
    ["Red_B1","B1","Bravo One",0, [2, 1, [3, 3.1, 3.2]] ],
    ["Red_B2","B2","Bravo Two",0, [3, 1, [3, 3.1, 3.2]] ],

    ["Red_C","C","Charlie Squad",1, [2, 1, [1, 4, 4.1, 4.2]] ],
    ["Red_C1","C1","Charlie One",0, [2, 1, [4, 4.1, 4.2]] ],
    ["Red_C2","C2","Charlie Two",0, [3, 1, [4, 4.1, 4.2]] ],

    //2nd Platoon
    ["Red_P2HQ","P2HQ","2nd Platoon",2, [2, 1, [0, 5, 6, 7, 8]] ],

    ["Red_D","D","Delta Squad",1, [2, 1, [5, 6, 6.1, 6.2]] ],
    ["Red_D1","D1","Delta One",0, [2, 1, [6, 6.1, 6.2]] ],
    ["Red_D2","D2","Delta Two",0, [3, 1, [6, 6.1, 6.2]] ],

    ["Red_E","E","Echo Squad",1, [2, 1, [5, 7, 7.1, 7.2]] ],
    ["Red_E1","E1","Echo One",0, [2, 1, [7, 7.1, 7.2]] ],
    ["Red_E2","E2","Echo Two",0, [3, 1, [7, 7.1, 7.2]] ],

    ["Red_F","F","Foxtrot Squad",1, [2, 1, [5, 8, 8.1, 8.2]] ],
    ["Red_F1","F1","Foxtrot One",0, [2, 1, [8, 8.1, 8.2]] ],
    ["Red_F2","F2","Foxtrot Two",0, [3, 1, [8, 8.1, 8.2]] ],

    //Vehicle teams - under Company
    ["Red_G","G","Golf Squad",1, [2, 1, [0, 9, 9.1, 9.2, 9.3, 9.4]] ],
    ["Red_G1","G1","Golf One",0, [2, 1, [9, 9.1, 9.2, 9.3, 9.4]] ],
    ["Red_G2","G2","Golf Two",0, [3, 1, [9, 9.1, 9.2, 9.3, 9.4]] ],
    ["Red_G3","G3","Golf Three",0, [4, 1, [9, 9.1, 9.2, 9.3, 9.4]] ],
    ["Red_G4","G4","Golf Four",0, [5, 1, [9, 9.1, 9.2, 9.3, 9.4]] ],

    //Pilot teams - under Company
    ["Red_H","H","Hotel Squad (Air)",1, [2, 1, [0, 10, 10.1, 10.2, 10.3]] ],
    ["Red_H1","H1","Hotel One (Air)",0, [2, 1, [10, 10.1, 10.2, 10.3]] ],
    ["Red_H2","H2","Hotel Two (Air)",0, [3, 1, [10, 10.1, 10.2, 10.3]] ],
    ["Red_H3","H3","Hotel Three (Air)",0, [4, 1, [10, 10.1, 10.2, 10.3]] ],

    // INDFOR
    ["Green_CC","CMD","Company Command",3, [1, 8, [0, 1, 2, 3, 4, 5, 6, .1]] ],
    ["Green_CR","X","X-Ray (Recon)",1, [1, 8, [0, 1, 2, 3, 4, 5, 6, .2]] ],

    //1st Platoon
    ["Green_P1HQ","P1HQ","1st Platoon",2, [2, 1, [0, 1, 2, 3, 4]] ],

    //not used
    ["Green_Pilot","P","Pilots",0, [1, 2, [1, 2, 3, 4, .1]] ],

    ["Green_A","A","Alpha Squad",1, [2, 1, [1, 2, 2.1, 2.2]] ],
    ["Green_A1","A1","Alpha One",0, [2, 1, [2, 2.1, 2.2]] ],
    ["Green_A2","A2","Alpha Two",0, [3, 1, [2, 2.1, 2.2]] ],

    ["Green_B","B","Bravo Squad",1, [2, 1, [1, 3, 3.1, 3.2]] ],
    ["Green_B1","B1","Bravo One",0, [2, 1, [3, 3.1, 3.2]] ],
    ["Green_B2","B2","Bravo Two",0, [3, 1, [3, 3.1, 3.2]] ],

    ["Green_C","C","Charlie Squad",1, [2, 1, [1, 4, 4.1, 4.2]] ],
    ["Green_C1","C1","Charlie One",0, [2, 1, [4, 4.1, 4.2]] ],
    ["Green_C2","C2","Charlie Two",0, [3, 1, [4, 4.1, 4.2]] ],

    //2nd Platoon
    ["Green_P2HQ","P2HQ","2nd Platoon",2, [2, 1, [0, 5, 6, 7, 8]] ],

    ["Green_D","D","Delta Squad",1, [2, 1, [5, 6, 6.1, 6.2]] ],
    ["Green_D1","D1","Delta One",0, [2, 1, [6, 6.1, 6.2]] ],
    ["Green_D2","D2","Delta Two",0, [3, 1, [6, 6.1, 6.2]] ],

    ["Green_E","E","Echo Squad",1, [2, 1, [5, 7, 7.1, 7.2]] ],
    ["Green_E1","E1","Echo One",0, [2, 1, [7, 7.1, 7.2]] ],
    ["Green_E2","E2","Echo Two",0, [3, 1, [7, 7.1, 7.2]] ],

    ["Green_F","F","Foxtrot Squad",1, [2, 1, [5, 8, 8.1, 8.2]] ],
    ["Green_F1","F1","Foxtrot One",0, [2, 1, [8, 8.1, 8.2]] ],
    ["Green_F2","F2","Foxtrot Two",0, [3, 1, [8, 8.1, 8.2]] ],

    //Vehicle teams - under Company
    ["Green_G","G","Golf Squad",1, [2, 1, [0, 9, 9.1, 9.2, 9.3, 9.4]] ],
    ["Green_G1","G1","Golf One",0, [2, 1, [9, 9.1, 9.2, 9.3, 9.4]] ],
    ["Green_G2","G2","Golf Two",0, [3, 1, [9, 9.1, 9.2, 9.3, 9.4]] ],
    ["Green_G3","G3","Golf Three",0, [4, 1, [9, 9.1, 9.2, 9.3, 9.4]] ],
    ["Green_G4","G4","Golf Four",0, [5, 1, [9, 9.1, 9.2, 9.3, 9.4]] ],

    //Pilot teams - under Company
    ["Green_H","H","Hotel Squad (Air)",1, [2, 1, [0, 10, 10.1, 10.2, 10.3]] ],
    ["Green_H1","H1","Hotel One (Air)",0, [2, 1, [10, 10.1, 10.2, 10.3]] ],
    ["Green_H2","H2","Hotel Two (Air)",0, [3, 1, [10, 10.1, 10.2, 10.3]] ],
    ["Green_H3","H3","Hotel Three (Air)",0, [4, 1, [10, 10.1, 10.2, 10.3]] ]
];

private ["_grp"];
{
    // Check first if the group exists
    _x params ["_identifier", "_shortName", "_longName", "_groupSize", "_radioArray"];
    _grp = missionNamespace getVariable[_identifier,grpNull];
    if (!isNull _grp) then {
        if !((groupID _grp) isEqualTo _shortName) then {
            _grp setGroupIdGlobal [_shortName,"GroupColor0"];
            _grp setVariable ["phx_groupIDSet",true,true];
        };
        _grp setVariable ["phx_groupIdentifier",_identifier];
        _grp setVariable ["phx_LongName",_longName];
        _grp setVariable ["phx_gps_groupSize",_groupSize];
        _grp setVariable ["phx_radioSettings",_radioArray];
    };
} forEach _groups;

phx_groupIDset = true;
