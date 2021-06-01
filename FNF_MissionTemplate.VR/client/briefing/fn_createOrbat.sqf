// F3 - ORBAT Notes (Heavily Modified)
// Credits: Please see the F3 online manual (http://www.ferstaberinde.com/f3/en/)
// This script has been modified from it's original form.
// ====================================================================================

_generateORBAT = {
    params ["_groups"];

    private _functionText = "";

    // Loop through the group, print out group ID, leader name and medics if present
    {
        if !((count units _x) isEqualTo 0) then {
            // Don't apply leading line breaks to first group.
            private _groupSize = _x getVariable ["phx_gps_groupSize",0];
            private _name = groupID _x;
            private _longName = _x getVariable ["phx_LongName",groupID _x];
            private _groupString = "";
            private _changeColor = false;

            if (_forEachIndex != 0) then {
                switch (_groupSize) do {
                    case 0: {_groupString = _groupString + format["    "]; _changeColor = false;};
                    case 1: {_groupString = _groupString + format["<br />- %1<br />    ",_longName]; _changeColor = true;};
                    case 2: {_groupString = _groupString + format["<br /><br /><font size='18'>%1</font><br />    ",_longName]; _changeColor = true;};
                    case 3: {_groupString = _groupString + format["<br /><br /><br /><font size='20'>%1</font><br />    ",_longName]; _changeColor = true;};
                };
            } else {
                switch (_groupSize) do {
                    case 0: {_groupString = _groupString + format["    ",_longName]; _changeColor = false;};
                    case 1: {_groupString = _groupString + format["- %1<br />    ",_longName]; _changeColor = true;};
                    case 2: {_groupString = _groupString + format["<font size='18'>%1</font><br />    ",_longName]; _changeColor = true;};
                    case 3: {_groupString = _groupString + format["<font size='20'>%1</font><br />    ",_longName]; _changeColor = true;};
                };
            };

            // Highlight the player's group with a different color (based on the player's side)
            private _highlightColor = "#2AA5A5";

            private _color = "#FFFFFF";
            if (_changeColor) then {
                if (isNil "phx_orbat_lastUsedColor") then {
                    phx_orbat_lastUsedColor = ["#FFFFFF"];
                };
                phx_colorArray = (phx_colorArrayBase - phx_colorArrayUsed);
                if (count phx_colorArray isEqualTo 0) then {
                    phx_colorArrayUsed = [];
                    phx_colorArray = phx_colorArrayBase;
                };
                _color = phx_colorArray select 0;
                phx_colorArrayUsed pushBack _color;
                phx_orbat_lastUsedColor = [_color];
            } else {
                if (isNil "phx_orbat_lastUsedColor") then {
                    phx_orbat_lastUsedColor = ["#FFFFFF"];
                };
                if (count phx_colorArray isEqualTo 0) then {
                    phx_colorArrayUsed = [];
                };
                _color = phx_orbat_lastUsedColor select 0;
            };
            // ACRE
            // Get group's radio frequency
            private _freq = _x getVariable ["phx_radioSettings",nil];
            if (isNil "_freq") then {
                _freq = "UNK";
            } else {
                private _chNum = _freq select 1;
                // _chNum = _chNum - 1; //Minus one since array starts at 0
                _freq = format["CH %1", _chNum];
            };

            // Add group to the ORBAT
            if (isNil "_freq") then {
                _groupString = _groupString + format ["%1 --", _name];
            } else {
                _groupString = _groupString + format ["<font size='16'>%1</font><font size='14'> - %2 </font><font size='12'>- %3 men</font>:  ", _name, _freq, (count units _x)];
            };

            // Add group members
            {
                private _leftPad = " ";
                if !(_forEachIndex isEqualTo 0) then{
                    _leftPad = ", ";
                };
                if (getNumber (configFile >> "CfgVehicles" >> typeOf _x >> "attendant") isEqualTo 1) then {
                    private _colorUsed = _color;
                    if (player isEqualTo _x) then {_colorUsed = _highlightColor};
                    _groupString = _groupString + format["<font size='12'>%2<font color='%3'>%1</font> [M]</font>",name _x,_leftPad,_colorUsed];
                } else {
                    private _colorUsed = _color;
                    if (player isEqualTo _x) then {_colorUsed = _highlightColor};
                    _groupString = _groupString + format["<font size='12'>%2<font color='%3'>%1</font></font>",name _x,_leftPad,_colorUsed];
                };
            } forEach units _x;

            _groupString = _groupString + "<br/>";
            _functionText = _functionText + _groupString;
        };
    } forEach _groups;

    // Return functionText
    _functionText
};

