
phx_acreSetup = false;
_channelsArr_343 = [];
for "_i" from 1 to 80 do {_channelsArr_343 pushBack [(_i), (_i / 10)]};
missionNamespace setVariable ["channelsArr_343", _channelsArr_343];

missionNamespace setVariable ["channelsArr_152", [
	["COMPANY CMD", 1],
	["1ST PLATOON", 2],
	["ALPHA SQUAD", 3],
	["BRAVO SQUAD", 4],
	["CHARLIE SQUAD", 5],
	["2ND PLATOON", 6],
	["DELTA SQUAD", 7],
	["ECHO SQUAD", 8],
	["FOXTROT SQUAD", 9],
	["GOLF ASSETS", 10],
	["HOTEL AIR", 11]
]];
missionNamespace setVariable ["channelsArr_117", [
	["COMPANY CMD", 1],
	["1ST PLATOON", 2],
	["2ND PLATOON", 3],
	["GOLF ASSETS", 4],
	["HOTEL AIR", 5]
]];

{
    private _thisSide = _x;
    private _thisSideStr = str _x;

    _freqPreset = switch (_thisSide) do {
        case west: {"default"};
        case east: {"default2"};
        case independent: {"default3"};
        default {"default4"};
    };

    // set default frequency packages, accounting for channels outside of those we manually configure per the ORBAT. ensuring they match per side allows players to use, for example, channel 95 and have their radio be on the same frequency
    ["ACRE_PRC343", _freqPreset, _thisSideStr] call acre_api_fnc_copyPreset;
    ["ACRE_PRC152", _freqPreset, _thisSideStr] call acre_api_fnc_copyPreset;
    ["ACRE_PRC117F", _freqPreset, _thisSideStr] call acre_api_fnc_copyPreset;


   _baseChannel = switch (_thisSide) do {
        case east: {phx_opforBaseChannel};
        case west: {phx_bluforBaseChannel};
        case independent: {phx_indforBaseChannel};
        case civilian: {phx_civilianBaseChannel};
    };
    _encryptionKey = switch (_thisSide) do {
        case east: {phx_opforRadioEncryption};
        case west: {phx_bluforRadioEncryption};
        case independent: {phx_indforRadioEncryption};
        case civilian: {phx_civilianRadioEncryption};
    };

    {
        private _chan = _x # 0;
        private _freq = _baseChannel - 10 + (_x # 1);

        ["ACRE_PRC343", _thisSideStr, _chan, "frequencyRX", _freq] call acre_api_fnc_setPresetChannelField;
        ["ACRE_PRC343", _thisSideStr, _chan, "frequencyTX", _freq] call acre_api_fnc_setPresetChannelField;
    } forEach channelsArr_343;

    {
        private _chan = _forEachIndex + 1;
        private _label = _x # 0;
        private _freq = _baseChannel + (_x # 1) - 1;

        ["ACRE_PRC152", _thisSideStr, _chan, "name", _label] call acre_api_fnc_setPresetChannelField;
        ["ACRE_PRC152", _thisSideStr, _chan, "frequencyRX", _freq] call acre_api_fnc_setPresetChannelField;
        ["ACRE_PRC152", _thisSideStr, _chan, "frequencyTX", _freq] call acre_api_fnc_setPresetChannelField;
        ["ACRE_PRC152", _thisSideStr, _chan, "encryption", _encryptionKey] call acre_api_fnc_setPresetChannelField;
    } forEach channelsArr_152;


    {
        private _chan = _forEachIndex + 1;
        private _label = _x # 0;
        private _freq = _baseChannel + (_x # 1) - 1;

        ["ACRE_PRC117F", _thisSideStr, _chan, "name", _label] call acre_api_fnc_setPresetChannelField;
        ["ACRE_PRC117F", _thisSideStr, _chan, "frequencyRX", _freq] call acre_api_fnc_setPresetChannelField;
        ["ACRE_PRC117F", _thisSideStr, _chan, "frequencyTX", _freq] call acre_api_fnc_setPresetChannelField;
        ["ACRE_PRC117F", _thisSideStr, _chan, "encryption", _encryptionKey] call acre_api_fnc_setPresetChannelField;
    } forEach channelsArr_117;

} forEach [east, west, independent, civilian];

phx_acreSetup = true;