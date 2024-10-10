#Requires AutoHotkey v2.0
Persistent

VERSION_CHECK_FILE := A_ScriptDir . "/" . "VERSION_CHECK"
VERSION_FILE := A_ScriptDir . "/" . "VERSION"

CheckForUpdate() {
    global VERSION_CHECK_FILE
    global VERSION_FILE

    req := ComObject("Msxml2.XMLHTTP")
    ; Open a request with async enabled.
    ; req.open("GET", "https://raw.githubusercontent.com/syd-undermau/lexica-automata/main/VERSION", true)
    req.open("GET", "https://www.autohotkey.com/download/2.0/version.txt", true)
    ; Set our callback function.
    req.onreadystatechange := OnUpdateFound
    ; Send the request.  Ready() will be called when it's complete.
    req.send()

    OnUpdateFound() {
        if (req.readyState != 4) ; Not done yet
            return

        if (req.status == 200) {
            ; Get our saved file
            NewVersion := req.responseText
            if FileExist(VERSION_CHECK_FILE)
                OurVersion := FileRead(VERSION_CHECK_FILE)
            else if FileExist(VERSION_FILE)
                OurVersion := FileRead(VERSION_FILE)
            else
                MsgBox("Uho, no version files?")

            if NewVersion = OurVersion
                return

            OurVersionSem := StrSplit(OurVersion, ".")
            NewVersionSem := StrSplit(NewVersion, ".")

            VersionPrecedence := 0

            loop Min(OurVersionSem.Length, NewVersionSem.Length) {
                NV := NewVersionSem[A_Index]
                OV := OurVersionSem[A_Index]

                if NV < OV {
                    VersionPrecedence := -1
                    break
                } else if NV > OV {
                    VersionPrecedence := 1
                    break
                }
            }

            if VersionPrecedence < 1
                return

            Result := MsgBox("A new update was found on Github (" . OurVersion . " -> " . NewVersion . ")`n`nGo there now? Press 'Cancel' to ignore this version", "Update Found", 3)
            if Result = "Yes" {
                Run "https://github.com/syd-undermau/lexica-automata"
            } else if Result = "Cancel" {
                if FileExist(VERSION_CHECK_FILE)
                    FileDelete(VERSION_CHECK_FILE)

                FileAppend(NewVersion, VERSION_CHECK_FILE)
            }
        }
    }
}

CheckForUpdate()