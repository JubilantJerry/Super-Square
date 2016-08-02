execScript("common.lua")

--prerequisite for altpatternizer
function cycle(mSides)
	eArray = {}
	j = getRandomSide()
	for i = 1, mSides do 
		eArray[i] = (i + j) % mSides + 1
	end
	return eArray
end

-- pMirrorWallStrip: spawns rWalls close to one another on the same side
function pMirrorWallStrip(mTimes, mExtra)
	delay = getPerfectDelay(THICKNESS) * 2.65
	startSide = getRandomSide()
	
	for i = 0, mTimes do
		rWallEx(startSide, mExtra)
		wait(delay)
	end
	
	wait(getPerfectDelay(THICKNESS) * 4.00)
end

-- pMirrorBarrageStrip: spawns cbarrages close to one another on the same side
function pMirrorBarrageStrip(mTimes)
	delay = getPerfectDelay(THICKNESS) * 2.65
	startSide = getRandomSide()

	for i = 0, mTimes do
		cBarrage(startSide)
		wait(delay)
	end
	
	wait(getPerfectDelay(THICKNESS) * 4.00)
end

-- squareInverseBarrage: spawns two barrages who force you to turn 180 degrees, removing the extra delay in polygons fewer than 6 sides.
function squareInverseBarrage(mTimes, myThickness)
	delay = getPerfectDelay(myThickness) * 8
	startSide = getRandomSide()
	
	for i = 0, mTimes do
		cBarrage(startSide)
		wait(delay)
		cBarrage(startSide + getHalfSides())
		wait(delay)
	end
	
--	wait(getPerfectDelay(myThickness) * 4)
end

-- altpatternizer: pattern generator, with 2 repeatable patterns and 2 caps.
function altpatternizer(mtimes,mArray1,mArray2,myThickness,mArrayCap1, mArrayCap2)
	delay = getPerfectDelay(myThickness)
	eArray = cycle(getSides())

	j = math.floor(table.getn(mArray1) / getSides())
	
	for p = 1, mtimes, 1 do
		for i = 1, j do
			for k = 1, getSides() do
				if mArray1[(i - 1)*getSides() + k] > 0 then
					wall(eArray[k], myThickness*mArray1[(i - 1)*getSides() + k])
				end
			end
			wait(delay*5)
		end

		for i = 1, j do
			for k = 1, getSides() do
				if mArray2[(i - 1)*getSides() + k] > 0 then
					wall(eArray[k], myThickness*mArray2[(i - 1)*getSides() + k])
				end
			end
			wait(delay*5)
		end
	end

	for i = 1, j do
		for k = 1, getSides() do
			if mArrayCap1[(i - 1)*getSides() + k] > 0 then
				wall(eArray[k], myThickness*mArrayCap1[(i - 1)*getSides() + k])
			end
		end
		wait(delay*5)
	end
	
	for i = 1, j do
		for k = 1, getSides() do
			if mArrayCap2[(i - 1)*getSides() + k] > 0 then
				wall(eArray[k], myThickness*mArrayCap2[(i - 1)*getSides() + k])
			end
		end
		wait(delay*5)
	end
	
	wait(delay*5)
end

--square2spin - Spawns a 2-spin (tunnel with 180 degree seperation)
function square2spin(myThickness)
	altpatternizer(3,{5.2,2,1.5,0},{5.2,0,1.5,2},myThickness,{5.2,2,1.5,0},{5.2,0,1.5,2})
end

--square1spin - Spawns a 1-spin (tunnel with 90 degree seperation) with a cbarrage as a cap.
function square1spin(myThickness)
	altpatternizer(4,{0,2,5.2,5.2},{2,0,5.2,5.2},myThickness,{0,0,0,5.2},{2,2,0,5.2})
end

--squarerain - Spawns a rain of rwalls, with a cbarrage and a line as caps
function squarerain(myThickness)
	altpatternizer(3,{0,1,0,1},{1,0,1,0},myThickness,{0,1.5,1.5,1.5},{1,0,0,0})
