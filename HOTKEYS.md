# Hotkeys

There's a few shortcuts provided here, as well as providing an easy jumping off point for adding more.  For general help, check the [Autohotkey documentation](https://www.autohotkey.com/docs/v2/howto/WriteHotkeys.htm).

## Note
A number of hotstrings end with '`'.  This is a way of signalling that this is a hotstring that should only be added on manual invocation, and can be triggered either with F3 or Ctrl+Space, Ctrl+., Ctrl+', etc.


### General
- [Play/Pause](./general.ahk): Toggle play/pause for a specific window (Disabled by default)

### NS
- [Ctrl+Z, Ctrl+Y](./ns/UndoRedo.ahk): Undo/Redo with additional safety for the Ctrl+Z bug.
- [Ctrl+Shift+[, Ctrl+Shift+]](./ns/Interruptions.ahk): Interrupt out/in.
- [Ctrl+Shift+?](./ns/WitnessQA.ahk): ?--
- [Ctrl+Shift+P](./ns/WitnessQA.ahk): ?--Privilege.
- [Ctrl+Shift+Y](./ns/WitnessQA.ahk): ?--Yes.
- [Ctrl+S](./ns/Misc.ahk): Save
- [Alt+D](./ns/Misc.ahk): Focus document
- [Alt+Shift+A](./ns/Misc.ahk): Toggle previous audio
- [Ctrl+O](./ns/OpenAs.ahk): Open selected text as Matter Artefact / ComCourts file
- [Ctrl+Space, Ctrl+,, Ctrl+., Ctrl+', Ctrl+/, Ctrl+;, Ctrl+Shift+:](./ns/HotstringKeys.ahk): Trigger manual hotstring with a space, comma, full stop, apostrophe, slash, semicolon or colon.
- [F3](./ns/OpenAs.ahk): Trigger manual hotstring
- [Win+H, Alt+Shift+H](./hotstrings.ahk): Define new hotstring

### Hotstrings
See [ComCourts](./comcourts.ahk) and [Hotstrings](./hotstrings.ahk).