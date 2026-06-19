Option Explicit

Dim shell, fso, filePath, ts, text, result, msg

Set shell = CreateObject("WScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")

filePath = "C:\ProgramData\BlueStacks_nxt\bluestacks.conf"

result = MsgBox("Selecciona modo:" & vbCrLf & vbCrLf & _
"YES = 60 FPS" & vbCrLf & _
"NO = 240 FPS" & vbCrLf & _
"CANCEL = Salir", vbYesNoCancel + vbQuestion, "BlueStacks FPS")

If result = vbCancel Then WScript.Quit

shell.Run "taskkill /F /IM HD-Player.exe /T", 0, True
WScript.Sleep 1500

If Not fso.FileExists(filePath) Then
    MsgBox "No se encontro bluestacks.conf", vbCritical
    WScript.Quit
End If

Set ts = fso.OpenTextFile(filePath, 1)
text = ts.ReadAll
ts.Close

' 🔥 LIMPIEZA SEGURA (EVITA CORRUPCIÓN)
text = Replace(text, vbCrLf & vbCrLf, vbCrLf)

If result = vbYes Then
    ' SOLO REEMPLAZO LIMPIO
    text = Replace(text, "bst.instance.Pie64.max_fps=""240""", "bst.instance.Pie64.max_fps=""60""")
    text = Replace(text, "bst.instance.Pie64.max_fps=240", "bst.instance.Pie64.max_fps=""60""")
    msg = "60 FPS activado"
Else
    text = Replace(text, "bst.instance.Pie64.max_fps=""60""", "bst.instance.Pie64.max_fps=""240""")
    text = Replace(text, "bst.instance.Pie64.max_fps=60", "bst.instance.Pie64.max_fps=""240""")
    msg = "240 FPS activado"
End If

Set ts = fso.OpenTextFile(filePath, 2)
ts.Write text
ts.Close

shell.Run """C:\Program Files\BlueStacks_nxt\HD-Player.exe""", 0

MsgBox msg, vbInformation, "OK"