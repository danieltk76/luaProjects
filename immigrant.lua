Immigrant = {}

function Immigrant:load()
    self.img = love.graphics.newImage("assets/bindle.png")
    self.width = self.img:getWidth()
    self.height = self.img:getHeight()
    self.x = love.graphics.getWidth() - self.width
    self.y = love.graphics.getHeight() / 7
    self.yVel = 0
    self.xVel = -500
    self.speed = 5
    self.timer = 1
    self.rate = 1


end

function Immigrant:update(dt)
    self:move(dt)
    self.timer = self.timer + dt

    if self.timer > self.rate then
        self.timer = 0
    end

end

function Immigrant:move(dt)
    self.x = self.x + self.xVel * dt

end

function Immigrant:draw()
    love.graphics.draw(self.img, self.x, self.y)

end



