#Requires AutoHotkey v2.0

#Include "./helpers.ahk"

; This is a hotkey to specifically target a YouTube Music window and play/pause it specifically when the media play/pause key is pressed
; Useful because NetScribe captures play/pause otherwise
; Could probably repurpose for Spotify but not sure exactly
; If you use the regular youtube player, change to "YouTube"

; Parameters: Keys, Control Element, Window Title
; Uncomment to use
; Media_Play_Pause::ControlSendActive(";",, "YouTube Music")