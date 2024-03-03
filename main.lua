require("player")
require("ball")
require("ai")
require("Background")
require("music")
require("immigrant")


function love.load()
    Background:load()
    Ball:load()
    Player:load()
    AI:load()
    Immigrant:load()
    Music:load()


    end

function love.update(dt)
    Background:update(dt)
    Player:update(dt)
    Ball:update(dt)
    AI:update(dt)
    Immigrant:update(dt)
end
-- needs background first so its first on template
function love.draw()
    Background:draw()
    Player:draw()
    Ball:draw()
    Immigrant:draw()
    AI:draw()
end

function checkCollision(a, b)
    if a.x + a.width > b.x and a.x < b.x + b.width and a.y + a.height > b.y and a.y < b.y + b.height then
        return true
    else
        return false
    end

end
