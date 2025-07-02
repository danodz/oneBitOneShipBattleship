local gfx <const> = playdate.graphics
local geo <const> = playdate.geometry

local restartCrank = 0

function gameOverInit()
    gameState = "gameOver"
    leftGrid:setTiles(currentPlayer.tiles, 10)
    rightGrid:setTiles(currentPlayer.enemy.tiles, 10)

    leftGridSprite:moveBy(0,40)
    rightGridSprite:moveBy(0,40)
    cursor.sprite:remove()
    gridMsgSprite:remove()
    currentPlayerSprite:remove()

    winMsg = gfx.sprite.spriteWithText(currentPlayer.name .. " wins!",200,100)
    winMsg:moveTo(10,10)
    winMsg:setCenter(0,0)
    winMsg:add()
    restartMsg = gfx.sprite.spriteWithText("Crank to restart",200,100)
    restartMsg:moveTo(10,30)
    restartMsg:setCenter(0,0)
    restartMsg:add()

    circleSprite = gfx.sprite.new()
    circleSprite:moveTo(200,120)
    circleSprite:setZIndex(3)
    circleSprite:add()
end

function gameOverUpdate()
    if restartCrank > 0 then
        restartCrank -= 1
    else
        restartCrank = 0
    end
    restartCrank += playdate.getCrankChange()

    local circle = gfx.image.new(400, 240, gfx.kColorClear)
    gfx.pushContext(circle)
        gfx.setColor(gfx.kColorWhite)
        gfx.fillCircleAtPoint(200,120,restartCrank)
    gfx.popContext()
    circleSprite:setImage(circle)

    if restartCrank > 220 then
        gfx.sprite.removeAll()

        newGame()

        circleSprite:remove()
        restartCrank = 0
    end
end
