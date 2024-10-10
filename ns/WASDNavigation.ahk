#Requires AutoHotkey v2.0

; This allows Caps/Menu + WASD to navigate up/left/down/right
; The {Blind} modifier means that Ctrl+Caps+A will actually send Ctrl+Left, jumping back one word 

SetCapsLockState("AlwaysOff")
CapsLock & w::Send("{Blind}{Up}")
CapsLock & a::Send("{Blind}{Left}")
CapsLock & s::Send("{Blind}{Down}")
CapsLock & d::Send("{Blind}{Right}")

AppsKey::Send "{AppsKey}"
AppsKey & w::Send("{Blind}{Up}")
AppsKey & a::Send("{Blind}{Left}")
AppsKey & s::Send("{Blind}{Down}")
AppsKey & d::Send("{Blind}{Right}")