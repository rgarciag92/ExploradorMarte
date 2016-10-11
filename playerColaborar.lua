--------- Inicializaicon de tabla y variables de playerC :
---------				Capacidad: capacidad random de vehiculo a llevar piedras entre (1, 2)
---------				Contador: contador para disminuir cantidad de moronas colcoadas
playerC = {}
playerC.capacidad = math.random(2,4)
playerC.radio = 10
contador = 0

--------- Funcion para crear jugadores e insertar en tabla con variables:
---------					xvel: velocidad en x del jugador ; yvel: velocidad en y del jugador
---------					order: orden de la capa 
---------					Variables de movimiento: speed, friction
function playerC.spawn(x, y)
	table.insert(playerC, {x = x, y = y, xvel = 0, yvel = 0, speed = 1000, friction = 7.50, order = 0, capacidad = playerC.capacidad, radio = playerC.radio})
end

--------- Funcion para dibujar al jugador 
function playerC.draw()
	for i,v in ipairs(playerC) do
		love.graphics.setColor(0,0,0)
		love.graphics.circle('fill', v.x, v.y, v.radio)
	end
end

--------- Funcion para controlar el movimiento del jugador ---------
function playerC.physics(dt)
	for i, v in ipairs(playerC) do
		v.x = v.x + v.xvel * dt
		v.y = v.y + v.yvel * dt
		v.xvel = v.xvel * (1 - math.min(dt * v.friction, 1))
		v.yvel = v.yvel * (1 - math.min(dt * v.friction, 1))
	end
end

--------- Funcion que controla el orden de las capas ---------
function playerC.AI(dt)
	for i,v in ipairs(playerC) do
		if v.order == 0 then
			playerC.colisionO(dt, v.order)
		end
		if v.order == 1 then
			playerC.naveO(dt, v.order)
		end
		if v.order == 2 then
			playerC.naveS(dt, v.order)
		end
		if v.order == 3 then
			playerC.colisionP(dt, v.order)
		end
		if v.order == 4 then
			playerC.colisionM(dt, v.order)
		end
		if v.order == 5 then
			playerC.moverse(dt, v.order)
		end
	end 
end

--------- Funcion para el control de colision de obstaculos
function playerC.colisionO(dt, order)
	for i, v in ipairs(playerC) do 
		if table.getn(obstaculo) ~= 0 then 
			for ia,va in ipairs(obstaculo) do
				local moveY = {v.yvel - v.speed * dt, v.yvel + v.speed * dt}
				local moveX = {v.xvel - v.speed * dt, v.xvel + v.speed * dt}
				if math.sqrt(((v.x - va.x)*(v.x - va.x)) + ((v.y - va.y)*(v.y - va.y))) < (v.radio + va.radio) then
					v.x = v.x + 5
					v.y = v.y + 5
					v.order = 0
				else 
					if order == 5 then
						v.order = 0
					else
						v.order = order + 1
					end
				end
			end
		else 
			if order == 5 then
				v.order = 0
			else
				v.order = order + 1
			end
		end
	end
end

--------- Funcion para el control del jugador en la nave  ---------
function playerC.naveO(dt, order)
	for i, v in ipairs(playerC) do
		if table.getn(nave) ~= 0 then 
			for ia, va in ipairs(nave) do
				if math.abs(v.x - va.x) < 5 and math.abs(v.y - va.y) < 5 and v.capacidad == 0 then
					v.xvel = 0
					v.yvel = 0
					v.capacidad = playerC.capacidad
					v.order = 0
				else
					if order == 5 then
						v.order = 0
					else
						v.order = order + 1
					end
				end
			end
		else
			if order == 5 then
				v.order = 0
			else
				v.order = order + 1
			end
		end
	end
end

