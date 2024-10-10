#Requires AutoHotkey v2.0
#Include "../helpers.ahk"

; Not sure if this is a bug or not
; Shift + Enter triggers a 'phantom' paragraph that breaks navigation
+Enter:: Send "{Enter}"

; Rebind Ctrl+S to Alt+S
^s:: Send("!s")

; Focus the document no matter what
; Alt+D *does* focus the document, but sometimes Chrome steals the hotkey because it's a system hotkey
!d::
FocusDocument(*) {
    ExecuteJS("CKEDITOR.instances.documentEditor.focus()")
}

!+a::
HidePreviousAudio(*) {
    ExecuteJSOnQuerySelector("#documentEditorAudio-container > button[ng-if^='$ctrl.previousChildJobId']", "e.click()")
}

:?:%::per cent