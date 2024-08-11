local gfx <const> = playdate.graphics
local geo <const> = playdate.geometry

function gameOverInit()
    gameState = "gameOver"
    leftGrid:setTiles(currentPlayer.tiles, 10)
    rightGrid:setTiles(currentPlayer.enemy.tiles, 10)

    leftGridSprite:moveBy(0,40)
    rightGridSprite:moveBy(0,40)
    cursor.sprite:remove()
    gridMsgSprite:remove()
    currentPlayerSprite:remove()

    local winMsg = gfx.sprite.spriteWithText(currentPlayer.name .. " wins!",200,100)
    winMsg:moveTo(10,10)
    winMsg:setCenter(0,0)
    winMsg:add()
    local restartMsg = gfx.sprite.spriteWithText("Crank to restart",200,100)
    restartMsg:moveTo(10,30)
    restartMsg:setCenter(0,0)
    restartMsg:add()
end

function gameOverUpdate()
end
