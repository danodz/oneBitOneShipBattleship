import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"
import "tileImages"
import "setup"
import "playing"
import "playerChange"
import "gameOver"
import "newGame"
import "instructions"

local gfx <const> = playdate.graphics
local geo <const> = playdate.geometry

positions = {
    setupGrid = {x=110,y=10},
    leftGrid = {x=10,y=10},
    rightGrid = {x=210,y=10},
    currentPlayer = {x=25,y=10},
    currentPlayerPlaying = {x=6,y=200},
    inventory = {x=30,y=202},
    gridMsg = {x=105,y=200},
    gridMsgPlaying = {x=206,y=200}
}

local menuImg = gfx.image.new(400,240, gfx.kColorWhite)
local menuMargin = 5

gfx.pushContext(menuImg)
    gfx.setColor(gfx.kColorBlack)
    gfx.drawText("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus interdum velit eros, a auctor purus tincidunt non. Ut cursus leo nisl, malesuada finibus neque sagittis non. Aenean non molestie lacus. Nam egestas, mauris sollicitudin porttitor faucibus, est turpis consequat nisl", menuMargin, menuMargin, 200-menuMargin, 240-menuMargin)
gfx.popContext()
playdate.setMenuImage(menuImg)

playdate.getSystemMenu():addMenuItem("Instructions", function()
    instructionsInit()
end)

decoyLimit = 5

function txtSprite(x,y,width,height,update)
    local sprite = gfx.sprite.new()
    sprite:setSize(width, height)
    sprite.oldText = ""
    sprite.currentText = ""
    sprite:setCenter(0,0)
    sprite:moveTo(x,y)
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

newGame()

function playdate.update()
    if gameState == "instructions" then
        instructionsUpdate()
    else
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
    end
    
    gfx.sprite.update()
    playdate.timer.updateTimers()
end
