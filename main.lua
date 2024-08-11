import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"
import "tileImages"
import "setup"
import "playing"
import "playerChange"
import "gameOver"

local gfx <const> = playdate.graphics
local geo <const> = playdate.geometry

function txtSprite(x,y,width,height,update)
    local sprite = gfx.sprite.new()
    sprite:setSize(width, height)
    sprite.oldText = ""
    sprite.currentText = ""
    sprite:moveTo(width/2+x,height/2+y)
    sprite:add()
    
    function sprite:update()
        update(sprite)
        if sprite.oldText ~= sprite.currentText then
    	    self:markDirty()
        end
        sprite.oldText = sprite.currentText
    end
    
    function sprite:draw()
    	gfx.drawText(self.currentText, 5, 5)
    end

    return sprite
end

gameState = "setup"
emptyGrid = {}
for i=1,100 do
    emptyGrid[i]=1
end

local images = tileImages()
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

currentPlayerSprite = txtSprite(10,200,150,25,function(sprite)
    sprite.currentText = currentPlayer.name
end)

leftGrid = gfx.tilemap.new()
leftGrid:setImageTable(images)
leftGrid:setTiles(emptyGrid, 10)
leftGridSprite = gfx.sprite.new(leftGrid)
leftGridSprite:setCenter(0,0)
leftGridSprite:moveTo(200-leftGridSprite.width/2,10)
leftGridSprite:add()

rightGrid = gfx.tilemap.new()
rightGrid:setImageTable(images)
rightGrid:setTiles(emptyGrid, 10)
rightGridSprite = gfx.sprite.new(rightGrid)
rightGridSprite:setCenter(0,0)
rightGridSprite:moveTo(210,10)

gridMsg = ""
gridMsgSprite = txtSprite(250,200,150,25,function(sprite)
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
cursor.sprite:add()

setupInit(images)

function playdate.update()
    if playdate.buttonJustPressed(playdate.kButtonUp) and cursor.y > 1 then
        cursor.y -= 1
    end

    if playdate.buttonJustPressed(playdate.kButtonDown) and cursor.y < 10 then
        cursor.y += 1
    end

    if playdate.buttonJustPressed(playdate.kButtonLeft) and cursor.x > 1 then
        cursor.x -= 1
    end

    if playdate.buttonJustPressed(playdate.kButtonRight) and cursor.x < 10 then
        cursor.x += 1
    end
    
    cursor.sprite:moveTo(
        (cursor.x-1)*18+cursor.sprite.width/2 - 2 + cursor.offset,
        (cursor.y-1)*18+cursor.sprite.height - 3
    )

    if gameState == "setup" then
        setupUpdate()
    elseif gameState == "playing" then
        playingUpdate()
    elseif gameState == "playerChange" then
        playerChangeUpdate()
    elseif gameState == "gameOver" then
        gameOverUpdate()
    end

    gfx.sprite.update()
    playdate.timer.updateTimers()
end
