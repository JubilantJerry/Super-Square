
if getLevelValueString("id") == "square" then

	setLevelValueFloat("speed_multiplier", 1.8)
	if getLevelValueFloat("rotation_speed") > 0 then setLevelValueFloat("rotation_speed", 0.27)
	else setLevelValueFloat("rotation_speed", -0.27) end


elseif getLevelValueString("id") == "squarer" then

	setLevelValueFloat("speed_multiplier", 2.0)
	if getLevelValueFloat("rotation_speed") > 0 then setLevelValueFloat("rotation_speed", 0.27)
	else setLevelValueFloat("rotation_speed", -0.27) end


elseif getLevelValueString("style_id") == "greyscale" then

	if getLevelValueFloat("rotation_speed") > 0 then setLevelValueFloat("rotation_speed", 0.35)
	else setLevelValueFloat("rotation_speed", -0.35) end


elseif getLevelValueString("id") == "squarest" then

	setLevelValueFloat("speed_multiplier", 2.7)
	if getLevelValueFloat("rotation_speed") > 0 then setLevelValueFloat("rotation_speed", 0.31)
	else setLevelValueFloat("rotation_speed", -0.31) end
	setLevelValueFloat("rotation_increment", 0.003)


end
