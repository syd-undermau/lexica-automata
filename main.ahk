#Requires AutoHotkey v2.0

; We only want a single instance of this script running.  If this script is already running, we want to terminate the existing script and restart it.
#SingleInstance Force

; These are the characters that will trigger the end of a hotstring.  This is the standard list, but excludes exclamation marks, which allows it to be used in hotstrings
#Hotstring EndChars -()[]{}:;'"/\,.?`n`s

SendMode("Event")

; This is a list of browsers we want to check against.  Simply 'ahk_exe <executable name>'
BrowsersToCheck := ["ahk_exe chrome.exe", "ahk_exe firefox.exe"]

for browser in BrowsersToCheck {
    ; This is for the MitreFinch TAS Hotkey
    GroupAdd("MitreFinch", "Clock TAS" . " " . browser)

    ; And these are for NetScribe hotkeys and hotstrings.  We define the document editor itself, then an event viewer, and a demo editor page
    GroupAdd("NetScribe", "Document Editor | NetScribe" . " " . browser)
    GroupAdd("NetScribe", "Keyboard Event Viewer" . " " . browser)
    GroupAdd("NetScribe", "CKEditor 4 DEMO") ; https://www.iloveeditor.com/ckeditor4/
}


#Include "./update.ahk"
; #Include "./mitrefinch.ahk"
#Include "./netscribe.ahk"