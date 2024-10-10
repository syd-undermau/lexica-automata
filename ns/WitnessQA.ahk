#Requires AutoHotkey v2.0

#Include "../helpers.ahk"
#Include "../InputHooks.ahk"

; Okay, these functions are a bit more complicated, so I'll do my best to explain as we go.
; The tl;dr is that these allow you to easily define a set of common responses such that you can press the Answer hotkey, then type a hotstring, and it'll autofinish.

; So, you can press Ctrl+? to trigger QA, then press "tir;" to trigger "That is right."  Alternatively, "qatir;" will do the same thing

global QuestionAnswerCommonResponses := Map()
global QuestionAnswerMaxLen := 0
SendQA(Sentence, Interject := false) {
    ; Erase the backspace
    Send("{bs}")

    if Interject {
        ; Send the space
        SendForSelf("{Space}")

        ; Then send the interject QA
        Send("!g")
    }
    else {
        ; Otherwise, just send the normal QA
        Send("!b")
    }

    SendText(Sentence)
    Send("{enter 2}")
    BlockEnter()
}

DefineQA(Shorthand, Sentence) {
    global QuestionAnswerCommonResponses
    global QuestionAnswerMaxLen

    Shorthand .= ";"

    ; Convert the shorthand to lowercase, and store the maximum length of the shorthand
    QuestionAnswerCommonResponses.Set(StrLower(Shorthand), Sentence)
    QuestionAnswerMaxLen := Max(QuestionAnswerMaxLen, StrLen(Shorthand))

    Hotstring(":C*:qa" . Shorthand, (*) => SendQA(Sentence))
    Hotstring(":C*:qai" . Shorthand, (*) => SendQA(Sentence, true))
}

^+/::
WitnessAnswer(ThisHotkey, Prefix?, Interject := false) {
    global QuestionAnswerCommonResponses
    global QuestionAnswerMaxLen

    ; Trigger the hotkey if we have one
    TriggerHotkey(ThisHotkey)

    if Interject {
        ; Send the space
        SendForSelf("{Space}")

        ; Then send the interject QA
        Send("!g")
    }
    else {
        ; Otherwise, just send the normal QA
        Send("!b")
    }

    if IsSet(Prefix) {
        Send(Prefix)
    }

    Hotstring("Reset")

    IH := NoSemiInputHook("T2VL" . QuestionAnswerMaxLen, "{Enter};{Esc}")
    IH.KeyOpt("{Enter};", "+S-V")
    IH.Start()
    IH.Wait()

    Input := StrLower(IH.Input)
    switch IH.EndKey {
        case ";": Input .= IH.EndKey
        case "Enter": Input .= ";"
    }

    if QuestionAnswerCommonResponses.Has(Input) {
        Send("{bs " . (StrLen(Input) - 1) . "}")
        SendText(QuestionAnswerCommonResponses.Get(Input))
        Send("{enter 2}")
        BlockEnter()
    } else {
        switch IH.EndKey {
            case "Enter": Send("{Enter}")
            case ";": Send(";")
        }
    }

    Hotstring("Reset")
}

^!+/::
WitnessInterruptAnswer(ThisHotkey) => WitnessAnswer(ThisHotkey,, true)

^+p::
WitnessAnswerPrivilege(ThisHotkey) => WitnessAnswer(ThisHotkey, "Privilege.  ")

^+y::
WitnessAnswerYes(ThisHotkey) => WitnessAnswer(ThisHotkey, "Yes.")

DefineQA("c", "Correct.")
DefineQA("tc", "That's correct.")
DefineQA("tic", "That is correct.")
DefineQA("y", "Yes.")
DefineQA("n", "No.")
DefineQA("yc", "Yes, correct.")
DefineQA("tr", "That's right.")
DefineQA("tir", "That is right.")
DefineQA("mmm", "Mmm.")
DefineQA("mhm", "Mhm.")