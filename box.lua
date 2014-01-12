box = {}

function box:new(x, y)
	local object = {
	sprite = love.graphics.newImage("block.png"),
	x = x,
	y = y
	}
	setmetatable(object, { __index = player })
	return object
end