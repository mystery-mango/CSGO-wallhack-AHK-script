﻿#Include classMemory.ahk
gui Add, Text, cPurple, Milky.cc FREE CSGO WH
gui, -caption
gui, add, text, x135 y1 h15 w15 gCls,
gui, add, picture, x0 y0 w150 h55, 
gui, add, checkbox, cpurple x20 y20 vWH gWH, On/Off
guicontrol, , WH, 1
gui, color,141415
gui, show, w150 h55



OnMessage(0x0201, "WM_LBUTTONDOWN")


WinSet, Transparent, %TransVal%
WM_LBUTTONDOWN() {
	PostMessage, 0xA1, 2,,, A
}



setbatchlines -1
Process, Wait, csgo.exe
csgo := new _ClassMemory("ahk_exe csgo.exe", "", hProcess)
if !IsObject(csgo)
{
if (hProcess = "")
msgbox class memory not correctly installed. Or the (global class) variable "_ClassMemory" has been overwritten
msgbox A_LastError %A_LastError%
ExitApp
}
 
base := csgo.getModuleBaseAddress("client.dll")
 
Pattern := [0x33, 0xC0, 0x83, 0xFA, "??", 0xB9, 0x20]
 
address := csgo.modulePatternScan("client.dll", Pattern*)
offsetwallhack := (address - base) + 4
 
WH:
t := !t
 
Data := t
Size := 1
 
VarSetCapacity(pBuffer, Size, 0)
NumPut(Data, pBuffer, "Uchar")
 
csgo.writeRaw(base + offsetwallhack, &pBuffer, Size)
return


Cls:
exitapp
return


guiclose:
exitapp
return







