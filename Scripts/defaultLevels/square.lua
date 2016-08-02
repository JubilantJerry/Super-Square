-- include useful files
execScript("utils.lua")
execScript("common.lua")
execScript("square.lua")

-- this function adds a pattern to the timeline based on a key
function addPattern(mKey)
	
	if mKey ==  0 then square2spin(65)
	elseif mKey ==  1 then squaremultisolo(30)
	elseif mKey ==  2 then squaresolo(30)
	elseif mKey ==  3 then squareInverseBarrage(2,30)
	end
end

-- shuffle the keys, and then call them to add all the patterns
-- shuffling is better than randomizing - it guarantees all the patterns will be called
keys = { 0, 0, 0, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3}
keys = shuffle(keys)
index = 0

-- onLoad is an hardcoded function that is called when the level is started/restarted
function onLoad()
	log("level onLoad")
	--variables for the rotation flip and the OMGWTH spin
	timerval = 360
	oldrotspeed = getLevelValueFloat("rotation_speed")
	speedincrement = getLevelValueFloat("speed_increment")

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

end

-- onUpdate is an hardcoded function that is called every frame
function onUpdate(mFrameTime)
	timerval = timerval - mFrameTime
	if timerval < 0 then -- after 5 seconds flip direction
		incrementsettings()
		timerval = 300
	end
end


function incrementsettings()
		if getLevelValueFloat("rotation_speed") > 0 then rotincrement = getLevelValueFloat("rotation_increment")
		else rotincrement = -1 * getLevelValueFloat("rotation_increment") end
		setLevelValueFloat("rotation_speed", (getLevelValueFloat("rotation_speed") + rotincrement) * -1)
		oldrotspeed = (oldrotspeed + rotincrement) * -1
		rotincrement = rotincrement * -1
		setLevelValueFloat("speed_multiplier", getLevelValueFloat("speed_multiplier") + speedincrement)
		if getLevelValueFloat("speed_multiplier") > 1.6 then speedincrement = 0 end
		if getLevelValueFloat("rotation_speed") > 0.22 then rotincrement = 0 end
end