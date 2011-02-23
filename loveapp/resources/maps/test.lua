-- 
--  test.lua
--  wor
--  
--  Created by Jay Roberts on 2011-02-22.
--  Copyright 2011 GloryFish.org. All rights reserved.
-- 


require 'vector'

local map = {}

map.tileset = love.graphics.newImage('resources/images/level.png')
map.tileset:setFilter('nearest', 'nearest')

map.tileWidth, map.tileHeight = 16, 16

map.quadInfo = { 
  { ' ', 0 * tileWidth, 0 * tileHeight}, -- 1 = air 
  { '#', 1 * tileWidth, 0 * tileHeight}, -- 2 = brick floor
}

map.solid = {
  '#',
}


map.quads = {}

for _,info in ipairs(map.quadInfo) do
  -- info[1] = character, info[2]= x, info[3] = y
  map.quads[info[1]] = love.graphics.newQuad(info[2], info[3], map.tileWidth, map.tileHeight, map.tileset:getWidth(), map.tileset:getHeight())
end


map.tileString = [[
#############################################
#                                           #
# ######## ################ ##############  #
#                                           #
# ######## ###### ######### ##############  #
#                                        #  #
# ######## ###### ########################  #
#                                           #
# ######## ###### ######### ##############  #
#               #                           #
# ######## ###### ######### ##############  #
#                                           #
# ######## ###### ######### ##############  #
#                                           #
# ############### ########################  #
#                                           #
#                                           #
##############################################
]]

map.gravity = vector(0, 600)

return map