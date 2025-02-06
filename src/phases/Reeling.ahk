ReelingMechanics(*) {
    FishLine1 := ScreenPart(30, 45, 85, 87, "0x434b5b", 0)
    FishLine2 := ScreenPart(45, 55, 85, 87, "0x434b5b", 0)
    FishLine3 := ScreenPart(55, 70, 85, 87, "0x434b5b", 0)

    previousResult := 0
    failAttempt := 0
    ToolTip("Current Status: Reeling", 50, 200, 1)
    loop {
        if (FishLine1.hasFound()) {
            if (previousResult != 1) {
                Send("{LButton up}")
            }
            previousResult := 1
        } else if (FishLine2.hasFound()) {
            switch previousResult {
                case 1:
                    previousResult := 2
                    handleLine(FishLine2, "{LButton down}", "{Lbutton up}")
                case 3:
                    previousResult := 2
                    handleLine(FishLine2, "{LButton up}", "{Lbutton down}")
                default:
                    Send("{LButton down}")
                    Sleep(64)
                    Send("{LButton up}")
                    Sleep(48)

            }
        } else if (FishLine3.hasFound()) {
            if (previousResult != 3) {
                Send("{LButton down}")
            }
            previousResult := 3
        } else {
            if (failAttempt > 10) {
                ToolTip("Current Status: Reeling Finished", 50, 200, 1)
                return
            }
            failAttempt++
            Sleep(200)
        }
    }
}
