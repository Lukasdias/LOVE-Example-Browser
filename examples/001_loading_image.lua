-- Exemplo: Carregando uma imagem e printando ela
--[[Descrição:
Carregando uma imagem usando love.graphics.newImage(image_path)
Desenhando ela usando love.graphics.draw
]]

function love.load()
    image = love.graphics.newImage("assets/love-ball.png")
end

function love.draw()
    love.graphics.draw(image, 400, 300)
end

