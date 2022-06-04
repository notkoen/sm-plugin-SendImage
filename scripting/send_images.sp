#pragma semicolon 1
#pragma newdecls required

#include <sourcemod>
#include <csgocolors_fix>

public Plugin myinfo =
{
	name        = "Send Images",
	author      = "koen",
	description = "Send images in CS:GO center text",
	version     = "0.1",
	url         = "https://steamcommunity.com/id/fungame1224/"
};

public void OnPluginStart()
{
	RegAdminCmd("sm_img", Command_Image, ADMFLAG_ROOT, "Print an image in Center Text");
}

public Action Command_Image(int client, int args)
{
	if (args < 1) {
		CPrintToChat(client, "{darkred}[Image] {default}Usage: sm_img <image link>");
		return Plugin_Handled;
	}
	
	char sInput[256];
	char sBuffer[256];
	
	GetCmdArgString(sInput, sizeof(sInput));
	Format(sBuffer, sizeof(sBuffer), "<img src='%s' width='500' height='600'>", sInput);
	
	DisplayCenterTextToAll(sBuffer);
	LogAction(client, -1, "\"%L\" sent an image %s", client, sInput);
	
	return Plugin_Handled;
}

stock void DisplayCenterTextToAll(const char[] message)
{
	for (int i = 1; i <= MaxClients; i++) {
		if (!IsClientInGame(i) || IsFakeClient(i)) continue;
		PrintCenterText(i, "%s", message);
	}
}