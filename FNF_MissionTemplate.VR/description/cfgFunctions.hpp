class CfgFunctions {
  class PHX {
    class vars {
      class varsInit{file = "config.sqf"; preInit = 1;};
      class sekritVars{file = "description\sekrit.sqf"; preInit = 1;};
    };
    class serverInit {
      file = "server\init";
      class serverInit{};
      class serverInitCall{postInit = 1;};
    };
    class clientInit {
      file = "client\init";
      class clientInit{};
      class clientCanPlay{};
      class clientSetupGame{};
      class staggeredLoad{};
      class clientInitCall{postInit = 1;};
    };
    class briefing {
      file = "client\briefing";
      class briefInit{};
      class setGroupIDs{};
      class createBrief{};
      class createOrbat{};
    };
    class radio {
      file = "client\radio";
      class radio_waitGear{};
      class radio_getChannels{};
      class radio_setRadios{};
      class radio_cleanup{};
    };
    class spectator {
      file = "client\spectator";
      class spectatorInit{};
    };
    class loadout {
      file = "client\loadout";
      class setLoadout{};
      class setUniform{};
      class setWeapons{};
      class addUniform{};
      class addWeapons{};
      class addGear{};
      class addMagazines{};
      class addItems{};
      class checkLoadout{};
      class initLoadout{};
      class loadout_vars{};
    };
    class loadout_misc {
      file = "client\loadout\misc";
      class giveNVG{};
      class setMAT{};
      class setUGLAmmo{};
      class setAttributes{};
    };
    class selector {
      file = "client\loadout\selector";
      class selector_init{};
      class selector_optics{};
      class selector_weapons{};
      class selector_charges{};
    };
    class restrictions {
      file = "client\restrictions";
      class restrictions{};
      class disableMisc{};
      class afkCheck{};
      class disableTyping{};
      class removeRespawnButton{};
      class hideMarkers{};
      class restrictUniform{};
      class zoneBoundary{};
      class startBoundary{};
      class restrictETool{};
      class restrictGamma{};
    };
    class safety {
      file = "client\safety";
      class safety{};
    };
    class misc {
      file = "client\misc";
      class hintThenClear{};
      class fortifyClient{};
      class clientTime{};
      class killCounter{};
      class showTimeOnMap{};
    };
    class unflip {
      file = "client\misc\unflip";
      class unflipVehicle{};
      class unflipVehicleAddAction{};
    };
    class initServer {
      file = "server\init";
      class serverSafety{};
      class sendUniforms{};
      class markCustomObjs{};
      class fortifyServer{};
      class server_setupGame{};
      class radio_genFreqs{};
      class radio_ACREsetup{};
    };
    class end {
      file = "server\end";
      class checkAlive{};
      class checkTime{};
      class overTimeEnd{};
    };
  };
};
