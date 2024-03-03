Music = {}

function Music:load()
    self.track = love.audio.newSource("assets/illegals.mp3", "stream")
    if not self.track then
        print("Failed to load music")
    else
        self.track:setLooping(true)
        self.track:setVolume(1)
        love.audio.play(self.track) 
    end
end

return Music
