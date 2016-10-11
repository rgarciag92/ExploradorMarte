--------- Inicializacion de tabla y variables de moronas ---------
morona = {}
morona.radio = 4

--------- Creacion de moronas con x, y, radio ---------
function morona.spawn(x, y)
	table.insert(morona, {x = x , y = y, radio = morona.radio})
end

--------- Dibujo de moronas ---------
function morona.draw()
	for i, v in ipairs(morona) do
		love.graphics.setColor(120, 120, 120)
		love.graphics.circle("fill", v.x, v.y, v.radio)
	end
end

--------- Funcion para llamar en main de las moronas para dibujar ---------
function DRAW_MORONA()
	morona.draw()
end