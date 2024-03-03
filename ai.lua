AI = {}


function AI:load()
    self.img = love.graphics.newImage("assets/realmex.png")
    self.width = self.img:getWidth()
    self.height = self.img:getHeight()
    self.x = love.graphics.getWidth() - self.width - 50
    self.y = love.graphics.getHeight() / 2
    self.yVel = 0
    self.speed = 700
    self.timer = 0.5
    self.rate = 0.5

end

function AI:update(dt)

    self:move(dt)
    self.timer = self.timer + dt

    if self.timer > self.rate then
        self.timer = 0
        self:aquireTarget()
    end
end

function AI:move(dt)

    self.y = self.y + self.yVel * dt
end

function AI:aquireTarget()
    if Ball.y + Ball.height < self.y then
        self.yVel = -self.speed
    elseif Ball.y > self.y + self.height then
        self.yVel = self.speed
    else
        self.yVel = 0

    end

end


function Player:checkBoundaries()
    if self.y < 0 then
        self.y = 0
    elseif self.y + self.height > love.graphics.getHeight() then
        self.y = love.graphics.getHeight() - self.height
    end
end


function AI:draw()
    love.graphics.draw(self.img, self.x, self.y)

end