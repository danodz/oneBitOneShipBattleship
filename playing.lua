local gfx <const> = playdate.graphics

function playingInit()
    gridMsg = "Make your move"
    leftGridSprite:moveTo(positions.leftGrid.x, positions.leftGrid.y)
    cursor.offset=leftGridSprite.x,
    leftGrid:setTiles(currentPlayer.moves, 10)
    rightGridSprite:add()
    rightGrid:setTiles(currentPlayer.tiles, 10)

    currentPlayerSprite:moveTo(positions.currentPlayerPlaying.x, positions.currentPlayerPlaying.y)
    gridMsgSprite:moveTo(positions.gridMsgPlaying.x, positions.gridMsgPlaying.y)
end
local decoyTxts = {"On a mermaid", "On a crab", "On a seal", "On a garbage patch", "On a blowfish"}
function playingUpdate()
    if playdate.buttonJustPressed(playdate.kButtonA) then
        local index = (cursor.y-1)*10 + cursor.x
        if currentPlayer.moves[index] == 1 then
            local status
            local decoy = 0
            if currentPlayer.enemy.tiles[index] == 2 then
                status = 3
                currentPlayer.totalHits += 1
                gridMsg = "It's a hit"
            elseif currentPlayer.enemy.tiles[index] == 1 then
                status = 4
                gridMsg = "It's a miss"
            else
                status = 3
                gridMsg = "It's a hit"
                decoy = math.random(5)
            end
            lastMove = {
                x = cursor.x * 18 + positions.rightGrid.x - 9,
                y = cursor.y * 18 + positions.rightGrid.y - 9 
            }
    
            currentPlayer.moves[index] = status
            currentPlayer.enemy.tiles[index] = status
            leftGrid:setTiles(currentPlayer.moves, 10)
            gfx.sprite.update()
    
            gameState = "playerChangeWait"
            if decoy ~= 0 then
                playdate.timer.performAfterDelay(2000, function()
                    gridMsg = decoyTxts[decoy]
                    currentPlayer.moves[index] = decoy + 5
                    currentPlayer.enemy.tiles[index] = decoy + 5
                    leftGrid:setTiles(currentPlayer.moves, 10)
                    gfx.sprite.update()
                    playdate.timer.performAfterDelay(2000, function()
                        gridMsg = "Make your move"
                        playerChangeInit("playing")
                        rightGrid:setTiles(currentPlayer.tiles, 10)
                        leftGrid:setTiles(currentPlayer.moves, 10)
                    end)
                end)
            else
                playdate.timer.performAfterDelay(2000, function()
                    if currentPlayer.totalHits == currentPlayer.enemy.shipLength then
                        gameOverInit()
                    else
                        gridMsg = "Make your move"
                        playerChangeInit("playing")
                        rightGrid:setTiles(currentPlayer.tiles, 10)
                        leftGrid:setTiles(currentPlayer.moves, 10)
                    end
                end)
            end
        end
    end
end
