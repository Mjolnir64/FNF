phx_loadout_uniform = "rhsgref_uniform_tigerstripe";
phx_loadout_vest = "rhsgref_chestrig";
phx_loadout_headgear = "rhs_6b7_1m_olive";

if (phx_loadout_unitLevel > 0) then {phx_loadout_vest = "rhsgref_alice_webbing";}; //PL, SL, TL, MGTL

if (pRole == ROLE_AR || pRole == ROLE_MG) then {phx_loadout_vest = "rhsgref_chicom";}; //AR & MG

#include "base\IND_WD.sqf"
