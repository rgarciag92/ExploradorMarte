--------- Clases lua requeridas ---------
require "player"
require "obstaculo"
require "objetivo"
require "nave"
require "menu"
require "playerColaborar"
require "moronasColaborar"
require "opcion"

backgroundOne = love.graphics.newImage("Imagen/espacio2.png")
backgroundTwo = love.graphics.newImage("Imagen/marte3.jpg")
--------- Funcion Löve que carga al inicio del programa
function love.load()
	--------- Variables de ambiente ---------
	medium = love.graphics.newFont(45)
	screenWidth = love.graphics.getWidth()
	screenHeight = love.graphics.getHeight()
	
	--------- Estado de juego ---------
	gamestate = "opcion"
	
	--------- Botones ---------
	button.spawn(350, 200, "Solos", "Solos")
	button.spawn(280, 300, "Colaborativo", "Colaborativo")
	
	--------- Ubicacion de la nave ---------
	naveX = math.random(790)
	naveY = math.random(590)
	nave.spawn(naveX, naveY)	
end

--------- Funcion Löve que actualiza la pantalla en tiempo "dt" ---------
function love.update(dt)
	--------- Seleccion de comportamientos ---------
	if gamestate == "Solos" then
		UPDATE_PLAYER(dt)
	elseif gamestate == "Colaborativo" then
		UPDATE_PLAYERCOLABORAR(dt)
	end
end

--------- Funcion Löve que dibuja en la pantalla ---------
function love.draw()
	--------- Seleccion de dibujo de pantalla ---------
	if gamestate == "opcion" then
		love.graphics.draw(backgroundOne, 0, 0)
		DRAW_OPCION()
	end
	if gamestate == "menu" then
		love.graphics.draw(backgroundOne, 0, 0)
		DRAW_BUTTONS()
	end
	if gamestate == "Solos" then
		love.graphics.draw(backgroundTwo, 0, 0)
		DRAW_PLAYER()
		DRAW_OBSTACULO()
		DRAW_OBJETIVO()
		DRAW_NAVE()
		love.graphics.setColor(255, 255, 255)
	end
	if gamestate == "Colaborativo" then
		love.graphics.draw(backgroundTwo, 0, 0)
		DRAW_MORONA()
		DRAW_NAVE()
		DRAW_PLAYERCOLABORAR()
		DRAW_OBSTACULO()
		DRAW_OBJETIVO()
		love.graphics.setColor(255, 255, 255)
	end
end

--------- Funcion Löve para deteccion de eventos del mouse ---------
function love.mousepressed(x,y)
	--------- Deteccion de eventos con el mouse en la ventana ---------
	if gamestate == "menu" then
		button.click(x,y)
	end
	if gamestate == "opcion" then
		opcion.click(x,y)
	end
end

function love.keypressed(key)
	if key == "escape" then
		love.event.quit(0)
	end
end
