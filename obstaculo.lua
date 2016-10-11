--------- Inicializacion de tabla y variables de los obstaculos ---------
obstaculo = {}
obstaculo.radio = 10

--------- Creacion de obstaculos con x, y, radio ---------
function obstaculo.spawn(x, y)
	table.insert(obstaculo, {x = x , y = y, radio = obstaculo.radio})
end

--------- Dibujo de obstaculos ---------
function obstaculo.draw()
	for i,v in ipairs(obstaculo) do
		love.graphics.setColor(250, 0, 0)
		love.graphics.circle("fill", v.x, v.y, v.radio)
	end
end

--------- Funcion para llamar en main de los obstaculos para dibujar ---------
function DRAW_OBSTACULO()
	obstaculo.draw()
end
