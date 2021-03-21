#pragma semicolon 1
#include "mizzzer"
#include <sourcemod>
#include <sdktools>
#include <sdkhooks> 
#include <vip_core> 

#define VERSION	"1.2[PUBLIC]"

char death_effect[][] ={"death_effect1p","death_effect1c"};

public Plugin myinfo =
{
	name = "[VIP] Dissolve Body",
	author = "MizzZer",
	version = VERSION
};

public void OnPluginStart() {
	HookEvent("player_death",	OnPlayerDeath);
}


public OnMapStart()
{
	AddFileToDownloadsTable("particles/ncrpg_death_effect.pcf");
	PrecacheParticle("particles/ncrpg_death_effect.pcf");
	PrecacheParticleEffect(death_effect[0]);
	PrecacheParticleEffect(death_effect[1]);
}


public Action OnPlayerDeath(Event event, const char[] name, bool dontBroadcast) 
{
	int iClient = GetClientOfUserId(event.GetInt("userid"));
	
	if(VIP_IsClientVIP(iClient))
	{
 
		int ragdoll = GetEntPropEnt(iClient, Prop_Send, "m_hRagdoll");
		if (ragdoll<0)
			return Plugin_Continue;
		float fPos[3];
		fPos[2]+=45;
		GetClientAbsOrigin(iClient,fPos);
		AttachParticle(iClient,death_effect[0],fPos);
		RemoveEdict(ragdoll);
	}
	return Plugin_Continue;
}