//----------------------------------------------------------------------------------------------------
private _side = side group player;
private _orbatText = "<br />NOTE: This ORBAT is only valid at mission start.<br />
<br />";

phx_colorArrayBase = [
    "#8080FF", // light blue
    "#80FF80", // light green
    "#FF8080", // light red
    "#FFFF80", // light yellow
    "#FF80FF", // light pink
    "#00FFE5", //turquoise
    "#FFC080", // light orange
    "#00FF87", //aquamarine
    "#B960FF", //light purple
    "#FF8181" //beige red
];
phx_colorArray = [];
phx_colorArrayUsed = [];

private _groups = [];
private _templateGroups = [];
private _templateGroupList = [
    "Blue_CC", "Blue_CR", "Blue_P1HQ", "Blue_P2HQ", "Blue_P", "Blue_A", "Blue_A1", "Blue_A2", "Blue_B", "Blue_B1", "Blue_B2", "Blue_C", "Blue_C1", "Blue_C2", "Blue_D", "Blue_D1", "Blue_D2", "Blue_D3", "Blue_D4", "Blue_E", "Blue_E1", "Blue_E2", "Blue_E3", "Blue_E4", "Blue_F", "Blue_F1", "Blue_F2", "Blue_G", "Blue_G1", "Blue_G2", "Blue_G3", "Blue_G4", "Blue_H", "Blue_H1", "Blue_H2", "Blue_H3", "Blue_H4",
    "Red_CC", "Red_CR", "Red_P1HQ", "Red_P2HQ", "Red_P", "Red_A", "Red_A1", "Red_A2", "Red_B", "Red_B1", "Red_B2", "Red_C", "Red_C1", "Red_C2", "Red_D", "Red_D1", "Red_D2", "Red_D3", "Red_D4", "Red_E", "Red_E1", "Red_E2", "Red_E3", "Red_E4", "Red_F", "Red_F1", "Red_F2", "Red_G", "Red_G1", "Red_G2", "Red_G3", "Red_G4", "Red_H", "Red_H1", "Red_H2", "Red_H3", "Red_H4",
    "Green_CC", "Green_CR", "Green_P1HQ", "Green_P2HQ", "Green_P", "Green_A", "Green_A1", "Green_A2", "Green_B", "Green_B1", "Green_B2", "Green_C", "Green_C1", "Green_C2", "Green_D", "Green_D1", "Green_D2", "Green_D3", "Green_D4", "Green_E", "Green_E1", "Green_E2", "Green_E3", "Green_E4", "Green_F", "Green_F1", "Green_F2", "Green_G", "Green_G1", "Green_G2", "Green_G3", "Green_G4", "Green_H", "Green_H1", "Green_H2", "Green_H3", "Green_H4"
];

{
    // Add to ORBAT if side matches, group isn't already listed, and group has players
    private _identity = _x getVariable ["phx_groupIdentifier",groupID _x];
    if ((side _x isEqualTo _side) && {!(_x in _groups)} && {({_x in (switchableUnits + playableUnits)} count units _x) > 0}) then {
        if (_identity in _templateGroupList) then {
            _templateGroups pushBack _x;
        } else {
            _groups pushBack _x;
        };
    };
} forEach allGroups;

// Generate ORBAT text for template groups
private _templateText = [_templateGroups] call _generateORBAT;

// Use next color in the chain when switching between template and non-template groups
if (isNil "phx_orbat_lastUsedColor") then {
    phx_orbat_lastUsedColor = ["#FFFFFF"];
};
phx_colorArray = (phx_colorArrayBase - phx_colorArrayUsed);
if (count phx_colorArray isEqualTo 0) then {
    phx_colorArrayUsed = [];
    phx_colorArray = phx_colorArrayBase;
};
private _color = phx_colorArray select 0;
phx_colorArrayUsed pushBack _color;
phx_orbat_lastUsedColor = [_color];

// Generate ORBAT text for non-template groups
_orbatText = _orbatText + _templateText;
private _groupText = "";
if !(_groups isEqualTo []) then {
    _groupText = [_groups] call _generateORBAT;
};
if !(_groupText isEqualTo "") then {
    _orbatText = _orbatText + "<br/>Attached Units:<br/>" + _groupText;
};

// Insert final result into subsection ORBAT of section Notes
playerORBATRecord = player createDiaryRecord ["ORBAT_Diary", ["Team ORBAT", _orbatText]];
phx_writtenORBAT = true;
