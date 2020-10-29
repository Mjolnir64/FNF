[true] spawn phx_fnc_serverSafety;

phx_server_updateMissionTime = {
  _id = _this select 0;
  _id publicVariableClient "CBA_missionTime";
};

call phx_fnc_radio_genFreqs;

call phx_fnc_server_setupGame;

call phx_fnc_fortifyServer;

//Run checks to see if side is eliminated
[] spawn phx_fnc_checkAlive;

//Check mission run-time
[] spawn phx_fnc_checkTime;

// Create respawn markers in bottom left corner of map
{
    private _marker = createMarker [_x, [-1000,-1000,0]];
    _marker setMarkerShape "ICON";
    _marker setMarkerType "Empty";
} forEach ["respawn","respawn_west","respawn_east","respawn_guerrila","respawn_civilian"];

//Set vehicle locks
{
  /*
  _type = ((_x call BIS_fnc_objectType) select 1);
  if !(_type isEqualTo "Helicopter" || _type isEqualTo "Plane" || _type isEqualTo "TrackedAPC" || _type isEqualTo "WheeledAPC" || _type isEqualTo "Tank") then {
    if (_x inArea "bluforSafeMarker") then {
      _x setVariable ["ace_vehiclelock_lockSide", west, true];
    };
    if (_x inArea "opforSafeMarker") then {
      _x setVariable ["ace_vehiclelock_lockSide", east, true];
    };
    if (_x inArea "indforSafeMarker") then {
      _x setVariable ["ace_vehiclelock_lockSide", independent, true];
    };
  } else {
    _x setVariable ["ace_vehiclelock_lockSide", sideUnknown, true];
    if (_x inArea "bluforSafeMarker" || _x inArea "opforSafeMarker" || _x inArea "indforSafeMarker") then {
      _x setVehicleLock "LOCKED";
    };
  };
  */
  if (((_x call BIS_fnc_objectType) select 0) isEqualTo "Vehicle") then {
    clearWeaponCargoGlobal _x;
    clearMagazineCargoGlobal _x;
  };
} forEach vehicles;

//Keep player bodies on disconnect after safe start, remove during safe start
phx_server_disconnectBodies = addMissionEventHandler ["HandleDisconnect", {
  params ["_unit", "_id", "_uid", "_name"];

  if (phx_safetyEnabled) then {
    if (alive _unit) then {
      _unit setDamage 1;
    };
    (group _unit) setGroupOwner 2;
    deleteVehicle _unit;
  } else {
    if (alive _unit) then {
      _unit setDamage 1;
    };
    (group _unit) setGroupOwner 2;
  };
}];

//Disable zeus ping
missionnamespace setvariable ["bis_fnc_curatorPinged_time", 9999999, true];
