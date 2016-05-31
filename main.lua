debug = true
require "player"
require "enemies"
require "utils"



function love.load(arg)
    player_load()
    enemy_load()
end

-- Updating
function love.update(dt)
    -- I always start with an easy way to exit the game
    exit_code()
    if isAlive then
        player_movement(dt)

        player_attack(dt)

        bullet_update(dt)

        enemies_update(dt)
    else
        if not isAlive and love.keyboard.isDown('r') then
            -- remove all our bullets and enemies from screen
            bullets = {}
            enemies = {}

            -- reset timers
            canShootTimer = canShootTimerMax
            createEnemyTimer = createEnemyTimerMax

            -- move player back to default position
            player.x = 50
            player.y = 710

            -- reset our game state
            score = 0
            isAlive = true
        end

    end

end

function love.draw(dt)

    if isAlive then
        player_draw()
        enemy_draw()
    else
        love.graphics.print("Press 'R' to restart", love.graphics:getWidth()/2-50, love.graphics:getHeight()/2-10)
    end

end