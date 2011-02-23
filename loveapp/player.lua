-- 
--  player.lua
--  wor
--  
--  Created by Jay Roberts on 2011-02-22.
--  Copyright 2011 GloryFish.org. All rights reserved.
-- 


require 'middleclass'
require 'vector'
require 'colors'

Player = class('Player')

function Player:initialize(name, color, pos, target, level)
  self.name = name
  self.color = color
  self.position = pos
  self.size = 32
  self.target = target
  self.speed = 128
  self.velocity = vector(0, 0)
  self.level = level
  self.path = nil
end

function Player:setTarget(target)
  local newpath = self:getPath(target)
  if newpath ~= nil then
    self.target = target
    self.path = newpath
  end
end

function Player:update(dt)

  local movement = self:getAIMovement(self.target)
  
  self.velocity.x = movement.x * self.speed
  self.velocity.y = movement.y * self.speed

  self.position = self.position + self.velocity * dt
  
end

function Player:getPath(target)
  local selfTile = self.level:toTileCoords(self.position)
  local targetTile = target
  
  return astar:findPath(selfTile, targetTile)
end

function Player:getAIMovement()
  local selfTile = self.level:toTileCoords(self.position)
  local targetTile = self.target

  -- If we have a path, follow it
  if self.path ~= nil then
    local node = self.path.nodes[1]
    
    if node ~= nil then
      if selfTile.x == node.location.x and selfTile.y == node.location.y then -- are we in the first node? REMOVE IT!
        table.remove(self.path.nodes, 1)
        node = self.path.nodes[1]
      end
    else -- we need a new path
      self.pathDuration = 3.1
    end
  
    if node ~= nil then
      local movement = vector(0, 0)
      
      -- Adjust position
      local nodeWorld = self.level:toWorldCoordsCenter(node.location)
      
      -- horizontal
      if math.abs(self.position.x - nodeWorld.x) > 1 then
        if self.position.x < nodeWorld.x then
          movement = movement + vector(1, 0)
        elseif self.position.x > nodeWorld.x then
          movement = movement + vector(-1, 0)
        end
      end
      
      -- vertical
      if math.abs(self.position.y - nodeWorld.y) > 1 then
        if self.position.y < nodeWorld.y then
          movement = movement + vector(0, 1)
        elseif self.position.y > nodeWorld.y then
          movement = movement + vector(0, -1)
        end
      end
    
      return movement
    else
       -- We're at the end of the path, stand still for now
      self.pathDuration = 3
      return vector(0, 0)
    end
    
  else -- No path
    return vector(0, 0) -- Just stand there
  end
  
end

function Player:draw()
  love.graphics.setColor(self.color.r,
                         self.color.g,
                         self.color.b,
                         self.color.a)
                         
  love.graphics.circle('fill',
                       self.position.x,
                       self.position.y,
                       self.size / 2,
                       32)
                       
  love.graphics.setColor(colors.green.r,
                        colors.green.g,
                        colors.green.b,
                        colors.green.a)

  local targetpos = self.level:toWorldCoordsCenter(self.target)

  love.graphics.circle('fill',
                       targetpos.x,
                       targetpos.y,
                       8,
                       16)

end
