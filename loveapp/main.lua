-- 
--  main.lua
--  xenofarm
--  
--  Created by Jay Roberts on 2011-01-20.
--  Copyright 2011 GloryFish.org. All rights reserved.
-- 

require 'middleclass'
require 'middleclass-extras'

require 'logger'

function love.load()
  
  -- Seed random
  local seed = os.time()
  math.randomseed(seed);
  math.random(); math.random(); math.random()
  
  log = Logger(vector(5, 5))
end


function love.mousepressed(x, y, button)
end

function love.mousereleased(x, y, button)
end


function love.update(dt)
  log:update(dt)
  log:addLine(string.format('Wor Prototype'))
end

function love.draw()
  log:draw()
end