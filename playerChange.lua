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

function playerChangeInit(state)
    gameState = "playerChange"
    currentPlayer = currentPlayer.enemy
    overlaySprite:add()
    returnState = state
end

function playerChangeUpdate()
    if playdate.buttonJustPressed(playdate.kButtonB) then
        cursor.x=1
        cursor.y=1
        overlaySprite:remove()
        gameState = returnState
    end
end
