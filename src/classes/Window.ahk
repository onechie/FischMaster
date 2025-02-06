class Window {
    WINDOW_HEIGHT := 0
    WINDOW_WIDTH := 0

    GetWindowSize() {
        tempWidth := 0
        tempHeight := 0
        Pos := WinGetPos(, , &tempWidth, &tempHeight, TARGET_APP_NAME)
        this.WINDOW_WIDTH := tempWidth
        this.WINDOW_HEIGHT := tempHeight
    }
}