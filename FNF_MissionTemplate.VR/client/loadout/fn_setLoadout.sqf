if (pRole == ROLE_CIV) exitWith {phx_loadoutAssigned = true};

call phx_fnc_addUniform;
call phx_fnc_addItems;
call phx_fnc_addMagazines;
call phx_fnc_addWeapons;
call phx_fnc_giveNVG;
call phx_fnc_setAttributes;

// player linkItem "ItemRadio";
player linkItem "ItemGPS";
player linkItem "ItemCompass";
//player linkItem "ItemWatch";
player linkItem "TFAR_microdagr";

if (phx_loadout_unitLevel > 0) then {
  player addItem "ACE_microDAGR";
};

missionNamespace setVariable ["phx_loadoutAssigned",true];
