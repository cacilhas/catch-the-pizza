#!amulet
local *

class Food

    pos: vec2 0

    new: (win) =>
        @win = win
        @start!

    start: =>
        with @win
            x = math.random! * .width + .left
            y = math.random! * .height + .bottom
            @pos = vec2 x, y

    connect: (translate) =>
        translate.position2d = @pos
