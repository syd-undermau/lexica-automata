#Requires AutoHotkey v2.0

#Include "./settings.ahk"

#HotIf WinActive("ahk_group MitreFinch")

#N:: {
    ; TODO: Vimium support
    if HAS_VIMIUM_INSTALLED {
        Send("{Esc}")
        ; document.querySelector("div[title='Location']").focus()
        ; VimiumNavigateLink("c", False)
        Sleep(250)

        ; Location
        Send "NSW"
        Sleep 250
        Send "{Down}"
        Sleep 250
        Send "{Tab}"

        ; Activity
        Send "TRA"
        Sleep 250
        Send "{Tab}"

        ; Contract
        Send "Comm"
        Sleep 250
        Send "{Tab}"

        ; Spacing
        Send "S"
        Sleep 250
        Send "{Tab}"
    }
}