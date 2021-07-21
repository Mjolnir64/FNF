#include "description\configDefs.hpp"

/* MAKE SURE YOU SET THE ATTACKING AND DEFENDING SIDES BELOW IF YOUR CHOSEN MODE IS AN ATK/DEF */
/* DO NOT DELETE ANY OF THE OTHER TEMPLATE OBJECTIVE OBJECTS - they will be deleted automatically if not in use */

phx_gameMode = destroy; //Change this to whatever game mode you want and configure the respective file in mode_config
//If you don't want to use one of the template modes, you can set phx_gameMode = "";
/*
===ATK/DEF===
destroy
uplink
rush
captureTheFlag
adSector

===NEUTRAL===
connection
neutralSector
scavHunt
*/

/************************* DON'T FORGET TO FILL THIS OUT IF YOUR GAME MODE IS NOT NEUTRAL *************************/
phx_defendingSide = sideEmpty; //west/east/independent
phx_attackingSide = sideEmpty; //west/east/independent
//Leave it as sideEmpty if chosen mode is neutral

////////////////////////////////////////////////////////////

//BLUFOR
phx_bluforUniform = "UNIFORM_MARPAT_WD";
phx_bluforWeapons = "WEAPONS_US";

//OPFOR
phx_opforUniform = "UNIFORM_EMR_SUMMER";
phx_opforWeapons = "WEAPONS_RU";

//INDFOR
phx_indforUniform = "UNIFORM_M93_OAKLEAF";
phx_indforWeapons = "WEAPONS_IND";

/*
You can also use the civilian unit 'C_man_1'
Those units will not be touched by the tempalte loadout system, so they will keep their editor loadout
If they have a radio, they will all be preset to the same frequency
*/

//MAT launcher weapon
phx_bluAT = CARLG; //BLUFOR
phx_redAT = RPG32; //OPFOR
phx_grnAT = RPG32; //INDFOR
/*
Values:
CARLG, RPG32, RPG7, TITAN, JAVELIN
METIS, NLAW, STINGER, IGLA
*/

phx_magnifiedOptics = false; //Allow players to grab magnified optics from the gear selector
phx_addNVG = false; //Automatically add NVGs & lasers to players (Gen3, Black) - true for global add or side or array of sides
//Example: phx_addNVG = east will give side east NVGs, phx_addNVG = [east,west] will give sides east and west NVGs

phx_fortifyPoints = 125; //Currency for fortify - individual to each Combat Engineer - set to 0 to disable
phx_enemyStartVisible = true; //Set to false to hide enemy start zone markers
phx_maxViewDistance = 1500; //Maximum client view distance (meters)

/*
==========UNIFORM VALUES========== -- ==========WEAPON VALUES==========

=====BLUFOR=====                                =====ANY=====
UNIFORM_MARPAT_WD                  --   WEAPONS_US
UNIFORM_MARPAT_D                   --   WEAPONS_RU
UNIFORM_OEF_CP                     --   WEAPONS_IND
UNIFORM_PMC                        --   WEAPONS_G36
UNIFORM_M93_DESERT                 --   WEAPONS_GUERRILLA
UNIFORM_M93_WOODLAND               --   WEAPONS_M21
UNIFORM_ARMY_OCP                   --   WEAPONS_SCAR
UNIFORM_UCP                        --   WEAPONS_VHS
UNIFORM_CTRG_WD                    --   WEAPONS_FAL_COLDWAR
UNIFORM_ION_BK                     --   WEAPONS_M14
UNIFORM_ION_WD                     --   WEAPONS_SOVIET
UNIFORM_ISRAEL_TAN
UNIFORM_RANGER
UNIFORM_WEST_POLICE
UNIFORM_BUNDESWEHR
UNIFORM_HELLENIC_ARMY

=====OPFOR=====
UNIFORM_EMR_SUMMER
UNIFORM_EMR_DESERT
UNIFORM_FLORA
UNIFORM_MOUNTAIN_FLORA
UNIFORM_GORKA_GREEN
UNIFORM_GORKA_BEREZKA
UNIFORM_SOVIET_CSAT
UNIFORM_EAST_POLICE
UNIFORM_RUSSIAN_SPETSNAZ
UNIFORM_RUSSIAN_RATNIK
UNIFORM_SOVIET_AFGHAN
UNIFORM_SOVIET_WINTER
UNIFORM_RUSSIAN_SPRING

=====INDFOR=====
UNIFORM_M93_OAKLEAF
UNIFORM_M93_TIGER
UNIFORM_M93_GREEN
UNIFORM_M93_FLECKTARN
UNIFORM_M10_DESERT
UNIFORM_M10_MOUNTAIN
UNIFORM_GUERRILLA
UNIFORM_AAF
UNIFORM_ALTIS_LIZARD
UNIFORM_PARAMILITARY
UNIFORM_IND_POLICE
UNIFORM_M88
UNIFORM_JUNGLE
=========================================================================================================================
*/
