-- 
--  testmap.lua
--  redditgamejam-05
--  
--  A map with some testing tiles
--
--  Maps should return a tileset image file
--  a quads array containing quads mapped to characters
--  and a tileString defining the level
--
--  Created by Jay Roberts on 2011-01-02.
--  Copyright 2011 GloryFish.org. All rights reserved.
-- 

require 'vector'

local tileset = love.graphics.newImage('resources/images/level.png')
tileset:setFilter('nearest', 'nearest')

local tileWidth, tileHeight = 16, 16

local quadInfo = { 
  { ' ', 0 * tileWidth, 0 * tileHeight}, -- 1 = air 
  { '#', 1 * tileWidth, 0 * tileHeight}, -- 2 = brick floor
}

local solid = {
  '#'
}


local quads = {}

for _,info in ipairs(quadInfo) do
  -- info[1] = character, info[2]= x, info[3] = y
  quads[info[1]] = love.graphics.newQuad(info[2], info[3], tileWidth, tileHeight, tileset:getWidth(), tileset:getHeight())
end


local tileString = [[
################################
#                              #
# ###### ############# ####### #
#                              #
# ###### ###### ###### ####### #
#                            # #
# ###### ###### ############## #
#                              #
# ###### ###### ###### ####### #
#             #                #
# ###### ###### ###### ####### #
#                              #
# ###### ###### ###### ####### #
#                              #
# ###### ###### ###### ####### #
#             #                #
# ###### ###### ###### ####### #
#                              #
# ###### ###### ###### ####### #
#                              #
################################
]]

local gravity = vector(0, 600)

return tileset, quads, tileString, tileWidth, gravity, solid