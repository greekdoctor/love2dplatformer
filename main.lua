require "camera"
require "player"

function love.load()

	-- Window variables and stuff

	windowX = 900
	windowY = 622
	love.window.setMode(windowX, windowY, {fsaa = 4}) --set the window dimensions and antialiasing

	-- World variables
	worldX = 1200
	worldY = 700
	groundSizeX = 1200
	groundSizeY = 60
	meter = 64
	gravity = 1000

	-- love.physics.setMeter(meter)
	-- world = love.physics.newWorld(0, 9.81*meter, true)
	-- world:setCallbacks(beginContact, endContact, preSolve, postSolve)

	background = love.graphics.newImage("background.jpg")

	-- objects = {}
	--   --let's create the ground
	-- objects.ground = {}
	-- objects.ground.body = love.physics.newBody(world, groundSizeX/2, windowY-groundSizeY/2) --remember, the shape (the rectangle we create next) anchors to the body from its center, so we have to move it to (650/2, 650-50/2)
	-- objects.ground.shape = love.physics.newRectangleShape(groundSizeX, groundSizeY)
	-- objects.ground.fixture = love.physics.newFixture(objects.ground.body, objects.ground.shape) --attach shape to body
	-- objects.ground.fixture:setUserData("ground")

	p = player:new(10, 100)

	-- --let's create a couple blocks to play around with
	-- objects.block1 = {}
	-- objects.block1.body = love.physics.newBody(world, 200, 550, "dynamic")
	-- objects.block1.shape = love.physics.newRectangleShape(0, 0, 50, 100)
	-- objects.block1.fixture = love.physics.newFixture(objects.block1.body, objects.block1.shape, 5) -- A higher density gives it more mass.

	-- objects.block2 = {}
	-- objects.block2.body = love.physics.newBody(world, 200, 400, "dynamic")
	-- objects.block2.shape = love.physics.newRectangleShape(0, 0, 100, 50)
	-- objects.block2.fixture = love.physics.newFixture(objects.block2.body, objects.block2.shape, 5)

	-- objects.walls = {}
	-- objects.walls.body = love.physics.newBody(world, 0, 0, "static")
	-- objects.walls.shape = love.physics.newRectangleShape(0, 0, 10, 1000)
end

function love.update(dt)
--	world:update(dt)

	if love.keyboard.isDown("up") then
		p:jump()
	end

	p:update(dt, gravity)

end

function love.draw()
  camera:set()
  love.graphics.draw(background)
 --  love.graphics.setColor(72, 160, 14) -- set the drawing color to green for the ground
 --  love.graphics.polygon("fill", objects.ground.body:getWorldPoints(objects.ground.shape:getPoints())) -- draw a "filled in" polygon using the ground's coordinates
 --  love.graphics.setColor(193, 47, 14) -- set the drawing color to red for the ball
 -- -- love.graphics.circle("fill", objects.ball.body:getX(), objects.ball.body:getY(), objects.ball.shape:getRadius())

 --  love.graphics.setColor(50, 50, 50) -- set the drawing color to grey for the blocks
 --  love.graphics.polygon("fill", objects.block1.body:getWorldPoints(objects.block1.shape:getPoints()))
 --  love.graphics.polygon("fill", objects.block2.body:getWorldPoints(objects.block2.shape:getPoints()))
  love.graphics.setColor(255,255,255)
  camera:setPosition(p.x, p.y)
--  camera:move(p.x, p.y)
  love.graphics.draw(p.sprite, p.x, p.y, 0)
  camera:unset()
  print("p.ySpeed is ", math.floor(p.ySpeed))
  print("yActualSpeed is ", math.floor(yActualSpeed))
  print("The state is ", p.state)
  print("The x pos is ", math.floor(p.x))
  print("The y pos is ", math.floor(p.y))
end


function love.keypressed(key, isrepeat)
	if key == "escape" then
		love.event.quit()
	elseif key == "r" then
		p.x = windowX/2
		p.y = windowY/2
	elseif key == "left" then
		p:moveLeft()
	elseif key == "right" then
		p:moveRight()
	end
end

function love.keyreleased(key)
	if key == "left" or key == "right" then
		p.xSpeed = 0
		p.state = "onground"
	end
end
