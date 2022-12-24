local gf = false;
local duet = false
local rr = 1.2
local del = 0;
local laughtimer = 0;
function onCreate()
	makeLuaSprite('BG', 'santa/BG', -1400, -900);
	setLuaSpriteScrollFactor('BG', 0.9, 0.9);
	addLuaSprite('BG', false);

	makeAnimatedLuaSprite('skid','characters/aj',65,75)
	setProperty('skid.flipX', true)
	addAnimationByPrefix('skid','idle','idle',24,false)
	addAnimationByPrefix('skid','singLEFT','left',24,false)
	addAnimationByPrefix('skid','singDOWN','down',24,false)
	addAnimationByPrefix('skid','singUP','up',24,false)
	addAnimationByPrefix('skid','singRIGHT','right',24,false)
	addAnimationByPrefix('skid','haha','up',24,false)
	addAnimationByPrefix('skid','laugh','up',24,false)
	addAnimationByPrefix('skid','hey','up',24,false)
	addLuaSprite('skid',true)
	objectPlayAnimation('skid',anim,false)
	
	makeAnimatedLuaSprite('fs','characters/fs',900,200)
	addAnimationByPrefix('fs','idle','idle',24,false)
	addAnimationByPrefix('fs','haha','up',24,false)
	addAnimationByPrefix('fs','laugh','up',24,false)
	addAnimationByPrefix('fs','hey','up',24,false)
	addLuaSprite('fs',true)
	objectPlayAnimation('fs',anim,false)
	
	makeAnimatedLuaSprite('rr','characters/rr',-350,200)
	setProperty('rr.flipX', true)
	addAnimationByPrefix('rr','idle','idle',24,false)
	addAnimationByPrefix('rr','haha','up',24,false)
	addAnimationByPrefix('rr','laugh','up',24,false)
	addAnimationByPrefix('rr','hey','up',24,false)
	addLuaSprite('rr',true)
	objectPlayAnimation('rr',anim,false)



	--Iterate over all notes
	for i = 0, getProperty('unspawnNotes.length')-1 do
		--Check if the note is an Instakill Note
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Alt Animation' and not getPropertyFromGroup('unspawnNotes', i, 'mustHit') then
			setPropertyFromGroup('unspawnNotes', i, 'noAnimation', true); --Change texture

		end
	end
end

function onBeatHit()
	if laughtimer == 0 then
		objectPlayAnimation('skid','idle',false)
		objectPlayAnimation('fs','idle',false)
		objectPlayAnimation('rr','idle',false)
	end

end

function onUpdate()
	if laughtimer > 0 then
		laughtimer = math.floor(laughtimer) - 1;
	end
	if del > 0 then
		del = del - 1;
	end


end

function goodNoteHit(id, direction, noteType, isSustainNote)
	if duet == false then
		setProperty('defaultCamZoom', rr)
		if noteType == 'GF Sing' then
			
			triggerEvent('Camera Follow Pos',950,300)
		elseif noteType == 'Hey!' then
			triggerEvent('Add Camera Zoom',0.04,0)
		elseif noteType == 'HAHA' then
			triggerEvent('Play Animation','haha', '')
		elseif noteType == 'HAHAGF' then

		else
			triggerEvent('Camera Follow Pos',820.7, 472)
		end
	else
		triggerEvent('Camera Follow Pos',725,425)
		setProperty('defaultCamZoom', 0.75)
	end
end

function opponentNoteHit(id, d, noteType, isSustainNote)
	if duet == false then
		setProperty('defaultCamZoom', rr)
		if noteType == 'GF Sing' then
			triggerEvent('Camera Follow Pos',950,300)
		elseif noteType == 'Hey!' then
			laughtimer = (6.1*stepCrochet/1000)*(framerate/60)
			objectPlayAnimation('skid','hey',true)
			objectPlayAnimation('fs','hey',true)
			objectPlayAnimation('rr','hey',true)
			triggerEvent('Play Animation','singUP', 'gf')
		elseif noteType == 'HAHA' then
			triggerEvent('Play Animation','haha', 'dad')
			objectPlayAnimation('skid','laugh',true)
			objectPlayAnimation('fs','laugh',true)
			objectPlayAnimation('rr','laugh',true)
			triggerEvent('Play Animation','singUP', 'gf')
			laughtimer = (6.1*stepCrochet/1000)*(framerate/60)
		elseif noteType == 'HAHAGF' then

		else
			triggerEvent('Camera Follow Pos',500,300)
		end
	else

		if noteType == 'Hey!' then
			laughtimer = (6.1*stepCrochet/1000)*(framerate/60)
			objectPlayAnimation('skid','hey',true)
			objectPlayAnimation('fs','hey',true)
			objectPlayAnimation('rr','hey',true)
			triggerEvent('Play Animation','singUP', 'gf')
		elseif noteType == 'HAHA' then
			triggerEvent('Play Animation','haha', 'dad')
			objectPlayAnimation('skid','laugh',true)
			objectPlayAnimation('fs','laugh',true)
			objectPlayAnimation('rr','laugh',true)
			triggerEvent('Play Animation','singUP', 'gf')
			laughtimer = (6.1*stepCrochet/1000)*(framerate/60)
		elseif noteType == 'HAHAGF' then

		end

		triggerEvent('Camera Follow Pos',725,425)
		setProperty('defaultCamZoom', 0.75)
	end
	if noteType == 'Alt Animation' or noteType == 'Spooky Sing' then
	if duet == false then
		triggerEvent('Camera Follow Pos',640,472)
	end
		if d == 0 then
		anim = 'singLEFT'
		end
		if d == 1 then
		anim = 'singDOWN'
		end
		if d == 2 then
		anim = 'singUP'
		end
		if d == 3 then
		anim = 'singRIGHT'
		end
			laughtimer = (6.1*stepCrochet/1000)*(framerate/60)
		objectPlayAnimation('skid',anim,true)
	end
end

function onEvent(name,value1,value2)
	if name == 'Kill Henchmen' then
		
		if del == 0 then
			del = 3
			if duet == true then
				duet = false
			else
				duet = true
			end
		end

	end
	
	if name == 'BG Freaks Expression' then
		
		doTweenAlpha('eEe','BG',0.5,1,'linear')

	end
	
		if name == 'BG Freaks Expression2' then
		
		doTweenAlpha('eEe','BG',1,1,'linear')

	end


	if name == 'YEA!' then

		triggerEvent('Add Camera Zoom',0.6,0.3)

	end

end

