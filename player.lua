player = { x = 200, y = 710, speed = 250, img = nil }
canShoot = true
canShootTimerMax = 0.2 
canShootTimer = canShootTimerMax

isAlive = true
score = 0

-- Image Storage
bulletImg = nil

-- Entity Storage
bullets = {} -- array of current bullets being drawn and updated

function player_load()
    player.img = love.graphics.newImage('assets/Aircraft_01.png')
    bulletImg = love.graphics.newImage('assets/bullet_2_blue.png')
end

function player_attack(dt)
    if love.keyboard.isDown(' ', 'rctrl', 'lctrl', 'ctrl') and canShoot then
        -- Create some bullets
        newBullet = { x = player.x + (player.img:getWidth()/2), y = player.y, img = bulletImg }
        table.insert(bullets, newBullet)
        canShoot = false
        canShootTimer = canShootTimerMax
    end
end

function player_movement(dt)
    if love.keyboard.isDown('left','a') then
        if player.x > 0 then -- binds us to the map
            player.x = player.x - (player.speed*dt)
        end
    elseif love.keyboard.isDown('right','d') then
        if player.x < (love.graphics.getWidth() - player.img:getWidth()) then
            player.x = player.x + (player.speed*dt)
        end
    end
end


function bullet_update(dt)
    -- update the positions of bullets
    for i, bullet in ipairs(bullets) do
        bullet.y = bullet.y - (250 * dt)

        if bullet.y < 0 then -- remove bullets when they pass off the screen
            table.remove(bullets, i)
        end
    end

    canShootTimer = canShootTimer - (1 * dt)
    if canShootTimer < 0 then
      canShoot = true
    end
end

function exit_code()
    if love.keyboard.isDown('escape') then
        love.event.push('quit')
    end
end 


function player_draw()
    love.graphics.draw(player.img , player.x, player.y)
    for i, bullet in ipairs(bullets) do
      love.graphics.draw(bullet.img, bullet.x, bullet.y)
    end
end