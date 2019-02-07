-- Example: Mini Physics Callbacks

text = "Sem colissoes ocorrendo."

function love.load()

    love.graphics.setFont(love.graphics.newFont(11))

    -- One meter is 32px in physics engine
	love.physics.setMeter( 32 )

	-- Cria a world with standard gravity
	world = love.physics.newWorld(0, 9.81*32, true)

	-- Cria the ground body at (0, 0) static
	ground = love.physics.newBody(world, 0, 0, "static")

	-- Cria the ground shape at (400,500) with size (600,10).
	ground_shape = love.physics.newRectangleShape(400, 500, 600, 10)
	
 	-- Cria fixture between body and shape
	ground_fixture = love.physics.newFixture( ground, ground_shape)
	ground_fixture:setUserData("Ground") -- Set a string userdata

	-- Load the image of the ball.
	ball = love.graphics.newImage("assets/love-ball.png")

	-- Cria a Body for the circle.
	body = love.physics.newBody(world, 400, 200, "dynamic")
	
	-- Attatch a shape to the body.
	circle_shape = love.physics.newCircleShape(0,0, 32)

    -- Cria fixture between body and shape
    fixture = love.physics.newFixture( body, circle_shape)

	fixture:setUserData("Ball") -- Set a string userdata
	
    -- Calculate the mass of the body based on attatched shapes.
	-- This gives realistic simulations.
	body:setMassData(circle_shape:computeMass( 1 ))	

	-- Set the collision callback.
	world:setCallbacks(beginContact,endContact)

end

function love.update(dt)
	-- Update the world.
	world:update(dt)
end

function love.draw()
	-- Draws the ground.
	love.graphics.polygon("line", ground_shape:getPoints())

	-- Draw the circle.
	love.graphics.draw(ball,body:getX(), body:getY(), body:getAngle(),1,1,32,32)

	-- Instructions
	love.graphics.print("spacebar: Aplica um impulso aleatorio",5,5)

	-- Draw text.
	love.graphics.print(text, 5, 25)
end

function love.keypressed(k)
	if k == "space" then
		-- Apply a random impulse
		body:applyLinearImpulse(150-math.random(0, 300),-math.random(0, 1500))
	end
end

-- This is called every time a collision begin.
function beginContact(a, b, c)
	local aa=a:getUserData()
	local bb=b:getUserData()
	text = "Colidiu: " .. aa .. " com " .. bb
end

-- This is called every time a collision end.
function endContact(a, b, c)
	local aa=a:getUserData()
	local bb=b:getUserData()
	text = "A colisao acabou entre: " .. aa .. " e " .. bb
end
