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

    connect: (txScore, txTimer) =>
        txScore.text = tostring @score
        txTimer.text = "%.1f"\format @timer

    gameover: =>
        return with gameover = @timer <= 0
            if @playing and gameover
                @playing = false
                @win.scene\action am.play "gameover.ogg"


    update: (dt) =>
        with @win
            return \close! if \key_pressed"q" and (\key_down"lctrl" or \key_down"rctrl")

        if @win\key_released"escape"
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
            @win.scene\action am.play "eaten.ogg"
            @food\start!
            @score += 1
            @timer = 100 / (9 + @score)
