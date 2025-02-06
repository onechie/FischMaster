handleLine(fishLine, keyPress, keyDown) {
    minimizer := 2
    Send(keyPress)
    loop 8 {
        if (!fishLine.hasFound()) {
            return
        }
        Sleep(64)
    }
    Send(keyDown)
    loop 4 {
        if (!fishLine.hasFound()) {
            return
        }
        Sleep(64)
    }
    loop 3 {
        if (!fishLine.hasFound()) {
            return
        }
        Send(keyPress)
        Sleep(512 / minimizer)
        Send(keyDown)
        Sleep(384 / minimizer)
        minimizer *= 2
    }
    return
}