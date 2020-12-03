#include sourcemod
#include sdkhooks
#include sdktools
#include cstrike
bool Sekmeme_Aktif = false;
public void OnPluginStart()
{
	RegAdminCmd("sm_sekmeme", Sekmeme, ADMFLAG_ROOT);
}
public Action Sekmeme(int client, int args)
{
	if (Sekmeme_Aktif)
	{
		PrintToChat(client, "[SM] \x0B%N \x01isimli yetkili \x04sekmeme'yi \x02kapattı!", client);
		SekmemeAyarla(false);
		Sekmeme_Aktif = false;
	}
	else
	{
		PrintToChat(client, "[SM] \x0B%N \x01isimli yetkili \x04sekmeme'yi \x02açtı!", client);
		SekmemeAyarla(true);
		Sekmeme_Aktif = true;
	}
}
stock void SekmemeAyarla(bool Durum)
{
	if (Durum)
	{
		SetCvar("weapon_accuracy_nospread", 1);
		SetCvarFloat("weapon_recoil_cooldown", 0.0);
		SetCvarFloat("weapon_recoil_decay1_exp", 9999.0);
		SetCvarFloat("weapon_recoil_decay2_exp", 9999.0);
		SetCvarFloat("weapon_recoil_decay2_lin", 9999.0);
		SetCvarFloat("weapon_recoil_scale", 0.0);
		SetCvar("weapon_recoil_suppression_shots", 500);
		SetCvarFloat("weapon_recoil_view_punch_extra", 0.0);
	}
	else
	{
		SetCvar("weapon_accuracy_nospread", 0);
		SetCvarFloat("weapon_recoil_cooldown", 0.55);
		SetCvarFloat("weapon_recoil_decay1_exp", 3.5);
		SetCvarFloat("weapon_recoil_decay2_exp", 8.0);
		SetCvarFloat("weapon_recoil_decay2_lin", 18.0);
		SetCvarFloat("weapon_recoil_scale", 2.0);
		SetCvar("weapon_recoil_suppression_shots", 4);
		SetCvarFloat("weapon_recoil_view_punch_extra", 0.055);
	}
}
void SetCvar(char[] cvarName, int value)
{
	ConVar IntCvar = FindConVar(cvarName);
	if (IntCvar == null)return;
	int flags = IntCvar.Flags;
	flags &= ~FCVAR_NOTIFY;
	IntCvar.Flags = flags;
	IntCvar.IntValue = value;
	flags |= FCVAR_NOTIFY;
	IntCvar.Flags = flags;
}
stock void SetCvarFloat(char[] cvarName, float value)
{
	ConVar FloatCvar = FindConVar(cvarName);
	if (FloatCvar == null)return;
	int flags = FloatCvar.Flags;
	flags &= ~FCVAR_NOTIFY;
	FloatCvar.Flags = flags;
	FloatCvar.FloatValue = value;
	flags |= FCVAR_NOTIFY;
	FloatCvar.Flags = flags;
}