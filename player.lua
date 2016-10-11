player = {}	
player.capacidad = math.random(2,4)
player.radio = 10

function player.spawn(x, y)
	table.insert(player, {x = x, y = y, radio = player.radio, xvel = 0, yvel = 0, speed = 1750, friction = 7.50, order = 0, capacidad = player.capacidad})
end

function player.draw()
	for i,v in ipairs(player) do
		love.graphics.setColor(0,0,0)
		love.graphics.circle('fill', v.x, v.y, v.radio)
	end
end

function player.physics(dt)
	for i, v in ipairs(player) do
		v.x = v.x + v.xvel * dt
		v.y = v.y + v.yvel * dt
		v.xvel = v.xvel * (1 - math.min(dt * v.friction, 1))
		v.yvel = v.yvel * (1 - math.min(dt * v.friction, 1))
	end
end

function player.AI(dt)
	for i,v in ipairs(player) do
		if v.order == 0 then
			player.colisionO(dt, v.order)
		end
		if v.order == 1 then
			player.naveO(dt, v.order)
		end
		if v.order == 2 then
			player.naveS(dt, v.order)
		end
		if v.order == 3 then
			player.colisionP(dt, v.order)
		end
		if v.order == 4 then
			player.moverse(dt, v.order)
		end
	end 
end

function player.colisionO(dt, order)
	for i, v in ipairs(player) do
		if table.getn(obstaculo) ~= 0 then 
			for ia,va in ipairs(obstaculo) do
				local moveY = {v.yvel - v.speed * dt, v.yvel + v.speed * dt}
				local moveX = {v.xvel - v.speed * dt, v.xvel + v.speed * dt}
				if math.sqrt(((v.x - va.x)*(v.x - va.x)) + ((v.y - va.y)*(v.y - va.y))) < 15 then
					v.x = v.x + 5
					v.y = v.y + 5
					v.order = 0
				else 
					if order == 4 then
						v.order = 0
					else
						v.order = order + 1
					end
				end
			end
		else 
			if order == 4 then
				v.order = 0
			else
				v.order = order + 1
			end
		end
	end
end

function player.naveO(dt, order)
	for i, v in ipairs(player) do
		if table.getn(nave) ~= 0 then 
			for ia, va in ipairs(nave) do
				if math.abs(v.x - va.x) < 5 and math.abs(v.y - va.y) < 5 and v.capacidad == 0 then
					v.xvel = 0
					v.yvel = 0
					v.capacidad = player.capacidad
					v.order = 0
				else
					if order == 4 then
						v.order = 0
					else
						v.order = order + 1
					end
				end
			end
		else
			if order == 4 then
				v.order = 0
			else
				v.order = order + 1
			end
		end
	end
end

function player.naveS(dt, order)
	for i, v in ipairs(player) do
		if table.getn(nave) ~= 0 then 
			for ia, va in ipairs(nave) do
				if (math.abs(v.x - va.x) < 250 or math.abs(v.y - va.y) < 250) and v.capacidad ~= player.capacidad then 	
					if v.x > va.x and v.y > va.y  then
						v.xvel = v.xvel - v.speed * dt
						v.yvel = v.yvel - v.speed * dt
						v.order = 0
					elseif v.x > va.x and v.y < va.y then
						v.xvel = v.xvel - v.speed * dt
						v.yvel = v.yvel + v.speed * dt
						v.order = 0
					elseif v.x < va.x and v.y > va.y then
						v.xvel = v.xvel + v.speed * dt
						v.yvel = v.yvel - v.speed * dt
						v.order = 0
					elseif v.x < va.x and v.y < va.y then
						v.xvel = v.xvel + v.speed * dt
						v.yvel = v.yvel + v.speed * dt
						v.order = 0
					end
				elseif (math.abs(v.x - va.x) > 250 or math.abs(v.y - va.y) > 250) and v.capacidad ~= player.capacidad then 
					local moveX = {v.xvel - v.speed * dt, v.xvel + v.speed * dt}
					local moveY = {v.yvel - v.speed * dt, v.yvel + v.speed * dt}
					v.xvel = moveX[math.random(1,2)]
					v.yvel = moveY[math.random(1,2)]
					v.order = 0
				else 
					if order == 4 then
						v.order = 0
					else
						v.order = order + 1
					end
				end
			end
		else
			if order == 4 then
				v.order = 0
			else
				v.order = order + 1
			end
		end
	end
end

function player.colisionP(dt, order)
	for i, v in ipairs(player) do
		if table.getn(objetivo) ~= 0 then 
			for ia,va in ipairs(objetivo) do
				if math.sqrt(((v.x - va.x)*(v.x - va.x)) + ((v.y - va.y)*(v.y - va.y))) < 15 and v.capacidad ~= 0 then
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
					if order == 4 then
						v.order = 0
					else
						v.order = order + 1
					end
				end
			end
		else
			if order == 4 then
				v.order = 0
			else
				v.order = order + 1
			end
		end
	end
end

function player.moverse(dt, order)
	for i, v in ipairs(player) do 
		local moveX = {v.xvel - v.speed * dt, v.xvel + v.speed * dt}
		local moveY = {v.yvel - v.speed * dt, v.yvel + v.speed * dt}
		v.xvel = moveX[math.random(1,2)]
		v.yvel = moveY[math.random(1,2)]
		v.order = 0
	end
end

function player.boundary(dt)
	for i,v in ipairs(player) do
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

function DRAW_PLAYER()
	player.draw()
end

function UPDATE_PLAYER(dt)
	player.physics(dt)
	player.boundary(dt)
	player.AI(dt)
end