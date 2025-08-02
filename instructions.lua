local gfx <const> = playdate.graphics

local returnState = gameState

local overlay = gfx.image.new(400,240, gfx.kColorWhite)
local overlaySprite = gfx.sprite.new(overlay)
overlaySprite:setCenter(0,0)
overlaySprite:setZIndex(4)

local font = gfx.font.new("fonts/Pedallica/font-pedallica")
local part1 = gfx.imageWithText([[
*Instructions*

1-bit-1-ship-battleship plays very similarly to regular battleship, with a few twists!

*First phase of the game: board setup*
-Move around your cursor on the board. Press A to place a tile; press again to cycle through the tile types (or if you go in the menu and change the input type, you can select the tile type to place with your crank). ]], 380, 10000)
local tileSelectionGif = gfx.imagetable.new("images/tileSelection")
local part2 = gfx.animation.loop.new(25,tileSelectionGif)
local part3 = gfx.imageWithText([[

-White = empty tile; Black = ship; D = decoy

-All the tiles from your ship have to be adjacent.

-Your ship has to be between 2 and 10 tiles big.

-Your ship doesn’t need to be a straight line! As long as all tiles are adjacent to at least another one, it’s valid!
]], 380, 10000)
local part4 = gfx.image.new("images/exampleShips")
local part5 = gfx.imageWithText([[

-Decoys will show a “It’s a hit!” message when discovered by the other player, before showing another fun message. They’re only there to play with the player’s heart! It will make them believe for a second that they hit a ship (and give them that sweet sweet dopamine hit), before disappointing them.
]], 380, 10000)
local decoyGif = gfx.imagetable.new("images/decoy")
local part6 = gfx.animation.loop.new(40,decoyGif)
local part7 = gfx.imageWithText([[

-You have to place between 1 and 5 decoy(s) on the map. They can be placed anywhere.

*Second phase of the game: find the enemy’s boat*
This part plays exactly like regular battleship! 

-Move around your cursor on the board. Press A when you want to check a tile. 

-On the right part of the screen, you can see what the other player has found out about your board so far.

-Once you’ve completely uncovered your enemy’s ship, you win!



Credits:
Programming and Game Design: Erwan LeBlanc
Game Design and Community Management: Rafiki
]], 380, 10000)

function imagesColumn(images)
    local sprites = {}
    local height = 20
    for _,image in ipairs(images) do
        local sprite = gfx.sprite.new(image)
        sprite:setCenter(0,0)
        sprite:moveTo(10,height)
        sprite:setZIndex(5)
        table.insert(sprites,sprite)
        if image.getSize then
            local _,imgHeight = image:getSize()
            height += imgHeight
        else
            local _,imgHeight = image:image():getSize()
            height += imgHeight
            sprite.update = function()
                sprite:setImage(image:image())
            end
        end
    end
    return sprites, height
end

local instrSprites, maxScroll = imagesColumn({part1, part2, part3, part4, part5, part6, part7 })

function instructionsInit()
    overlaySprite:add()
    for _,sprite in ipairs(instrSprites) do
        sprite:add()
    end
    if gameState == "playerChangeWait" then
        returnState = "playerChange"
    else
        returnState = gameState
    end
    gameState = "instructions"
end

function instructionsUpdate()
    if playdate.buttonJustPressed(playdate.kButtonB) then
        for _,sprite in ipairs(instrSprites) do
            sprite:remove()
        end
        overlaySprite:remove()
        gameState = returnState
    end

    local moveBy = -playdate.getCrankChange()
    if playdate.buttonIsPressed(playdate.kButtonUp) then
        moveBy = 10
    elseif playdate.buttonIsPressed(playdate.kButtonDown) then
        moveBy = -10
    end

    if instrSprites[1].y+moveBy < 100 and instrSprites[1].y+moveBy > (-maxScroll)+100 then
        for _,sprite in ipairs(instrSprites) do
            sprite:moveBy(0, moveBy)
        end
    end
end
