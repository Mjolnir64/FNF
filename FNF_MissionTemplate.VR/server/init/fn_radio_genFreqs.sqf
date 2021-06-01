//Generates base channels for radios and broadcasts them to clients. 30MHz-87MHz is the longrange limit before taking into account how many freqs are needed
if (!isServer) exitWith {};

_opforBaseChannel = floor(random 40) + 30;
_indforBaseChannel = floor(random 40) + 30;
_bluforBaseChannel = floor(random 40) + 30;
_civilianBaseChannel = floor(random 40) + 30;
_opforRadioEncryption = floor(random 37000) + 2000;
_indforRadioEncryption = floor(random 37000) + 2000;
_bluforRadioEncryption = floor(random 37000) + 2000;
_civilianRadioEncryption = floor(random 37000) + 2000;
_broadcasted1 = ["phx_bluforBaseChannel", _bluforBaseChannel] call CBA_fnc_publicVariable;
_broadcasted2 = ["phx_opforBaseChannel", _opforBaseChannel] call CBA_fnc_publicVariable;
_broadcasted3 = ["phx_indforBaseChannel", _indforBaseChannel] call CBA_fnc_publicVariable;
_broadcasted4 = ["phx_civilianBaseChannel", _civilianBaseChannel] call CBA_fnc_publicVariable;
_broadcasted5 = ["phx_bluforRadioEncryption", _bluforRadioEncryption] call CBA_fnc_publicVariable;
_broadcasted6 = ["phx_opforRadioEncryption", _opforRadioEncryption] call CBA_fnc_publicVariable;
_broadcasted7 = ["phx_indforRadioEncryption", _indforRadioEncryption] call CBA_fnc_publicVariable;
_broadcasted8 = ["phx_civilianRadioEncryption", _civilianRadioEncryption] call CBA_fnc_publicVariable;


