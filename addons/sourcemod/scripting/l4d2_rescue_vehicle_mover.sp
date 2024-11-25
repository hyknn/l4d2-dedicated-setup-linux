#define PLUGIN_VERSION "1.0"

/*======================================================================================
	Plugin Info:

*	Name	:	Finale rescue vehicle mover for 4+ survivors
*	Author	:	sorallll
*	Descrp	:	Properly moves extra 4+ survivors to their intended location during finale rescue sequences
*	Link	:	https://forums.alliedmods.net/showpost.php?p=2771140&postcount=49

========================================================================================
	Change Log:

1.0 (11-Feb-2022)
	- Initial release.

======================================================================================*/

#pragma semicolon 1
#pragma newdecls required
#include <sourcemod>
#include <sdktools>

public Plugin myinfo =
{
	name = "Finale rescue vehicle mover for 4+ survivors",
	author = "sorallll",
	description = "Properly moves extra 4+ survivors to their intended location during finale rescue sequences",
	version = PLUGIN_VERSION,
	url = "https://forums.alliedmods.net/showpost.php?p=2771140&postcount=49"
};

public void OnPluginStart()
{
	HookEvent("finale_vehicle_leaving", Event_FinaleVehicleLeaving);
}

void Event_FinaleVehicleLeaving(Event event, const char[] name, bool dontBroadcast)
{
	int entity = FindEntityByClassname(MaxClients + 1, "info_survivor_position");
	if (entity == INVALID_ENT_REFERENCE)
	{
		return;
	}

	float vOrigin[3];
	GetEntPropVector(entity, Prop_Send, "m_vecOrigin", vOrigin);

	static const char sOrder[][] = {"1", "2", "3", "4"};
	int iSurvivor = 0;

	for (int client = 1; client <= MaxClients; client++)
	{
		if (!IsClientInGame(client) || GetClientTeam(client) != 2)
		{
			continue;
		}

		iSurvivor++;

		// Skip the first 4 survivors; they already have valid positions.
		if (iSurvivor <= 4)
		{
			continue;
		}

		int extraIndex = (iSurvivor - 1) % 4; // Cycle through 0-3 for "Order" values.
		entity = CreateEntityByName("info_survivor_position");

		if (entity == INVALID_ENT_REFERENCE)
		{
			PrintToServer("[Finale Mover] Failed to create 'info_survivor_position' entity.");
			continue;
		}

		DispatchKeyValue(entity, "Order", sOrder[extraIndex]);
		TeleportEntity(entity, vOrigin, NULL_VECTOR, NULL_VECTOR);
		DispatchSpawn(entity);
	}
}
