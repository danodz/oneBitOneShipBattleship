local gfx <const> = playdate.graphics
local geo <const> = playdate.geometry

local invCursor
local inventory
local inventorySprite
local validGrid
local boatLength
local crankMove
local inventoryX
function setupInit(images)
    local invCursorImg = gfx.image.new(22, 22, gfx.kColorBlack)
    gfx.pushContext(invCursorImg)
        gfx.setColor(gfx.kColorWhite)
        gfx.fillCircleAtPoint(11,11,9)
    gfx.popContext()
    invCursor = {
        x=2,
        y=1,
        sprite= gfx.sprite.new(invCursorImg)
    }
    invCursor.sprite:add()
    
    local inventoryTiles = {1,2,5,7}
    inventory = gfx.tilemap.new()
    inventory:setImageTable(images)
    inventory:setTiles(inventoryTiles, 4)
    inventorySprite = gfx.sprite.new(inventory)
    inventorySprite:setCenter(0,0)
    inventorySprite:moveTo(positions.inventory.x, positions.inventory.y)
    inventorySprite:add()

    validGrid = false
    gridMsg = "Make your boat"
    crankMove = 0
end

function validateGrid(grid)
    local totalCrabs = 0
    local totalMermaids = 0

    local firstBoatX
    local firstBoatY
    local totalBoats = 0
    local tiles = grid:getTiles()
    for i=0,9 do
        for j=1,10 do
            if tiles[i*10+j] == 2 then
                totalBoats += 1
                firstBoatX = i
                firstBoatY = j
            elseif tiles[i*10+j] == 5 then
                totalMermaids += 1
            elseif tiles[i*10+j] == 7 then
                totalCrabs += 1
            end
        end
    end

    if totalMermaids > mermaidLimit and totalCrabs > crabLimit then
        return false, "Too many mermaids and crabs"
    elseif totalMermaids > mermaidLimit then
        return false, "Too many mermaids"
    elseif totalCrabs > crabLimit then
        return false, "Too many crabs"
    end

    if totalBoats < 2 then
        return false, "Boat too small"
    end
    if totalBoats > 10 then
        return false, "Boat too big"
    end

    local adjacentBoats = 0
    function testTile(i,j)
        if( tiles[i*10+j] == 2 ) then
            adjacentBoats += 1
            tiles[i*10+j] = -1
            addAdjacents(i,j)
        end
    end
    function addAdjacents(x,y)
        testTile(x-1,y)
        testTile(x+1,y)
        testTile(x,y-1)
        testTile(x,y+1)
    end

    addAdjacents(firstBoatX,firstBoatY)
    
    local valid = (adjacentBoats == totalBoats)
    if valid then
        return true, "Grid is valid", totalBoats
    else
        return false, "Too many boats", totalBoats
    end
end

function setupUpdate()
    if playdate.buttonJustPressed(playdate.kButtonA) then
        leftGrid:setTileAtPosition(cursor.x,cursor.y,inventory:getTiles()[invCursor.x])
        validGrid, gridMsg, boatLength = validateGrid(leftGrid)
    end

    if playdate.buttonJustPressed(playdate.kButtonB) and validGrid then
        currentPlayer.tiles = leftGrid:getTiles()
        currentPlayer.boatLength = boatLength
        cursor.x=1
        cursor.y=1
        invCursor.x=2
        invCursor.y=1
        if currentPlayer.name == "Player 2" then
            inventorySprite:remove()
            invCursor.sprite:remove()
            playerChangeInit("playing")
            playingInit()
        else
            leftGrid:setTiles(emptyGrid, 10)
            playerChangeInit("setup")
        end
    end

    local change = playdate.getCrankChange()
    crankMove += change
    if change == 0 then
        crankMove = 0
    end
    if crankMove >= 45 and invCursor.x < 4 then
        crankMove = 0
        invCursor.x += 1
    end
    if crankMove <= -45 and invCursor.x > 1 then
        crankMove = 0
        invCursor.x -= 1
    end

    invCursor.sprite:moveTo(
        positions.inventory.x + ((invCursor.x-1)*18+invCursor.sprite.width/2)-2,
        positions.inventory.y + ((invCursor.y-1)*18+invCursor.sprite.height/2)-2
    )
end
