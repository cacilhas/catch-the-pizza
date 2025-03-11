#!amulet
local *

playerFacet = assert require"facet.player"
pizzaFacet = assert require"facet.pizza"
Game = assert require"game"
Player = assert require"player"
Pizza = assert require"pizza"

math.randomseed os.time!

win = am.window
    title: "Catch the Pizza"
    mode: "fullscreen"
    clear_color: vec4 0.133, 0.125, 0.204, 1
    lock_pointer: true

timerX = win.left + 112
scoreX = win.right - 52
labelsY = win.top - 52

with am
    win.scene = .group! ^ {
        .translate(timerX, labelsY) ^ .scale(2) ^ am.text("10.0", nil, "right")\tag"timer"
        .translate(scoreX, labelsY) ^ .scale(2) ^ am.text("00", nil, "right")\tag"score"
        .translate(0, 0)\tag"player" ^ .scale(4) ^ .sprite playerFacet
        .translate(0, 0)\tag"pizza" ^ .scale(4) ^ .sprite pizzaFacet
        .scale(4) ^ am.text("GAME OVER", vec4(0, 0, 0, 1))\tag"gameover"
    }

player = Player win
pizza = Pizza win
game = Game win, player, pizza

win.scene\action =>
    game\update am.delta_time

    if game\gameover!
        @"gameover".hidden = false

    else
        @"gameover".hidden = true
        player\update am.delta_time
        player\connect @"player"
        pizza\connect @"pizza"
        game\connect
            score: @"score"
            timer: @"timer"
