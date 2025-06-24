local gfx <const> = playdate.graphics
local geo <const> = playdate.geometry

function playingInit()
    gridMsg = "Make your move"
    leftGridSprite:moveTo(positions.leftGrid.x, positions.leftGrid.y)
    cursor.offset=leftGridSprite.x,
    leftGrid:setTiles(currentPlayer.moves, 10)
    rightGridSprite:add()
    rightGrid:setTiles(currentPlayer.tiles, 10)
end
local decoyTxts = {"On a mermaid", "On a crab"}
function playingUpdate()
    if playdate.buttonJustPressed(playdate.kButtonA) then
        local index = (cursor.y-1)*10 + cursor.x
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
            decoy = currentPlayer.enemy.tiles[index]+1
        end

        currentPlayer.moves[index] = status
        currentPlayer.enemy.tiles[index] = status
        leftGrid:setTiles(currentPlayer.moves, 10)
        gfx.sprite.update()

        playdate.wait(2000)
        if decoy ~= 0 then
            gridMsg = decoyTxts[decoy/2-2]
            currentPlayer.moves[index] = decoy
            currentPlayer.enemy.tiles[index] = decoy
            leftGrid:setTiles(currentPlayer.moves, 10)
            gfx.sprite.update()
            playdate.wait(2000)
        end

        if currentPlayer.totalHits == currentPlayer.enemy.boatLength then
            gameOverInit()
        else
            gridMsg = "Make your move"
            playerChangeInit("playing")
            rightGrid:setTiles(currentPlayer.tiles, 10)
            leftGrid:setTiles(currentPlayer.moves, 10)
        end
    end
end
