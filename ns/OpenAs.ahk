#Requires AutoHotkey v2.0
#Include "../helpers.ahk"

global OpenAsText := ""

; Create the popup menu by adding some items to it.
OpenAsMenu := Menu()
OpenAsMenu.Add("&Matter Artefact", OpenAsMatterArtefact)
OpenAsMenu.Add("ComCourts &eSearch", OpenAsComCourtsESearch)

OpenAsMatterArtefact(*) {
    global OpenAsText
    Run "https://viqaus.sharepoint.com/sites/mas-comcourts/ComCourts/Forms/AllItems.aspx?view=7&sortField=Modified&isAscending=false&q=`"" . UrlEscape(TrimAllWhitespace(OpenAsText)) . "`""

    ; TODO: Find a way to reimplement vimium but not hardcoded for my screen
    ; if (WinWaitActive("AUS- Matter Artefacts- ComCourts - ComCourts - All Documents - Google Chrome", , 30)) {
    ;     VimiumNavigateLink("")

    ;     if (WinWaitNotActive("AUS- Matter Artefacts- ComCourts - ComCourts - All Documents - Google Chrome", , 10)) {
    ;         DebugStack.Send "^+{tab}"

    ;         if (WinWaitActive("AUS- Matter Artefacts- ComCourts - ComCourts - All Documents - Google Chrome", , 10)) {
    ;             DebugStack.Send "^w"
    ;         }
    ;     }
    ; }
}

OpenAsComCourtsESearch(*) {
    global OpenAsText
    Run "https://www.comcourts.gov.au/file/Federal/P/" . TrimAllWhitespace(OpenAsText) . "/actions"
}

^o::
OpenFileNumber(*) {
    global OpenAsText
    OpenAsText := CopyText(1000)
    
    X := 0
    Y := 0
    MouseGetPos(&X, &Y)
    OpenAsMenu.Show(X, Y)
}