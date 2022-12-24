function onUpdate()
    if botPlay == true then
        setProperty('botplayTxt.visible', false)
     end
end
     
function goodNoteHit(id, direction, noteType, isSustainNote)
    if botPlay == true then
        if not isSustainNote then
            addScore(350)
            setRatingPercent(1)
            setProperty('songHits', getProperty('songHits') + 1)
            sicks = sicks + 1
        end
    end
end

function onUpdatePost()
    if botPlay == true and ratingName == '?' and getProperty('songHits') > 0 then
        setRatingName('Perfect!!')
    end
end