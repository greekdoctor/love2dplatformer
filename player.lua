player = {}

function player:new(startposx, startposy)
	local object = {
	sprite = love.graphics.newImage("mario.png"),
	x = startposx,
	y = startposy,
	xSpeed = 0,
	ySpeed = 0,
	runSpeed = 200,
	jumpSpeed = 500,
	state = "none",
--	height = sprite:getHeight(),
	height = 64,

	-- Debug variables
	yActualSpeed = 0,
	previousX = 0,
	previousY = 0
	}
	setmetatable(object, { __index = player })
	return object
end

function player:moveLeft()
	self.xSpeed = -1 * (self.runSpeed)
	self.state = "movingLeft"
end

function player:moveRight()
	self.xSpeed = self.runSpeed
	self.state = "movingRight"
end

function player:jump()
	if self.state == "onground" then
		self.ySpeed = -1 * self.jumpSpeed
		self.state = "jumping"
	end
end

function player:stop()
	self.xSpeed = 0
end

function player:hitFloor(x)
end

function player:update(dt, gravity)
	self.x = self.x + (self.xSpeed * dt)
	self.y = self.y + (self.ySpeed * dt)
	self.ySpeed = self.ySpeed + (gravity * dt)
	yActualSpeed = (math.abs(math.floor(self.y) - math.floor(self.previousY))/dt)
	if yActualSpeed == 0 then
		self.state = "onground"
	end
	self.previousX = self.x
	self.previousY = self.y 

	    -- stop the player when they hit the borders
    if self.x > worldX then self.x = worldX end
    if self.x < 0 then self.x = 0 end
    if self.y < 0 then self.y = 0 end
    if self.y > windowY - (groundSizeY + self.height) then
        self.y = windowY - (groundSizeY + self.height)
    end
end