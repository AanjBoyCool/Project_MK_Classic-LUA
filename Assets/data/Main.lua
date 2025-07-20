local player = require("Player")
local selection = require("Selection_Screen")
local bg = {}
bg.x = -110
bg.y = 0
bg.image = love.graphics.newImage('sprites/Moon.png')
function love.load()
    player.load()
end

function bg.move(dt)
    if bg.x <= -160 then
        bg.x = -160
    end
    if bg.x >= 0 then
        bg.x = 0
    end
end

function love.update(dt)
    bg.move(dt)
    if love.keyboard.isDown("left")then
        bg.x = bg.x + 200 * dt
    end
    if love.keyboard.isDown("right")then
        bg.x = bg.x - 200 * dt
    end

    player.update(dt)
end


function love.draw()
    love.graphics.draw(bg.image, bg.x, bg.y, 0, 2.7, 2.35)
    player.draw()
end