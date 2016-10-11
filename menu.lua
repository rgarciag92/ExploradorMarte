--------- Inicializacion de las variables del menu --------- 
button = {}

--------- Funcion para la creacion de botones y la insercion a la tabla --------- 
function button.spawn(x, y, text, id)
	table.insert(button, {x = x, y = y, text = text, id = id})
end

--------- Funcion para el dibujo de los botones del menu 
function button.draw()
	for i,v in ipairs(button) do
		love.graphics.setColor(255,255,255)
		font = love.graphics.newFont("Letra/Righteous-Regular.ttf", 40)
		love.graphics.setFont(font)
		love.graphics.rectangle("line", v.x - 10, v.y - 10, font:getWidth(v.text) + 20, font:getHeight() + 20)
		love.graphics.print(v.text, v.x, v.y)
	end
end

--------- Funcion para el comportamiento del click del mouse sobre los botones --------- 
function button.click(x, y)
	for i, v in ipairs(button) do
		if x > v.x and
		x < v.x + medium:getWidth(v.text) and
		y > v.y and
		y < v.y + medium:getHeight() then
			if v.id == "Solos" then	
				for i=1, opcion.obstaculos, 1 do
					obstaculo.spawn(math.random(790), math.random(590))
				end
				
				for i=1, opcion.piedras, 1 do
					objetivo.spawn(math.random(790), math.random(590))
				end
				for i=1, opcion.agentes, 1 do
					player.spawn(naveX, naveY)
				end
				gamestate = "Solos"
			end
			if v.id == "Colaborativo" then	
				for i=1, opcion.obstaculos, 1 do
					obstaculo.spawn(math.random(790), math.random(590))
				end
				
				for i=1, opcion.piedras, 1 do
					objetivo.spawn(math.random(790), math.random(590))
				end
				for i=1, opcion.agentes, 1 do
					playerC.spawn(naveX, naveY)
				end
				gamestate = "Colaborativo"
			end
		end
	end
end

--------- Funcion para llamar en main de los botones para dibujar ---------
function DRAW_BUTTONS()
	button.draw()
end