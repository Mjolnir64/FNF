
/* 
    CBA SETTINGS
    acre_sys_core_automaticAntennaDirection = false;
    force acre_sys_core_ignoreAntennaDirection = true;
    acre_sys_core_defaultRadioVolume = 0.6;
    force acre_sys_core_fullDuplex = true;
    acre_sys_core_godVolume = 1;
    force acre_sys_core_interference = false;
    acre_sys_core_postmixGlobalVolume = 1.28164;
    acre_sys_core_premixGlobalVolume = 1;
    force acre_sys_core_revealToAI = 1;
    acre_sys_core_spectatorVolume = 1;
    force acre_sys_core_terrainLoss = 0.25;
    force acre_sys_core_ts3ChannelName = "";
    force acre_sys_core_ts3ChannelPassword = "";
    acre_sys_core_ts3ChannelSwitch = true;
    acre_sys_core_unmuteClients = false;
    force acre_sys_signal_signalModel = 0;
*/


// phx_radioSettings: Tells radio script which channels to set for group. [altChannel,mainChannel,[channelArray]] (array)
//     mainChannel: Which channel the radio will start on. (1-8)
//     altChannel: Which channel the radio will have as an alternate by default (1-8)
//     [channelArray]: An array of channels to set on the radio. (float)
//        channelArray is expressed as numbers which are added to playerBaseChannel (ch1) to determine which channel the radio will be on.
//        Try to keep offsets single digit or the channel may not be set if playerBaseChannel is a high number.
//        Frequencies can only have one decimal place.
//     ex: [1,6,[1,2,3,4]] - mainChannel is ch1, altChannel is ch6, ch2 is 1 unit MHz higher than ch1, etc.
_radioSettings = (group player) getVariable ["phx_radioSettings",[0, 1, 1]];
phx_117Chan = _radioSettings select 2;
phx_152Chan = _radioSettings select 1;

_offset343 = 0;
if (_radioSettings # 0 isEqualTo 0) then {
	_offset343 = 0;
} else {
	_offset343 = ((_radioSettings # 0) * 10);
};
phx_343Chan = ((phx_152Chan - 1) * 16) + 1 + _offset343;

//Change channel numbers from user readable to script readable
// phx_343Chan = phx_343Chan - 1;
// phx_152Chan = phx_152Chan - 1;
// phx_117Chan = phx_117Chan - 1;





// Init arr for multi push to talk assignment of existent radios
_radioArr = [];



[{!(isNull findDisplay 46) && !(isNull player) && ([] call acre_api_fnc_isInitialized) && (missionNamespace getVariable ["phx_acreSetup",false])}, {}] call CBA_fnc_waitUntilAndExecute;



// radio types

// ACRE_PRC343
// ACRE_PRC148
// ACRE_PRC152
// ACRE_PRC77
// ACRE_PRC117F

// ["ACRE_PRC152", "_freqPreset", "my_new_preset"] call acre_api_fnc_copyPreset;
// ["ACRE_PRC152", "my_new_preset", 1, "label", "PLTNET 1"] call acre_api_fnc_setPresetChannelField;
// ["ACRE_PRC152", "my_new_preset", 1, "frequencyRX", 60.1] call acre_api_fnc_setPresetChannelField;
// ["ACRE_PRC152", "my_new_preset", 1, "frequencyTX", 60.1] call acre_api_fnc_setPresetChannelField;
// ["ACRE_PRC152", "my_new_preset"] call acre_api_fnc_setPreset;


["ACRE_PRC343", str playerSide] call acre_api_fnc_setPreset;
["ACRE_PRC152", str playerSide] call acre_api_fnc_setPreset;
["ACRE_PRC117F", str playerSide] call acre_api_fnc_setPreset;


// assign 343
if (phx_loadout_unitLevel >= 0)  then {
    "ACRE_PRC343:1" call phx_fnc_addGear;
};


// assign 152
if (phx_loadout_unitLevel >= 1) then {
    "ACRE_PRC152:1" call phx_fnc_addGear;
};


// assign 117F
if (phx_loadout_unitLevel >= 2) then {
    "ACRE_PRC117F:1" call phx_fnc_addGear;	
};



waitUntil {([] call acre_api_fnc_isInitialized)};


if (phx_loadout_unitLevel >= 0)  then {
    // Get String ID of radio equipped
    _personalRadio = ["ACRE_PRC343"] call acre_api_fnc_getRadioByType;

	// Set default channel
	[_personalRadio, phx_343Chan] call acre_api_fnc_setRadioChannel;
	// Set default volume
	[_personalRadio, 0.6] call acre_api_fnc_setRadioVolume;
	// Set stereo mode for default channel
	[_personalRadio, "CENTER"] call acre_api_fnc_setRadioSpatial;

	_radioArr pushBack _personalRadio;
};

if (phx_loadout_unitLevel >= 1) then {
    // Get String ID of radio equipped
	_handheldRadio = ["ACRE_PRC152"] call acre_api_fnc_getRadioByType;

	// Set default channel
	[_handheldRadio, phx_152Chan] call acre_api_fnc_setRadioChannel;
	// Set default volume
	[_handheldRadio, 0.6] call acre_api_fnc_setRadioVolume;
	// Set stereo mode for default channel
	[_handheldRadio, "LEFT"] call acre_api_fnc_setRadioSpatial;

	_radioArr pushBack _handheldRadio;
};

if (phx_loadout_unitLevel >= 2) then {
    // Get String ID of radio equipped
	_manpackRadio = ["ACRE_PRC117F"] call acre_api_fnc_getRadioByType;

	// Set default channel
	[_manpackRadio, phx_117Chan] call acre_api_fnc_setRadioChannel;
	// Set default volume
	[_manpackRadio, 0.6] call acre_api_fnc_setRadioVolume;
	// Set stereo mode for default channel
	[_manpackRadio, "RIGHT"] call acre_api_fnc_setRadioSpatial;

	_radioArr pushBack _manpackRadio;
};





[_radioArr] call acre_api_fnc_setMultiPushToTalkAssignment;

//Everything should be setup. Let the player know.
systemChat "Radios preset.";
call phx_fnc_radio_cleanup;
