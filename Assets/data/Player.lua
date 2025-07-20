love.graphics.setDefaultFilter("nearest", "nearest") -- Helps to not smoothen out the pixels so that its not blurry
local anim8 = require("libraries/anim8") -- Spritesheet file
local player = {} -- Player Variable

player.x = love.graphics.getWidth() / 2
player.y = 300
player.groundY = 300
player.gravity = 10
player.speed = 200
player.spriteSheet = love.graphics.newImage('sprites/Scorpion.png')
player.grid = anim8.newGrid( 57, 120, player.spriteSheet:getWidth(), player.spriteSheet:getHeight() )
player.gridIdle = anim8.newGrid( 60, 120, player.spriteSheet:getWidth(), player.spriteSheet:getHeight() )
player.gridJump = anim8.newGrid( 56, 120, player.spriteSheet:getWidth(), player.spriteSheet:getHeight() )

player.animations = {} -- All the animations needed for the player to walk, fairly the same for all of the characters
player.animations.walk = anim8.newAnimation( player.grid('1 - 8', 2), 0.2 )
player.animations.walk2 = anim8.newAnimation( player.grid('8 - 1', 2), 0.2 )
player.animations.idle = anim8.newAnimation( player.gridIdle('2 - 7', 1), 0.2 )
player.animations.jump = anim8.newAnimation( player.gridJump('13 - 18', 2), 0.2 )

player.anim = player.animations.idle
function player.load()
end

function player.bgEnd(dt)
    if player.x <= 0 then
        player.x = 0
    end
    if player.x >= 700 then
        player.x = 700
    end
end


function player.gravityFunction(dt)

    if love.keyboard.isDown("up") then
        player.y = player.y - player.gravity
    else
        player.y = player.y + player.gravity
    end

    if player.y >= player.groundY then
        player.y = player.groundY
    end
    if player.y <=100 then
        player.y = 100
    end
end

function player.update(dt)
    player.bgEnd(dt)
    player.gravityFunction(dt)
    local isMoving = false
    if love.keyboard.isDown("left") then
        player.x = player.x - player.speed * dt
        player.anim = player.animations.walk2
        isMoving = true
    end

    if love.keyboard.isDown("right") then
        player.x = player.x + player.speed * dt
        player.anim = player.animations.walk
        isMoving = true
    end
    if love.keyboard.isDown("up") then
        isMoving = true
        player.anim = player.animations.jump
    end

    if isMoving == false then
        player.anim = player.animations.idle
    end


    player.anim:update(dt)
end


function player.draw()
    player.anim:draw(player.spriteSheet, player.x, player.y, nil, 2)
end

return player