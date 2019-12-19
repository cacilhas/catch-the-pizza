#!amulet
local *


class Game

    score: 0
    timer: 10
    playing: true

    new: (win, player, food) =>
        @win = win
        @player = player
        @food = food

    connect: (t) =>
        t.score.text = tostring @score
        t.timer.text = "%.1f"\format @timer

    gameover: =>
        return with gameover = @timer <= 0
            if @playing and gameover
                @playing = false
                @win.scene\action am.play "resources/gameover.ogg"


    update: (dt) =>
        with @win
            return \close! if \key_pressed"escape"

            if \key_released"enter" or \key_released"f5"
                @playing = true
                @timer = 10
                @score = 0
                @player.pos = vec2 0
                @player.speed = vec2 0
                @food\start!
                return

        @timer -= dt
        @timer = math.clamp @timer, 0, 10
        if math.distance(@player.pos, @food.pos) < 64
            @win.scene\action am.play "resources/eaten.ogg"
            @food\start!
            @score += 1
            @timer = 100 / (9 + @score)
