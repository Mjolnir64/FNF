/*
Overtime end conditions for each game mode
*/

//Exit if game already ended via other script
if (phx_gameEnd) exitWith {};

_endGame = {
  _msg = _this;

  phx_gameEnd = true;
  publicVariable "phx_gameEnd";

  [phx_defendingSide, _msg] spawn phx_fnc_gameEnd;
};

switch (true) do {
  case (phx_gameMode == "destroy"): {
    _defMsg = "has successfully defended the objectives and won!";
    if (phx_aliveObjectives == 1) then {
      _obj = [];
      _alert = false;
      {
        if (alive _x) then {_obj = _x};
      } forEach phx_destroyObjs;

      //Check for attackers near last obj - if none near, end game
      while {!phx_gameEnd} do {
        _attackersNear = {(alive _x) && (lifeState _x != "INCAPACITATED") && (side _x == phx_attackingSide) && (_x distance _obj < 100)} count playableUnits;
        if (_attackersNear == 0) exitWith {
          _obj allowDamage false;
          _defMsg call _endGame;
        };

        if (!_alert) then {
          "Overtime enabled! \n The mission will end if no attackers are near the last objective." remoteExec ["hintSilent", 0, false];
          _alert = true;
        };
        sleep 5;
      };
    } else {
      //If more than 1 obj left, end game
      if (phx_aliveObjectives > 1) then {
        {
          _x allowDamage false;
        } forEach phx_destroyObjs;
        _defMsg call _endGame;
      };
    };
  };
  //DESTROY END

  case (phx_gameMode == "uplink"): {
    _alert = false;
    while {!phx_gameEnd} do {
      if !(phx_term1Hacking || phx_term2Hacking || phx_term3Hacking) then {
        {
          _x remoteExec ["removeAllActions",0,false];
        } forEach [term1,term2,term3];
        "has successfully defended the objectives and won!" call _endGame;
      } else {
        if (!_alert) then {
          //"Overtime enabled. \n The mission will end if no terminals are being hacked" remoteExec ["hintSilent", 0, false];
          _alert = true;
        };
      };
      sleep 1;
    };
  };
  //UPLINK END

  case (phx_gameMode == "rush"): {
    _finalTerm = objNull;
    _noHack = false;

    if (!isNull term3) then {_finalTerm = term3} else {_finalTerm = term2};
    while {!phx_gameEnd} do {
      switch (_finalTerm) do {
        case term2: {
          if (!phx_term2Hacking) then {_noHack = true};
        };
        case term3: {
          if (!phx_term3Hacking) then {_noHack = true};
        };
      };

      if (_noHack) then {
        phx_term1Hacking = false;
        phx_term2Hacking = false;
        phx_term3Hacking = false;
        {
          _x remoteExec ["removeAllActions",0,false];
        } forEach [term1,term2,term3];
        "has successfully defended the objectives and won!" call _endGame;
      };
      sleep 1;
    };
  };
  //RUSH END

  case (phx_gameMode == "adSector"): {
    _finalSector = objNull;
    switch (phx_sectorNum) do {
      case 1: {_finalSector = phx_sec1};
      case 2: {_finalSector = phx_sec2};
      case 3: {_finalSector = phx_sec3};
    };

    while {!phx_gameEnd} do {
      _attackersInside = {(alive _x) && (lifeState _x != "INCAPACITATED") && (side _x == phx_attackingSide) && (_x inArea _finalSector)} count playableUnits;

      if (_attackersInside == 0) then {
        "has successfully defended the sectors and won!" call _endGame;
      };
      sleep 3;
    };
  };
  //ATK/DEF SECTOR END

  case "captureTheFlag": {
    while {!phx_gameEnd} do {
      if !(ctf_flag inArea ctf_attackTrig) then {
        [player,phx_clientFlagAction] remoteExec ["BIS_fnc_holdActionRemove",0,false];
        [player,phx_client_dropFlagAction] remoteExec ["removeAction",0,false];
        deleteVehicle ctf_flag;
        deleteMarker "flagMark";
        "has successfully defended the flag!" call _endGame;
      };
      sleep 2;
    };
  };
  //CTF END

  case (phx_gameMode == "neutralSector" || phx_gameMode == "connection"): {
    _overTimeAlert = false;
    _pointLead = 20;
    while {!phx_gameEnd} do {
      _overtime = false;
      _highSide = sideEmpty;
      _highCount = -1;

      _blu = [west] call BIS_fnc_respawnTickets;
      _opf = [east] call BIS_fnc_respawnTickets;
      _ind = [independent] call BIS_fnc_respawnTickets;

      {
        _val = [_x] call BIS_fnc_respawnTickets;
        if (_val > _highCount) then {_highCount = _val; _highSide = _x};
      } forEach [east,west,independent];

      _bluOpfDif = 0;
      _bluIndDif = 0;

      _opfBluDif = 0;
      _opfIndDif = 0;

      _indBluDif = 0;
      _indOpfDif = 0;

      if (_blu > _opf) then {
        _bluOpfDif = _blu - _opf;
      };
      if (_blu > _ind) then {
        _bluIndDif = _blu - _ind;
      };

      if (_opf > _blu) then {
        _opfBluDif = _opf - _blu;
      };
      if (_opf > _ind) then {
        _opfIndDif = _opf - _ind;
      };

      if (_ind > _blu) then {
        _indBluDif = _ind - _blu;
      };
      if (_ind > _opf) then {
        _indOpfDif = _ind - _opf;
      };

      if (_highSide == west && (_bluOpfDif < _pointLead || _bluIndDif < _pointLead)) then {_overtime = true};
      if (_highSide == east && (_opfBluDif < _pointLead || _opfIndDif < _pointLead)) then {_overtime = true};
      if (_highSide == independent && (_indBluDif < _pointLead || _indOpfDif < _pointLead)) then {_overtime = true};

      if (!_overtime) then {

        phx_gameEnd = true;
        publicVariable "phx_gameEnd";
        [_highSide, "wins to mission time limit!"] spawn phx_fnc_gameEnd;
      } else {
        if (!_overTimeAlert) then {
          "Overtime enabled! \n The first side to hit 100 points or a 20 point lead will win." remoteExec ["hint"];
          _overTimeAlert = true;
        };
      };
      sleep 3;
    };
  };
  //END NEUTRAL SECTOR & CONNECTION

  case (phx_gameMode == "scavHunt"): {

    phx_scavHuntCheckScores = {
      private _scores = createHashMapFromArray [
        [
          west,
          phx_scavHuntObjs select {(_x getVariable ["capturedBy", sideUnknown]) isEqualTo east}
        ],
        [
          east,
          phx_scavHuntObjs select {(_x getVariable ["capturedBy", sideUnknown]) isEqualTo west}
        ],
        [
          independent,
          phx_scavHuntObjs select {(_x getVariable ["capturedBy", sideUnknown]) isEqualTo independent}
        ]
      ];

      private _winScore = selectMax (values _scores);
      private _winSide = createHashMap;
      {
        if (_y == _winScore) then {_winSide set [_x, _y]};
      } forEach _scores;

      _winSide;
    };

    if (count (call _checkScores) > 1) then {
      "Overtime enabled! \n The first side to capture another item will win." remoteExec ["hint"];
      waitUntil {sleep 2; count (call _checkScores) == 1};
      phx_gameEnd = true;
      publicVariable "phx_gameEnd";

      _winData = ((call _checkScores) toArray false) select 0;

      [_winData # 0, format["%1 won Scavenger Hunt in overtime by holding %2 items!", str(_winData # 0), _winData # 1]] spawn phx_fnc_gameEnd;
    } else {
      [_winData # 0, format["%1 won by holding %2 items!", str(_winData # 0), _winData # 1]] spawn phx_fnc_gameEnd;
    };
  };
};
