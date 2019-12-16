#!amulet
local *

playerFacet = assert require"player-facet"
pizzaFacet = assert require"pizza-facet"
Game = assert require"game"
Player = assert require"player"
Pizza = assert require"pizza"

win = am.window
    title: "Catch the Pizza"
    width: 1024
    height: 768
    clear_color: vec4 1, 0, 0, 1

with am
    win.scene = .group! ^ {
        .translate(-400, 360) ^ .scale(2) ^ am.text("10.0", nil, "right")\tag"timer"
        .translate(460, 360) ^ .scale(2) ^ am.text("00", nil, "right")\tag"score"
        .translate(0, 0)\tag"player" ^ .scale(4) ^ .sprite playerFacet
        .translate(0, 0)\tag"pizza" ^ .scale(4) ^ .sprite pizzaFacet
        .scale(4) ^ am.text("GAME OVER", vec4(0, 0, 0, 1))\tag"gameover"
    }

player = Player win
pizza = Pizza win
game = Game win, player, pizza

win.scene\action (scene) ->
    game\update am.delta_time

    if game\gameover!
        scene"gameover".hidden = false

    else
        scene"gameover".hidden = true
        player\update am.delta_time
        player\connect scene"player"
        pizza\connect scene"pizza"
        game\connect scene"score", scene"timer"
