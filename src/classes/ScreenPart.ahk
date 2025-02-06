class ScreenPart extends Window {
    LEFT := 0
    RIGHT := 0
    TOP := 0
    BOTTOM := 0
    PIXEL := ""
    TOLERANCE := 0
    __New(left_percent, right_percent, top_percent, bottom_percent, pixel_to_search, color_tolerance) {
        this.GetWindowSize()
        this.LEFT := this.CalculatePosition(left_percent, this.WINDOW_WIDTH)
        this.RIGHT := this.CalculatePosition(right_percent, this.WINDOW_WIDTH)
        this.TOP := this.CalculatePosition(top_percent, this.WINDOW_HEIGHT)
        this.BOTTOM := this.CalculatePosition(bottom_percent, this.WINDOW_HEIGHT)
        this.PIXEL := pixel_to_search
        this.TOLERANCE := color_tolerance
    }

    CalculatePosition(percent, size) {
        return Floor((percent * 0.01) * size)
    }

    getAxis() {
        tempX := 0
        tempY := 0
        pixelFound := PixelSearch(&tempX, &tempY, this.LEFT, this.TOP, this.RIGHT, this.BOTTOM, this.PIXEL, this.TOLERANCE
        )
        if (pixelFound) {
            return { x: tempX, y: tempY, result: true }
        }
        return { x: 0, y: 0, result: false }
    }
    hasFound() {
        tempX := 0
        tempY := 0
        return PixelSearch(&tempX, &tempY, this.LEFT, this.TOP, this.RIGHT, this.BOTTOM, this.PIXEL, this.TOLERANCE)
    }
    getWidth() {
        return this.LEFT - this.RIGHT
    }
    getHeight() {
        return this.TOP - this.BOTTOM
    }

}
