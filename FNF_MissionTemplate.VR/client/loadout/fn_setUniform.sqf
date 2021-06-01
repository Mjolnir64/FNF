switch (playerSide) do {
  case east: {pUniform = phx_opforUniform};
  case west: {pUniform = phx_bluforUniform};
  case independent: {pUniform = phx_indforUniform};
};

_incStr = "client\loadout\uniforms\" + pUniform + ".sqf";
call compile preprocessFileLineNumbers _incStr;

if (pRole in [ROLE_PL,ROLE_SL,ROLE_P]) then {phx_loadout_hasLr = true} else {phx_loadout_hasLr = false};
