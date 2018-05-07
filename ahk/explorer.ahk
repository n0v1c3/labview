#NoEnv

SendMode Input
SetWorkingDir %A_ScriptDir%

^SPACE:: 
Winset, Alwaysontop, , A
Return

NumPad4::
WinGetPos, X, Y, W, H, A, , ,
WinMove, A, , 1600, , 960,
Return

NumPad6::
WinGetPos, X, Y, W, H, A, , ,
WinMove, A, , 2560, , 960,
Return
