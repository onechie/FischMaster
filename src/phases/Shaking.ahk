ShakingMechanics(*) {
    FishLine := ScreenPart(30, 70, 85, 87, "0x434b5b", 0)
    ClickShakeSearch := ScreenPart(20, 80, 20, 75, "0xFFFFFF", 0)
    clickLocation := {}
    previousX := 0
    previousY := 0
    failAttempt := 0
    clicks := 0
    ToolTip("Current Status: Shaking", 50, 200, 1)
    loop {
        Sleep(200)
        clickLocation := ClickShakeSearch.getAxis()
        if (clickLocation.result == true) {
            if (clickLocation.x != previousX && clickLocation.y != previousY) {
                MouseMove(clickLocation.x, clickLocation.y, 1)
                Click("L", clickLocation.x + 1, clickLocation.y + 1)
                clicks := clicks + 1
                previousX := clickLocation.x
                previousY := clickLocation.y
            } else {
                previousX := 0
                previousY := 0
            }
        } else {
            if (failAttempt > 10 || FishLine.hasFound()) {
                ToolTip("Current Status: Shaking Finished", 50, 200, 1)
                return
            }
            failAttempt++
            Sleep(50)
        }
    }
}
