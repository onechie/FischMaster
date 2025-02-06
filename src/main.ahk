#SingleInstance Force
#Requires AutoHotkey v2.0

; Include Dependencies
#Include constants.ahk
#Include classes\Window.ahk
#Include classes\ScreenPart.ahk
#Include helpers\HandleLine.ahk
#Include phases\Throwing.ahk
#Include phases\Shaking.ahk
#Include phases\Reeling.ahk

; Global Variables
global HAS_RUNNING := false
global SHOULD_STOP := false

; GUI Setup
MAIN_GUI := Gui()
MAIN_GUI.Title := APP_NAME

title := MAIN_GUI.Add("Text", "cBlue Center w240 h20", "FischMaster")
title.SetFont("s16 bold")

subtitle := MAIN_GUI.Add("Text", "Center w240", "Developed By Chie")
subtitle.SetFont("s8 italic")
MAIN_GUI.Add("Text", "", "--------------------------------------------------------------------------------")
MAIN_GUI.SetFont("S8")
MAIN_GUI.Add("Text", "cGreen Center w240", "[Ctrl+1] = Auto Fish")
MAIN_GUI.Add("Text", "cGreen Center w240", "[Ctrl+2] = Auto Shake")
MAIN_GUI.Add("Text", "cGreen Center w240", "[Ctrl+3] = Auto Reel")
MAIN_GUI.Add("Text", "cRed Center w240", "[Ctrl+0] = Stop Process")
MAIN_GUI.Add("Text", "cRed Center w240", "[End] = Exit App")

MAIN_GUI.Add("Text", "w280", "--------------------------------------------------------------------------------")
MAIN_GUI.Add("Text", "cBlack Center w240", "Welcome to FischMaster!")
MAIN_GUI.Add("Text", "w280", "--------------------------------------------------------------------------------")
MAIN_GUI.SetFont("S10")
startButton := MAIN_GUI.Add("Button", "h40 w240", "Start Auto Fish")
startButton.OnEvent("Click", StartApp)

MAIN_GUI.Show("w260 h350")

; Hotkeys
^1:: StartApp
^2:: StartPhase(ShakingMechanics)
^3:: StartPhase(ReelingMechanics)
^0:: StopApp
End:: ExitApp

; Function to Start the Main Loop
StartApp(*) {
    global HAS_RUNNING, SHOULD_STOP
    if (HAS_RUNNING) {
        ToolTip("A process is already running!", 50, 260, 3)
        return
    }
    try {
        WinActivate(TARGET_APP_NAME)
        WinMaximize(TARGET_APP_NAME)
        ToolTip("Press Ctrl+0 to stop.", 50, 240, 2)
        HAS_RUNNING := true
        AppLoop()
    } catch Error as err {
        MsgBox(err.Message)
    }
}

; Function to Start a Single Phase (Shaking/Reeling)
StartPhase(func) {
    global HAS_RUNNING
    if (HAS_RUNNING) {
        ToolTip("Stop the current process first!", 50, 260, 3)
        return
    }
    ToolTip("Press Ctrl+0 to stop.", 50, 240, 2)
    ToolTip("Process Stopped.", 50, 260, 3)
    HAS_RUNNING := true
    WinActivate(TARGET_APP_NAME)
    WinMaximize(TARGET_APP_NAME)
    func() 
    HAS_RUNNING := false
}

; Function to Stop the Running Process
StopApp(*) {
    global HAS_RUNNING, SHOULD_STOP
    if (HAS_RUNNING) {
        SHOULD_STOP := true
        ToolTip("Stopping Immediately.", 50, 260, 3)
    }
}
; Main App Loop
AppLoop(*) {
    global HAS_RUNNING, SHOULD_STOP
    loop {
        if (SHOULD_STOP) {
            ToolTip("Process Stopped.", 50, 260, 3)
            HAS_RUNNING := false
            SHOULD_STOP := false
            return
        }
        if (ThrowingMechanics() == "shake") {
            ShakingMechanics()
        }
        ReelingMechanics()
    }
}
