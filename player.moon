#!amulet
local *

delta = 32
max = vec2 512, 512

class Player

    pos: vec2 0
    speed: vec2 0

    new: (win) =>
        @win = win

    connect: (translate) =>
        translate.position2d = @pos

    update: (dt) =>
        with @win
            dx, dy = @speed.x, @speed.y
            dx -= delta if \key_down"left"
            dx += delta if \key_down"right"
            dy += delta if \key_down"up" or \key_down"rshift"
            dy -= delta if \key_down"down"
            @speed = math.clamp vec2(dx, dy), -max, max

            @pos += @speed * dt
            x, y = @pos.x, @pos.y

            x = .right if x < .left
            x = .left if x > .right
            y = .bottom if y > .top
            y = .top if y < .bottom
            @pos = vec2 x, y
