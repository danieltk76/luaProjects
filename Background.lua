Background = {}

function Background:load()

    self.universe = love.graphics.newImage("assets/border.jpg")

    imgWidth, imgHeight = self.universe:getWidth(), self.universe:getHeight()

    scaleX, scaleY = 1280 / imgWidth, 720 / imgHeight
end

function Background:update()

end

function Background:draw()

    love.graphics.draw(self.universe, 0, 0, 0, scaleX, scaleY)
end
