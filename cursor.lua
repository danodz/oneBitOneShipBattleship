import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

local gfx <const> = playdate.graphics
local geo <const> = playdate.geometry

local cursorImg = gfx.image.new(22, 22, gfx.kColorBlack)
gfx.pushContext(cursorImg)
    gfx.setColor(gfx.kColorWhite)
    gfx.fillCircleAtPoint(11,11,9)
gfx.popContext()
local cursor = {
    x=1,
    y=1,
    sprite= gfx.sprite.new(cursorImg)
}
cursor.sprite:add()

function cursorUpdate()
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
        (cursor.x-1)*18+cursor.sprite.width-3,
        (cursor.y-1)*18+cursor.sprite.height-3
    )
end
