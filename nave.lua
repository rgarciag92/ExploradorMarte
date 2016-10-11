nave = {}
nave.radio = 10

function nave.spawn(x, y)
	table.insert(nave, {x = x , y = y, radio = nave.radio})
end

function nave.draw()
	for i, v in ipairs(nave) do
		love.graphics.setColor(0, 0, 255)
		love.graphics.circle("fill", v.x, v.y, v.radio)
	end
end


function DRAW_NAVE()
	nave.draw()
end