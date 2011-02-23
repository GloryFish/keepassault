-- 
--  dungeon.lua
--  wor
--  
--  Created by Jay Roberts on 2011-02-22.
--  Copyright 2011 GloryFish.org. All rights reserved.
-- 

require 'middleclass'

Dungeon = class('Dungeon')

function Dungeon:initialize(mapname)
  self.map = love.filesystem.load(string.format('resources/maps/%s.lua', mapname))()

  assert(self.map != nil, string.format('Map was nil: %s', mapname)



  
end

function Dungeon:update(dt)
end

function Dungeon:draw()
end