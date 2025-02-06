ThrowingMechanics() {
    FishLine := ScreenPart(30, 70, 85, 87, "0x434b5b", 0)
    ClickShakeSearch := ScreenPart(20, 80, 10, 75, "0xFFFFFF", 0)
    ToolTip("Current Status: Throwing", 50, 200, 1)
    loop 50 {
        MouseMove(800, 400)
        Send("{LButton down}")
        Sleep(1000)
        Send("{LButton up}")
        Sleep(200)
        clickLocation := ClickShakeSearch.getAxis()
        if (clickLocation.result == true) {
            ToolTip("Current Status: Throwing Finished", 50, 200, 1)
            return "shake"
        } else if (FishLine.hasFound()) {
            ToolTip("Current Status: Throwing Finished", 50, 200, 1)
            return "reel"
        }
    }
}
