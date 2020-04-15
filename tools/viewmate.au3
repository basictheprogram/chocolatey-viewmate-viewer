Const $text = "ViewMate 11.16 - InstallShield Wizard"

Func Install($config)
   Local $install = $config.Item("install")
   ConsoleWrite("Install: " & $install & @LF)

   ; Run installation program
   Run($install)

   WinWaitActive($text, "requires the following items to be installed on your computer")
   ConsoleWrite("C++ 2019" & @LF)
   Sleep(2000)
   ControlClick($text, "", "[CLASS:Button; INSTANCE:2]")

   WinWaitActive($text, "Microsoft Visual C++ 2019 Redistributable")
   ConsoleWrite("Redistributable" & @LF)
   Sleep(2000)
   Send("!y")

   WinWait("[CLASS:#32770]", "Welcome")
   ConsoleWrite("Welcome" & @LF)
   Sleep(2000)
   Send("!n")

   WinWaitActive("[CLASS:#32770]", "License Agreement")
   ConsoleWrite("License" & @LF)
   Sleep(2000)
   Send("!a")
   Send("!n")

   WinWaitActive("[CLASS:#32770]", "Serial Number")
   ConsoleWrite("Serial Number" & @LF)
   Sleep(2000)
   Send("06614505")
   Send("!n")

   WinWaitActive("[CLASS:#32770]", "Choose Destination Location")
   ConsoleWrite("Destination" & @LF)
   Sleep(2000)
   Send("!n")

   WinWaitActive("[CLASS:#32770]", "Ready to Install the Program")
   ConsoleWrite("Ready" & @LF)
   Sleep(2000)
   Send("!i")

   WinWaitActive("[CLASS:#32770]", "Launch ViewMate")
   ConsoleWrite("Launch" & @LF)
   Sleep(2000)
   ControlCommand("[CLASS:#32770]", "InstallShield Wizard Complete", "[CLASS:Button; INSTANCE:1]", "UnCheck", "")
   ControlClick("[CLASS:#32770]", "", "[CLASS:Button; INSTANCE:4]")

EndFunc

#RequireAdmin
ConsoleWrite("Starting" & @LF)

Local $config = ObjCreate("Scripting.Dictionary")
$config.Add("install", $CmdLine[1])
;$config.Add("install", "C:\projects\chocolatey\chocolatey-viewmate\ViewMate_Setup.exe")

Install($config)
ConsoleWrite("End of Install!" & @LF)
