-- include useful files
execScript("utils.lua")
execScript("common.lua")
execScript("square.lua")

-- this function adds a pattern to the timeline based on a key
function addPattern(mKey)
	
	if mKey ==  0 then square2spin(55)
	elseif mKey ==  1 then square1spin(38)
	elseif mKey ==  2 then squarerain(32)
	elseif mKey ==  3 then squaresolo(38)
	elseif mKey ==  4 then squareInverseBarrage(2,38)
	elseif mKey ==  5 then squaremultiv2(34)
	elseif mKey ==  6 then squarespiral(42)
	elseif mKey ==  7 then squarealtspiral(54)
	elseif mKey ==  8 then squaremultiv1(34)
	elseif mKey ==  9 then squareboxcap(53)
	elseif mKey ==  10 then squaremultisolo(38)
	elseif mKey ==  11 then squarestaggeredspiral(35)
	end
end

-- shuffle the keys, and then call them to add all the patterns
-- shuffling is better than randomizing - it guarantees all the patterns will be called
keys = { 0, 0, 0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 4, 4, 4, 5, 5, 5, 6, 6, 6, 7, 7, 7, 8, 8, 8, 9, 9, 9, 10, 10, 11, 11, 11}
keys = shuffle(keys)
index = 0

-- onLoad is an hardcoded function that is called when the level is started/restarted
function onLoad()
	--variables for the rotation flip and the OMGWTH spin
	timerval = 660
	setLevelValueFloat("rotation_speed", 0)
	rotation = 0
	speedincrement = getLevelValueFloat("speed_increment")
	waited = false

	if isKeyPressed(58) then
		if timerval > 640 then 
			execEvent("finalexit") end
	end

	if isKeyPressed(17) then
		if timerval > 640 then 
			execEvent("finalexit") end
	end

	if isKeyPressed(57) then
		if timerval > 640 then 
			execEvent("finalexit") end
	end
	

end

-- onStep is an hardcoded function that is called when the level timeline is empty
-- onStep should contain your pattern spawning logic
function onStep()	
	addPattern(keys[index])
	index = index + 1
	
	if index - 1 == table.getn(keys) then
		index = 1
	end
end

-- onIncrement is an hardcoded function that is called when the level difficulty is incremented
function onIncrement()
end

-- onUnload is an hardcoded function that is called when the level is closed/restarted
function onUnload()
execEvent("finalexit")
end

-- onUpdate is an hardcoded function that is called every frame
function onUpdate(mFrameTime)


	if isKeyPressed(58) then
		if timerval > 640 then 
		execEvent("finalexit") end
	end

	if isKeyPressed(17) then
		if timerval > 640 then 
		execEvent("finalexit") end
	end

	if isKeyPressed(57) then
		if timerval > 640 then 
		execEvent("finalexit") end
	end
	
	if waited == false then
		if timerval < 660 then 
		wait(240)
		waited = true end
	end

	timerval = timerval - mFrameTime

	if timerval < 0 then -- after 10 seconds rotate fast
		if math.random(0, 100) >= 50 then rotdir = 1 else rotdir = -1 end
		incrementsettings()
		setLevelValueFloat("rotation_speed", 0.8*rotdir)
		timerval = 600
	end


	if timerval < 585 then

		if math.abs(rotation) >= 360 then 
			setLevelValueFloat("rotation_speed", 0.00) 
			rotation = rotation-rotdir*360 
		elseif math.abs(rotation) > 350 then setLevelValueFloat("rotation_speed", 0.1*rotdir)
		elseif math.abs(rotation) > 340 then setLevelValueFloat("rotation_speed", 0.2*rotdir)
		elseif math.abs(rotation) > 320 then setLevelValueFloat("rotation_speed", 0.4*rotdir)
		end

	end

	rotation = rotation + (10*getLevelValueFloat("rotation_speed")*mFrameTime)
end

function incrementsettings()
		setLevelValueFloat("speed_multiplier", getLevelValueFloat("speed_multiplier") + speedincrement)
		if getLevelValueFloat("speed_multiplier") > 2.5 then speedincrement = 0 end
end