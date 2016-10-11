
--------- Clases lua requeridas ---------
require "objetivo"
require "obstaculo"

--------- Inicializaicon de tabla y variables de opcion :
---------				piedras: cantidad de piedras a agregar al ambiente
---------				obstaculos: cantidad de obstaculos a agregar al ambiente
opcion = {}
opcion.piedras = 1
opcion.obstaculos = 1
opcion.agentes = 1

--------- Insercion de botones de "+", "-" para piedras, obstaculos y boton de "aceptar" ---------
table.insert(opcion, {x = 350, y = 100, text = "+", id = "masAgentes"})
table.insert(opcion, {x = 500, y = 100, text = "-  ", id = "menosAgentes"})
table.insert(opcion, {x = 350, y = 200, text = "+", id = "masPiedras"})	
table.insert(opcion, {x = 500, y = 200, text = "-  ", id = "menosPiedras"})
table.insert(opcion, {x = 350, y = 300, text = "+", id = "masObstaculos"})
table.insert(opcion, {x = 500, y = 300, text = "-  ", id = "menosObstaculos"})
table.insert(opcion, {x = 250, y = 450, text = "Aceptar", id = "Aceptar"})

--------- Funcion para el dibujo de las opciones en la pantalla --------- 
function opcion.draw()
	love.graphics.rectangle("line", 405 - 10, 100 - 10, 80, 72)
	love.graphics.rectangle("line", 405 - 10, 200 - 10, 80, 72)
	love.graphics.rectangle("line", 405 - 10, 300 - 10, 80, 72)
	love.graphics.print(opcion.agentes, 405, 100)
	love.graphics.print(opcion.piedras, 405, 200)
	love.graphics.print(opcion.obstaculos, 405, 300)

	love.graphics.print("Agentes:", 100, 100)
	love.graphics.print("Piedras:", 100, 200)
	love.graphics.print("Obstáculos:", 100, 300)
	
	for i,v in ipairs(opcion) do
		love.graphics.rectangle("line", v.x - 10, v.y - 10, medium:getWidth(v.text) + 4, medium:getHeight() + 20)
		love.graphics.setColor(255,255,255)
		font = love.graphics.newFont("Letra/Righteous-Regular.ttf", 40)
		love.graphics.setFont(font)
		love.graphics.print(v.text, v.x, v.y)
	end
end

--------- Funcion para el comportamiento del click del mouse sobre las opciones --------- 
function opcion.click(x, y)
	for i, v in ipairs(opcion) do
		if x > v.x and
		x < v.x + medium:getWidth(v.text) and
		y > v.y and
		y < v.y + medium:getHeight() then
			if v.id == "masPiedras" then	
				opcion.piedras = opcion.piedras + 1
			end
			if v.id == "masObstaculos" then	
				opcion.obstaculos = opcion.obstaculos + 1
			end
			if v.id == "masAgentes" then
				opcion.agentes = opcion.agentes + 1
			end
			if v.id == "menosPiedras" then	
				if opcion.piedras ~= 1 then 
					opcion.piedras = opcion.piedras - 1
				end
			end
			if v.id == "menosObstaculos" then	
				if opcion.obstaculos ~= 1 then
					opcion.obstaculos = opcion.obstaculos - 1
				end
			end
			if v.id == "menosAgentes" then	
				if opcion.agentes ~= 1 then
					opcion.agentes = opcion.agentes - 1
				end
			end
			if v.id == "Aceptar" then
				gamestate = "menu"
			end
		end
	end
end

--------- Funcion para llamar en main de las opciones para dibujar ---------
function DRAW_OPCION()
	opcion.draw()
end