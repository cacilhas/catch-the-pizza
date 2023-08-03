#!amulet
local *

friction = 10
delta = 32 + friction
max = vec2 512, 512

applyFriction = =>
    if @ > 0
        @ -= friction
        @ = 0 if @ < 0
    if @ < 0
        @ += friction
        @ = 0 if @ > 0
    @

applyBoards = (win) =>
    x, y = @x, @y
    with win
        x = .right if x < .left
        x = .left if x > .right
        y = .bottom if y > .top
        y = .top if y < .bottom
    vec2 x, y


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
            mouse = \mouse_delta! * delta

            if mouse != vec2 0
                dx += mouse.x
                dy += mouse.y

            else
                dx -= delta if \key_down"left"
                dx += delta if \key_down"right"
                dy += delta if \key_down"up" or \key_down"rshift"
                dy -= delta if \key_down"down"

            dx = applyFriction dx
            dy = applyFriction dy
            @speed = math.clamp vec2(dx, dy), -max, max

        @pos += @speed * dt
        @pos = applyBoards @pos, @win
