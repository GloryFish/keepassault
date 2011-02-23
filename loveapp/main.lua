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
require 'level'
require 'player'

require 'utility'
require 'colors'
require 'astar'

function love.load()
  
  -- Seed random
  local seed = os.time()
  math.randomseed(seed);
  math.random(); math.random(); math.random()
  
  log = Logger(vector(5, 5))
  
  lvl = Level('levelone')
  astar = AStar(lvl)
  
  playerA = Player('Jay', 
                   colors.red, 
                   lvl:toWorldCoordsCenter(vector(1, 1)), 
                   vector(1, 1),
                   lvl)
end

function love.keypressed(key, unicode)
  if key == 'escape' then
    love.event.push('q')
  end
end

function love.mousepressed(x, y, button)
  playerA:setTarget(lvl:toTileCoords(vector(x, y)))
end

function love.mousereleased(x, y, button)
end


function love.update(dt)
  log:update(dt)
  log:addLine(string.format('Wor Prototype'))
  
  playerA:update(dt, lvl)
  
  if playerA.path ~= nil then
    log:addLine(string.format('Path found'))
  else
    log:addLine(string.format('No path'))
  end
end

function love.draw()
  lvl:draw()

  playerA:draw()

  log:draw()
end