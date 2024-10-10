#Requires AutoHotkey v2.0
#Include "./lib/UIA.ahk"
#Include "./lib/UIA_Browser.ahk"

/**
 * @param {Func} Fn 
 * @param {Integer} Level 
 */
WithSendLevel(Fn, Level := 1) {
    OldLevel := SendLevel(Level)
    try {
        Fn()
    } finally {
        SendLevel(OldLevel)
    }
}

SendForSelf(Text, Level := 1) {
    WithSendLevel(() => SendEvent(Text.HasMethod() ? Text() : Text), Level)
}

ControlSendActive(Keys, Control?, WinTitle?, WinText?, ExcludeTitle?, ExcludeText?) {
    hwnd := WinActive("A")
    if WinExist(WinTitle?, WinText?, ExcludeTitle?, ExcludeText?) {
        WinActivate
        WinWaitActive

        ControlSend(Keys, Control?, WinTitle?, WinText?, ExcludeText?, ExcludeText?)

        Sleep(A_KeyDelay)

        WinActivate(hwnd)
        WinWaitActive(hwnd)
    }
}

; We sent enter ourselves, so we want to block enter if the user presses it
BlockEnter() {
    IH := InputHook("T2V", "{Enter}")
    IH.KeyOpt("{Enter}", "+S-V")
    IH.Start()
}

ExecuteJS(js, WinTitle := "A") {
    Browser := UIA_Browser(WinTitle)
    Browser.JSExecute(js)
}

JSTriggerDocumentUnlock(AndThenDo := "") => ExecuteJS("(CKEDITOR.instances.documentEditor.undoManager.locked?(CKEDITOR.instances.documentEditor.undoManager.locked.level = 1, CKEDITOR.instances.documentEditor.undoManager.unlock()):false);" . AndThenDo)
ExecuteJSOnQuerySelector(query, ifSafe, WinTitle := "A") => ExecuteJS("((e)=>e?(" . ifSafe . ",true):false)(document.querySelector(`"" . query . "`"))")


TriggerHotkey(ThisHotkey) {
    SendForSelf(".")
    i := 0
    While ThisHotkey == A_ThisHotkey && i < 5 {
        Sleep(16)
        i += 1
    }
    Send("{Backspace}")
}

; ======================================================================================================================
; UrlEscape() -> https://docs.microsoft.com/en-us/windows/win32/api/shlwapi/nf-shlwapi-urlescapew
; URL_DONT_ESCAPE_EXTRA_INFO     = 0x02000000
; URL_ESCAPE_SPACES_ONLY         = 0x04000000
; URL_ESCAPE_PERCENT             = 0x00001000
; URL_ESCAPE_SEGMENT_ONLY        = 0x00002000
; URL_ESCAPE_AS_UTF8             = 0x00040000 (Win 7+)
; URL_ESCAPE_ASCII_URI_COMPONENT = 0x00080000 (Win 8+)
; ======================================================================================================================
UrlEscape(Url, Flags := 0) {
    EscapedSize := 4096
    Escaped := Buffer(EscapedSize)
    return DllCall("Shlwapi.dll\UrlEscape", "Str", Url, "Ptr", Escaped, "UIntP", &EscapedSize, "UInt", Flags, "UInt") == 0 ? StrGet(Escaped, EscapedSize) : ""
}


; ======================================================================================================================
; UrlUnescape() -> https://docs.microsoft.com/en-us/windows/win32/api/shlwapi/nf-shlwapi-urlunescapew
; URL_DONT_UNESCAPE_EXTRA_INFO = 0x02000000
; URL_UNESCAPE_AS_UTF8 = 0x00040000 (Win 8+)
; URL_UNESCAPE_INPLACE = 0x00100000
; ======================================================================================================================
UrlUnscape(Url, Flags := 0) {
    UnescapedSize := 4096
    Unescaped := Buffer(UnescapedSize)
    Return DllCall("Shlwapi.dll\UrlUnescape", "Str", Url, "Ptr", Unescaped, "UIntP", &UnescapedSize, "UInt", Flags, "UInt") == 0 ? StrGet(Unescaped, UnescapedSize) : ""
}

TrimAllWhitespace(s) {
    return Trim(s, A_Space A_Tab Chr(10) Chr(13) Chr(160))
}

IsWhitespace(s) {
    return StrLen(TrimAllWhitespace(s)) == 0
}

TrimAllInlineWhitespace(s) {
    return Trim(s, A_Space A_Tab Chr(160))
}

IsInlineWhitespace(s) {
    return StrLen(TrimAllInlineWhitespace(s)) == 0
}

CopyText(Timeout?, DoSelect?) {
    OldClipboard := A_Clipboard
    A_Clipboard := ""  ; Start off empty to allow ClipWait to detect when the text has arrived.
    if IsSet(DoSelect) {
        DoSelect()
    }
    Send "^c"
    IsSet(Timeout) ? ClipWait(Timeout) : ClipWait  ; Wait for the clipboard to contain text.

    CopiedText := A_Clipboard
    A_Clipboard := OldClipboard

    return CopiedText
}