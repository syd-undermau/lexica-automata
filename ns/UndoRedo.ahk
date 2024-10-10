#Requires AutoHotkey v2.0
#Include "../helpers.ahk"

; *so*
; There's currently a bug in NS where entering inaudible review mode creates issues with the lock stack in the editor.  
; Specifically, it can delete everything since you entered review mode
; This remaps undo/redo to forcibly unlock the stack before triggering undo/redo, which prevents these issues with undo state
; As a side effect, these are slightly more annoying to use, but much *much* more reliable

global __InDangerMode := false
global __DangerLocked := false

; A slightly more unsafe compromise is also provided, where the manual unlock is only triggered if we've recently entered the inaudible review mode
; If you want to enable that, change this to := false
global __MaximiseUndoSafety := true

^z::
Undo(*) {
    global __DangerLocked
    global __MaximiseUndoSafety

    if __MaximiseUndoSafety or __DangerLocked {
        __DangerLocked := false
        JSTriggerDocumentUnlock("CKEDITOR.instances.documentEditor.undoManager.undo()")
    } else {
        Send("^z")
    }
}
^y::
Redo(*) {
    global __DangerLocked
    global __MaximiseUndoSafety

    if __MaximiseUndoSafety or __DangerLocked {
        __DangerLocked := false
        JSTriggerDocumentUnlock("CKEDITOR.instances.documentEditor.undoManager.redo()")
    } else {
        Send("^y")
    }
}

^!c::
EnterDangerMode(*) {
    global __InDangerMode
    global __DangerLocked

    if __InDangerMode {
        __InDangerMode := false
        __DangerLocked := false
    } else {
        __InDangerMode := true
        __DangerLocked := true
    }
}