end

--squaresolo - Spawns a solo.
function squaresolo(myThickness)
	wait(getPerfectDelay(THICKNESS) * 2)
	if math.random(0,100)>33 then pMirrorWallStrip(1, 0)
	elseif math.random(0,100)>=50 then pMirrorBarrageStrip(0)
	else pMirrorBarrageStrip(2) end
end

--squaremultiv1 - Spawns a multi-V (Several V-shaped wedges).
function squaremultiv1(myThickness)
	altpatternizer(3,{2,2,0,0},{0,0,2,2},myThickness,{2,2,0,0},{0,0,2,2})
end

--squaremultiv2 - Spawns a multi-V (Several V-shaped wedges) with a modified ending pair.
function squaremultiv2(myThickness)
	if math.random(0,100)>=50 then
		altpatternizer(3,{2,2,0,0},{0,0,2,2},myThickness,{2,0,0,2},{0,2,2,0})
	else
		altpatternizer(3,{2,2,0,0},{0,0,2,2},myThickness,{0,2,2,0},{2,0,0,2})
	end

end

--squarespiral - Spawns a spiral/whirlpool.
function squarespiral(myThickness)
	if math.random(0,100)>=50 then altpatternizer(1,{1.8,2.4,8.4,0},{0,0,0,6},myThickness,{7.2,0,0,0},{0,6,1.2,0})
	else altpatternizer(1,{0,8.4,2.4,1.8},{6,0,0,0},myThickness,{0,0,0,7.2},{0,1.2,6,0})
	end
end

--squarealtspiral - Spawns a spiral/whirlpool that changes direction in the middle.
function squarealtspiral(myThickness)
	if math.random(0,100)>=50 then altpatternizer(1,{1.8,2.4,7.2,0},{1.2,0,7,6},myThickness,{0,7.2,0,0},{1.2,0,0,1.2})
	else altpatternizer(1,{0,7.2,2.4,1.8},{6,7,0,1.2},myThickness,{0,0,7.2,0},{1.2,0,0,1,2})
	end
end

--squareboxcap - Spawns a a box, a cap, a box in the opposite orientation, and another cap

function squareboxcap(myThickness)
	altpatternizer(1,{0,1,1,1},{3,1.5,0,1.5},myThickness,{0,0,2, 0},{3,4.5,0,4.5})
end

--squaremultisolo - spawns all three solos in succession, in random order
function squaremultisolo(myThickness)
	if math.random(0,100)>33 then
		pMirrorWallStrip(1, 0)
		if math.random(0,100) >= 50 then
			pMirrorBarrageStrip(0)
			pMirrorBarrageStrip(2)
		else
			pMirrorBarrageStrip(2)
			pMirrorBarrageStrip(0) end

	elseif math.random(0,100)>=50 then
		pMirrorBarrageStrip(0)
		if math.random(0,100) >= 50 then
			pMirrorWallStrip(1, 0)
			pMirrorBarrageStrip(2)
		else
			pMirrorBarrageStrip(2)
			pMirrorWallStrip(1, 0)end

	else 
		pMirrorBarrageStrip(2)
		if math.random(0,100) >= 50 then
			pMirrorWallStrip(1, 0)
			pMirrorBarrageStrip(0)
		else
			pMirrorBarrageStrip(0)
			pMirrorWallStrip(1, 0) end
	end
end

--squarestaggeredspiral - spawns a spiral formation of C's
function squarestaggeredspiral(myThickness)
	delay = getPerfectDelay(myThickness) * 3.5
	startSide = getRandomSide()
	loopDir = getRandomDir()	
	j = 0
	
	for i = 0, 5 do
		cBarrage(startSide + j)
		j = j + loopDir
		wait(delay)
		if(getSides() < 6) then wait(delay * 0.6) end
	end
	
	wait(getPerfectDelay(myThickness) * 4)
end