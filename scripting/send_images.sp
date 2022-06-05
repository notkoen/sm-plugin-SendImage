#pragma semicolon 1
#pragma newdecls required

#include <sourcemod>
#include <csgocolors_fix>

char sImageText[PLATFORM_MAX_PATH];

ConVar g_cvResendRate;

public Plugin myinfo =
{
	name        = "Send Images",
	author      = "koen",
	description = "Send images in CS:GO center text",
	version     = "0.2",
	url         = "https://steamcommunity.com/id/fungame1224/"
};

public void OnPluginStart()
{
	RegAdminCmd("sm_img", Command_Image, ADMFLAG_ROOT, "Print an image in Center Text");
	
	g_cvResendRate = CreateConVar("sm_images_resend", "1.00", "How fast should images be resent so it displays? (Note: Shorter times may result in images not being cached)", _, true, 0.10);
	AutoExecConfig(true);
}

public Action Command_Image(int client, int args)
{
	if (args < 1) {
		CPrintToChat(client, "{darkred}[Image] {default}Usage: sm_img <image link>");
		return Plugin_Handled;
	}
	
	char sInput[256];
	
	GetCmdArgString(sInput, sizeof(sInput));
	Format(sImageText, sizeof(sImageText), "<img src='%s' width='500' height='600'>", sInput);
	
	PrintCenterTextAll(sImageText);
	CreateTimer(g_cvResendRate.FloatValue, ResendImage);
	LogAction(client, -1, "\"%L\" sent an image \"%s\"", client, sInput);
	
	return Plugin_Handled;
}

public Action ResendImage(Handle timer)
{
	PrintCenterTextAll(sImageText);
	return Plugin_Handled;
}