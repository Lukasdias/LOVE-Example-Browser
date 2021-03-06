-- Exemplo: Movendo um objeto ate um determinado ponto
--[[Description:
Movendo um objeto ate um determinado ponto, com aceleracao, desaceleracao (tracao).
]]
require ("movements")
x, y = 400, 300
function love.load()	
	SPEED = 500
	ACCELERATION = 250
	DECELERATION = 0
	image = love.graphics.newImage("assets/love-ball.png")
	move=mega.movements.newMove(ACCELERATION,DECELERATION,SPEED,x,y)
end

function love.draw()
	love.graphics.draw(image, x, y)
	
	love.graphics.print("Left click to change the target.", 50, 50)
	love.graphics.print("Right click to stop the image from moving.", 50, 65)
	love.graphics.print("Middle click to make the image magically jump to your cursor.", 50, 80)
	
	if move:isFinished() == true then love.graphics.print("Have some LÖVE, will ya?", 50, 110) end
end

function love.update(dt)
	
	if love.mouse.isDown(1) then
		move:setTarget(love.mouse.getPosition())
	elseif love.mouse.isDown(3) then
		move:setTarget(love.mouse.getPosition())
		move:snapToTarget()
	elseif love.mouse.isDown(2) then
		move:setTarget(nil)
	end
	
	move:advance(dt)
	x,y=move:getPosition()
end
