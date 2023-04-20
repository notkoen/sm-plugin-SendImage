#pragma semicolon 1
#pragma newdecls required

#include <sourcemod>
#include <fys.huds>

char g_sImage[PLATFORM_MAX_PATH];
char input[PLATFORM_MAX_PATH];

ConVar g_cvResendRate;

public Plugin myinfo =
{
	name = "Send Images",
	author = "koen",
	description = "Send images in CS:GO center text",
	version = "0.6",
	url = "https://github.com/notkoen"
};

public void OnPluginStart()
{
	RegAdminCmd("sm_img", Command_Image, ADMFLAG_ROOT, "Send image in center text box");
	RegAdminCmd("sm_img2", Command_Image2, ADMFLAG_ROOT, "Send image in the middle hud element");
	
	g_cvResendRate = CreateConVar("sm_images_resend", "1.0", "Image resend time (Short times may cause caching issues)", _, true, 0.10);
	AutoExecConfig(true, "SendImages");
}

public void OnMapStart()
{
	g_sImage = "";
	input = "";
}

void SendImage(int style, const char[] image, int width = 800, int height = 800)
{
	Format(g_sImage, sizeof(g_sImage), "<span><img width='%d' height='%d' src='%s'></span>", width, height, image);
	
	if (style == 1) PrintCenterTextAll(g_sImage);
	if (style == 2) Huds_ShowHtmlHudAll(5.0, g_sImage, true);

	CreateTimer(g_cvResendRate.FloatValue, ResendImage, style);
}

public Action Command_Image(int client, int args)
{
	if (args < 1)
	{
		PrintToChat(client, "\x04[IMAGES] \x01Usage: sm_img <link>");
		return Plugin_Handled;
	}
	
	GetCmdArgString(input, sizeof(input));
	SendImage(1, input);
	LogAction(client, -1, "\"%L\" sent an image \"%s\"", client, input);
	
	return Plugin_Handled;
}

public Action Command_Image2(int client, int args)
{
	if (args < 1)
	{
		PrintToChat(client, "\x04[Images] \x01Usage: sm_img2 <link>");
		return Plugin_Handled;
	}
	
	GetCmdArgString(input, sizeof(input));
	SendImage(2, input);
	LogAction(client, -1, "\"%L\" sent an image \"%s\"", client, input);
	
	return Plugin_Handled;
}

public Action ResendImage(Handle timer, int style)
{
	if (style == 1) PrintCenterTextAll(g_sImage);
	if (style == 2) Huds_ShowHtmlHudAll(5.0, g_sImage, true);
	return Plugin_Handled;
}