--------- Funcion del control del regreso del jugador a la nave ---------
function playerC.naveS(dt, order)
	for i, v in ipairs(playerC) do
		if table.getn(nave) ~= 0 then 
			for ia, va in ipairs(nave) do
				if (math.abs(v.x - va.x) < 250 or math.abs(v.y - va.y) < 250) and v.capacidad ~= playerC.capacidad then 	
					contador = contador + 1
					if v.x > va.x and v.y > va.y then
						if (contador % 5) == 0 and (contador % 10) == 0  then
							morona.spawn(v.x, v.y)
						end
						v.xvel = v.xvel - v.speed * dt
						v.yvel = v.yvel - v.speed * dt
						v.order = 0
					elseif v.x > va.x and v.y < va.y then
						if (contador % 5) == 0 and (contador % 10) == 0  then
							morona.spawn(v.x, v.y)
						end
						v.xvel = v.xvel - v.speed * dt
						v.yvel = v.yvel + v.speed * dt
						v.order = 0
					elseif v.x < va.x and v.y > va.y then
						if (contador % 5) == 0 and (contador % 10) == 0  then
							morona.spawn(v.x, v.y)
						end
						v.xvel = v.xvel + v.speed * dt
						v.yvel = v.yvel - v.speed * dt
						v.order = 0
					elseif v.x < va.x and v.y < va.y then
						if (contador % 5) == 0 and (contador % 10) == 0 then
							morona.spawn(v.x, v.y)
						end
						v.xvel = v.xvel + v.speed * dt
						v.yvel = v.yvel + v.speed * dt
						v.order = 0
					end
				elseif (math.abs(v.x - va.x) > 250 or math.abs(v.y - va.y) > 250) and v.capacidad ~= playerC.capacidad then 	
					contador = contador + 1
					if (contador % 5) == 0 and (contador % 10) == 0 then
						morona.spawn(v.x, v.y)
					end					
					local moveX = {v.xvel - v.speed * dt, v.xvel + v.speed * dt}
					local moveY = {v.yvel - v.speed * dt, v.yvel + v.speed * dt}
					v.xvel = moveX[math.random(1,2)]
					v.yvel = moveY[math.random(1,2)]
					v.order = 0
				else 
					if order == 5 then
						v.order = 0
					else
						v.order = order + 1
					end
				end
			end
		else
			if order == 5 then
				v.order = 0
			else
				v.order = order + 1
			end
		end
	end
end

--------- Funcion para el control de la colision con piedras ---------
function playerC.colisionP(dt, order)
	for i, v in ipairs(playerC) do 
		if table.getn(objetivo) ~= 0 then 
			for ia,va in ipairs(objetivo) do
				if math.sqrt(((v.x - va.x)*(v.x - va.x)) + ((v.y - va.y)*(v.y - va.y))) < (v.radio + va.radio) and v.capacidad ~= 0 then
					v.xvel = 0	
					v.yvel = 0
					local capacidad = v.capacidad
					while capacidad ~= 0 do
						va.peso = va.peso - 1
						if va.peso == 0 then
							table.remove(objetivo, ia)
						end
						v.capacidad = v.capacidad - 1
						capacidad = capacidad - 1
					end
					v.order = 0
				else
					if order == 5 then
						v.order = 0
					else
						v.order = order + 1
					end
				end
			end
		else 
			if order == 5 then
				v.order = 0
			else
				v.order = order + 1
			end
		end
	end
end

--------- Funcion para la colision del jugador con las moronas ---------
function playerC.colisionM(dt, order)
	for i,v in ipairs(playerC) do
		if table.getn(morona) ~= 0 then 
			for ia,va in ipairs(morona) do 
				if math.sqrt(((v.x - va.x)*(v.x - va.x)) + ((v.y - va.y)*(v.y - va.y))) < (v.radio + va.radio) and v.capacidad ~= 0 then
					v.x = va.x
					v.y = va.y
					table.remove(morona, ia)
					v.order = 0
				else 
					if order == 5 then
						v.order = 0
					else
						v.order = order + 1
					end
				end
			end
		else 
			if order == 5 then
				v.order = 0
			else
				v.order = order + 1
			end
		end
	end
end

--------- Funcion del movimiento del jugador ---------
function playerC.moverse(dt, order)
	for i, v in ipairs(playerC) do 
		local moveX = {v.xvel - v.speed * dt, v.xvel + v.speed * dt}
		local moveY = {v.yvel - v.speed * dt, v.yvel + v.speed * dt}
		v.xvel = moveX[math.random(1,2)]
		v.yvel = moveY[math.random(1,2)]
		v.order = 0
	end
end

--------- Funcion que controla el limite del movimiento de jugador en la pantalla ---------
function playerC.boundary(dt)
	for i,v in ipairs(playerC) do
		if v.x < 0 then
			v.x = 0
			v.xvel = 0
		end
		if v.y < 0 then
			v.y = 0
			v.yvel = 0
		end
		if v.x + v.radio > screenWidth then
			v.x = screenWidth - v.radio
			v.xvel = 0
		end
		if v.y + v.radio > screenHeight then
			v.y = screenHeight - v.radio
			v.yvel =0
		end
	end
end

--------- Funcion para llamar en main de los jugadores para dibujar ---------
function DRAW_PLAYERCOLABORAR()
	playerC.draw()
end

--------- Funcion para llamar en main de las jugadores para actualizar ---------
function UPDATE_PLAYERCOLABORAR(dt)
	playerC.physics(dt)
	playerC.boundary(dt)
	playerC.AI(dt)
end