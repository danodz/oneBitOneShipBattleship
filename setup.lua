local gfx <const> = playdate.graphics

local invCursor
local inventory
local inventorySprite
local validGrid
local shipLength
local crankMove
local inventoryX
function setupInit()
    
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
    
    local inventoryTiles = {1,2,5}
    inventory = gfx.tilemap.new()
    inventory:setImageTable(tileImages())
    inventory:setTiles(inventoryTiles, 3)
    inventorySprite = gfx.sprite.new(inventory)
    inventorySprite:setCenter(0,0)
    inventorySprite:moveTo(positions.inventory.x, positions.inventory.y)
    inventorySprite:add()

    validGrid = false
    gridMsg = "Make your ship"
    crankMove = 0
end

function validateGrid(grid)
    local totalDecoys = 0

    local firstShipX
    local firstShipY
    local totalShips = 0
    local tiles = grid:getTiles()
    for i=0,9 do
        for j=1,10 do
            if tiles[i*10+j] == 2 then
                totalShips += 1
                firstShipX = i
                firstShipY = j
            elseif tiles[i*10+j] == 5 then
                totalDecoys += 1
            end
        end
    end

    if totalDecoys > decoyLimit then
        return false, "Too many decoys"
    end

    if totalShips < 2 then
        return false, "Ship too small"
    end
    if totalShips > 10 then
        return false, "Ship too big"
    end

    local adjacentShips = 0
    function testTile(i,j)
        if( tiles[i*10+j] == 2 ) then
            adjacentShips += 1
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

    addAdjacents(firstShipX,firstShipY)
    
    local valid = (adjacentShips == totalShips)
    if valid then
        return true, "Valid grid, press B to proceed", totalShips
    else
        return false, "Too many Ships", totalShips
    end
end

function setupUpdate()
    if playdate.buttonJustPressed(playdate.kButtonA) then
        leftGrid:setTileAtPosition(cursor.x,cursor.y,inventory:getTiles()[invCursor.x])
        validGrid, gridMsg, shipLength = validateGrid(leftGrid)
    end

    if playdate.buttonJustPressed(playdate.kButtonB) and validGrid then
        currentPlayer.tiles = leftGrid:getTiles()
        currentPlayer.shipLength = shipLength
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
            validGrid = false
            gridMsg = "Make your ship"
            crankMove = 0
        end
    end

    local change = playdate.getCrankChange()
    crankMove += change
    if change == 0 then
        crankMove = 0
    end
    if crankMove >= 45 and invCursor.x < 3 then
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
