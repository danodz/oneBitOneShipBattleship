local gfx <const> = playdate.graphics
local geo <const> = playdate.geometry
local overlayImg = gfx.image.new(400, 240, gfx.kColorWhite)
gfx.pushContext(overlayImg)
    gfx.drawTextInRect("Pass the playdate",0,75, 400, 240, nil, nil, kTextAlignment.center)
    gfx.drawTextInRect("Press B to continue",0,100, 400, 240, nil, nil, kTextAlignment.center)
gfx.popContext()
local overlaySprite = gfx.sprite.new(overlayImg)
overlaySprite:setZIndex(1000)
overlaySprite:moveTo(200,120)
local returnState
local previousState
local btnCount=0

function playerChangeInit(state)
    previousState = gameState
    gameState = "playerChange"
    currentPlayer = currentPlayer.enemy
    overlaySprite:add()
    returnState = state
end

function playerChangeUpdate()
    local btn
    if previousState == "setup" then
        btn = playdate.buttonJustPressed(playdate.kButtonB)
    elseif previousState == "playing" then
        btn = playdate.buttonIsPressed(playdate.kButtonB)
    end
    if btn then
        cursor.x=1
        cursor.y=1
        overlaySprite:remove()
        gameState = returnState

        if lastMove then
    
            local hitEffect = gfx.image.new(22, 22, gfx.kColorClear)
            gfx.pushContext(hitEffect)
                gfx.setColor(gfx.kColorBlack)
                gfx.drawCircleAtPoint(11,11,9)
                gfx.drawCircleAtPoint(11,11,6)
            gfx.popContext()
        
            local hitEffectSprite = gfx.sprite.new(hitEffect)
            hitEffectSprite:moveTo(lastMove.x, lastMove.y)
            hitEffectSprite:add()
    
            local timer
            function shrink()
                hitEffectSprite:setScale( hitEffectSprite:getScale()+0.1)
                if hitEffectSprite:getScale() >= 2.5 then
                    hitEffectSprite:remove()
                    timer:remove()
                end
            end
            timer = playdate.timer.keyRepeatTimerWithDelay(10,10,shrink)
        end
    end
end
