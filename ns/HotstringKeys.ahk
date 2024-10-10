#Requires AutoHotkey v2.0
#Include "../helpers.ahk"

InstallKeybdHook

\:: SendForSelf("_")

IsFauxPressed(Key) {
    return GetKeyState(Key) && not GetKeyState(Key, "P")
}

; We REALLY want to intercept ctrl+space
#InputLevel 1
; The asterisk here specifies that we want any other modifiers to also trigger this. This is so we can easily break out if control gets stuck down
*^Space:: {
    if IsFauxPressed("Control") {
        While IsFauxPressed("Control") {
            ; We've gotten stuck and this is BAD
            SendForSelf("{Control Up}")
            Sleep(50)
        }

        SendForSelf("{Blind}{Space}")
    } else {
        SendForSelf("{Text}`` ")
    }
}
; ...and we REALLY want to catch ctrl+r or ctrl+w if we're stuck
*w:: {
    While IsFauxPressed("Control") {
        ; We've gotten stuck and this is REALLY BAD
        SendForSelf("{Control Up}")
        Sleep(50)
    }

    SendForSelf("{Blind}w")
}
*r:: {
    while IsFauxPressed("Control") {
        SendForSelf("{Control Up}")
        Sleep(50)
    }
    SendForSelf("{Blind}r")
}
^,:: SendForSelf("``,")
^.:: SendForSelf("``.")
^':: SendForSelf("``'")
^/:: SendForSelf("``?") ; Can't use shift here because of QA
^;:: SendForSelf("``;")
^+;:: SendForSelf("``:")
#InputLevel 0

F3:: {
    SendForSelf("``.")
    Send("{Backspace}")
}

^BackSpace:: {
    Hotstring "Reset"
    Send("^{bs}")
}