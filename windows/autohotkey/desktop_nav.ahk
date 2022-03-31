SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; use ctrl+shift+h/l to switch desktops
; send alt+tab immediately after to make sure the last used window is focused

+^l::
Send, #^{Right}
Send, !{Tab}
return

^+h::
Send, #^{Left}
Send, !{Tab}
return
