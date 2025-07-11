import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"
local gfx <const> = playdate.graphics

function newGame()
    gameState = "setup"
    lastMove = false
    emptyGrid = {}
    for i=1,100 do
        emptyGrid[i]=1
    end
    
    images = tileImages()
    local player1={}
    local player2={}
    currentPlayer = player1
    function initPlayer(player, enemy, name)
        player.enemy = enemy
        player.name = name
        player.moves = table.shallowcopy(emptyGrid)
        player.totalHits = 0
    end
    initPlayer(player1,player2,"Player 1")
    initPlayer(player2,player1,"Player 2")
    
    currentPlayerSprite = txtSprite(positions.currentPlayer.x,positions.currentPlayer.y,150,25,function(sprite)
        sprite.currentText = currentPlayer.name
    end)
    leftGrid = gfx.tilemap.new()
    leftGrid:setImageTable(images)
    leftGrid:setTiles(emptyGrid, 10)
    leftGridSprite = gfx.sprite.new(leftGrid)
    leftGridSprite:setCenter(0,0)
    leftGridSprite:moveTo(positions.setupGrid.x,positions.setupGrid.y)
    leftGridSprite:add()
    
    rightGrid = gfx.tilemap.new()
    rightGrid:setImageTable(images)
    rightGrid:setTiles(emptyGrid, 10)
    rightGridSprite = gfx.sprite.new(rightGrid)
    rightGridSprite:setCenter(0,0)
    rightGridSprite:moveTo(positions.rightGrid.x,positions.rightGrid.y)
    
    gridMsg = ""
    local noShake = {"Valid grid, press B to proceed", "Make your move", "Make your ship"}
    local previousTimer = 0
    gridMsgSprite = txtSprite(positions.gridMsg.x,positions.gridMsg.y,250,25,function(sprite)
        if sprite.oldText ~= gridMsg then
            if previousTimer ~= 0 then
                if gameState ~= "playing" then
                    sprite:moveTo(positions.gridMsg.x, positions.gridMsg.y)
                else
                    sprite:moveTo(positions.gridMsgPlaying.x, positions.gridMsgPlaying.y)
                end
                previousTimer:remove()
                previousTimer = 0 
            end
            if table.indexOfElement(noShake, gridMsg) == nil then
                
                local duration = 0
                local shakeState = 0
                local amplitude = 4
                previousTimer = playdate.timer.keyRepeatTimerWithDelay(5,5, function(timer)
                    duration += 1
                    shakeState += 1
                    if shakeState % 5 == 0 then
                        sprite:moveBy(0,amplitude)
                    elseif shakeState % 5 == 1 then
                        sprite:moveBy(amplitude,-amplitude)
                    elseif shakeState % 5 == 2 then
                        sprite:moveBy(-amplitude,amplitude)
                    elseif shakeState % 5 == 3 then
                        sprite:moveBy(-amplitude,-amplitude)
                    elseif shakeState % 5 == 4 then
                        sprite:moveBy(amplitude,0)
                    end
                    if duration == 30 then
                        if gameState == "setup" then
                            sprite:moveTo(positions.gridMsg.x, positions.gridMsg.y)
                        else
                            sprite:moveTo(positions.gridMsgPlaying.x, positions.gridMsgPlaying.y)
                        end
                        previousTimer = 0 
                        timer:remove()
                    end
                end)

            end
        end
        sprite.currentText = gridMsg
    end)
    
    local cursorImg = gfx.image.new(22, 22, gfx.kColorBlack)
    gfx.pushContext(cursorImg)
        gfx.setColor(gfx.kColorWhite)
        gfx.fillCircleAtPoint(11,11,9)
    gfx.popContext()
    cursor = {
        x=1,
        y=1,
        offset=leftGridSprite.x,
        sprite= gfx.sprite.new(cursorImg)
    }
    cursor.sprite:setZIndex(-1)
    cursor.sprite:moveTo(
        (cursor.x-1)*18+cursor.sprite.width/2 - 2 + cursor.offset,
        (cursor.y-1)*18+cursor.sprite.height - 3
    )
    cursor.sprite:add()
    
    setupInit()
end
