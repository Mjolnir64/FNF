//Figure out which side the player is on.
_side = playerSide;
switch (_side) do {
    case east: { phx_playerBaseChannel = phx_opforBaseChannel; };
    case west: { phx_playerBaseChannel = phx_bluforBaseChannel; };
    case independent: { phx_playerBaseChannel = phx_indforBaseChannel; };
    case civilian: {phx_playerBaseChannel = phx_civilianBaseChannel; };
    default { titleText ["The game thinks you aren't one of the three teams!","PLAIN"]; };
};
//Error message
if (isNil "phx_playerBaseChannel") exitWith {titleText ["Error! Default radio channels will not be set!","PLAIN DOWN",0.5];};
/*
phx_ch1 = phx_playerBaseChannel; //All players will be able to switch to channel 1 to get on platoon net.
*/

[{!(isNull findDisplay 46) && !(isNull player) && ([] call acre_api_fnc_isInitialized) && (getClientState == "BRIEFING READ")}, {}] call CBA_fnc_waitUntilAndExecute;
call phx_fnc_radio_ACREsetup;

//Generate Mission Notes
_radioSettings = (group player) getVariable ["phx_radioSettings",[1,1]];
// _groupSize = (group player) getVariable ["phx_gps_groupSize",0];
phx_117Chan = _radioSettings select 2;
phx_152Chan = _radioSettings select 1;

_offset343 = 0;
if (_radioSettings # 0 isEqualTo 0) then {
	_offset343 = 0;
} else {
	_offset343 = ((_radioSettings # 0) * 10);
};
phx_343Chan = ((phx_152Chan - 1) * 16) + 1 + _offset343;


phx_radioNoteString = [];
if (phx_loadout_unitLevel >= 1) then {
	phx_radioNoteString pushBack "<br/><font size='20'>PRC-152 Leader Radio</font><br/>";
	{
		phx_radioNoteString pushBack (format["Channel %1: <font color='#90ee90'>%2</font><br/>", _forEachIndex + 1, _x # 0]);
	} forEach channelsArr_152;
};
if (phx_loadout_unitLevel >= 2) then {
	phx_radioNoteString pushBack "<br/><font size='20'>PRC-117F Manpack Radio</font><br/>";
	{
		phx_radioNoteString pushBack (format["Channel %1: <font color='#90ee90'>%2</font><br/>", _forEachIndex + 1, _x # 0]);
	} forEach channelsArr_117;
};

//Let player know what channels he starts on.
PHX_Diary_Radio = player createDiarySubject ["PHX_Diary_Radio", "Radio Preset"];
private _cur152 = channelsArr_152 select {_x # 1 == phx_152Chan};
private _cur117 = channelsArr_117 select {_x # 1 == phx_117Chan};


phx_radioNoteString pushBack "<br/><font size='20'>Your Pre-Tuned Channels</font><br/>";
if (phx_loadout_unitLevel >= 0) then {
	phx_radioNoteString pushBack format["<br/>PRC-343 Rifleman Radio (center): <font color='#90ee90'>BLOCK %1 CH %2 (Your Group)</font>", phx_152Chan, _offset343 + 1];
};
if (phx_loadout_unitLevel >= 1) then {
	phx_radioNoteString pushBack format["<br/>PRC-152 Standard Radio (left ear): <font color='#90ee90'>CH %1 (%2)</font>", (_cur152 # 0 # 1), _cur152 # 0 # 0];
};
if (phx_loadout_unitLevel >= 2) then {
	phx_radioNoteString pushBack format["<br/>PRC-117F Manpack Radio (right ear): <font color='#90ee90'>CH %1 (%2)</font>", (_cur117 # 0 # 1), _cur117 # 0 # 0];
};

player createDiaryRecord ["PHX_Diary_Radio", ["Radio Settings", (phx_radioNoteString joinString "")]];






//Next step - wait for loadout
[
	{missionNamespace getVariable ["phx_loadoutAssigned",false]},
	{
		// [{call TFAR_fnc_haveSWRadio}, {phx_hasSW = true;}, [], 10, {phx_hasSW = false;}] call CBA_fnc_waitUntilAndExecute;
		// [{call TFAR_fnc_haveLRRadio}, {phx_hasLR = true;}, [], 3, {phx_hasLR = false;}] call CBA_fnc_waitUntilAndExecute;
		[] spawn phx_fnc_radio_setRadios;
	}
] call CBA_fnc_waitUntilAndExecute;
