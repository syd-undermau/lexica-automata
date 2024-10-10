#Requires AutoHotkey v2.0

#Include "../helpers.ahk"

; These are holdovers from my muscle memory with the Word templates
; The main distinction here is if a space should be inserted
; Feel free to comment out the spaces if you find them more annoying

; Interruption
^+[::
LeftInterruption(ThisHotkey) {
    TriggerHotkey(ThisHotkey)
    Send("{Space}!j")
    Hotstring("Reset")
}
^+]::
RightInterruption(ThisHotkey) {
    TriggerHotkey(ThisHotkey)
    Send("!j{Space}")
    Hotstring("Reset")
}