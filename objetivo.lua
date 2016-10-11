--------- Inicializacion de tabla y variables de objetivo 
---------				Peso: Cantidad de piedras en la ubicacion x,y
objetivo = {}
objetivo.radio = 10

--------- Creacion de objetivos con x, y, radio ---------
function objetivo.spawn(x, y)
	objetivo.peso = math.random(3, 5)
	table.insert(objetivo, {x = x, y = y, peso = objetivo.peso, radio = objetivo.radio })
end

--------- Dibujo de objetivos ---------
function objetivo.draw()
	for i,v in ipairs(objetivo) do
		love.graphics.setColor(34, 177, 76)
		love.graphics.circle("fill", v.x, v.y, v.radio)
	end
end

--------- Funcion para llamar en main de los objetivos para dibujar ---------
function DRAW_OBJETIVO()
	objetivo.draw()
end