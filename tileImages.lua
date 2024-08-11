import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"
import "tileImages"

local gfx <const> = playdate.graphics
local geo <const> = playdate.geometry
function tileImages()
    local font = gfx.font.new("fonts/Pedallica/font-pedallica")
    
    local images = gfx.imagetable.new(8)
    
    local empty = gfx.image.new(18, 18, gfx.kColorClear)
    gfx.pushContext(empty)
        gfx.setColor(gfx.kColorBlack)
        gfx.drawRect(0, 0, 18,18)
    gfx.popContext()
    images:setImage(1, empty)
    
    local boat = gfx.image.new(18, 18)
    gfx.pushContext(boat)
        gfx.setColor(gfx.kColorBlack)
        gfx.fillRect(2, 2, 14,14)
        gfx.drawRect(0, 0, 18,18)
    gfx.popContext()
    images:setImage(2, boat)

    local hit = gfx.image.new(18, 18, gfx.kColorClear)
    gfx.pushContext(hit)
        gfx.setColor(gfx.kColorBlack)
        gfx.drawLine(0, 0, 18,18)
        gfx.drawLine(18, 0, 0,18)
        gfx.drawRect(0, 0, 18,18)
    gfx.popContext()
    images:setImage(3, hit)

    local miss = gfx.image.new(18, 18, gfx.kColorClear)
    gfx.pushContext(miss)
        gfx.setColor(gfx.kColorBlack)
        gfx.drawCircleAtPoint(9,9,8)
        gfx.drawCircleAtPoint(9,9,6)
        gfx.drawCircleAtPoint(9,9,3)
        gfx.drawRect(0, 0, 18,18)
    gfx.popContext()
    images:setImage(4, miss)
    
    local mermaid = gfx.image.new(18, 18)
    gfx.pushContext(mermaid)
        font:drawText("M",4,2)
        gfx.setColor(gfx.kColorBlack)
        gfx.drawRect(0, 0, 18,18)
    gfx.popContext()
    images:setImage(5, mermaid)

    local mermaidHit = gfx.image.new(18, 18, gfx.kColorBlack)
    gfx.pushContext(mermaidHit)
        gfx.setImageDrawMode( gfx.kDrawModeFillWhite );
        font:drawText("M",4,2)
    gfx.popContext()
    images:setImage(6, mermaidHit)

    local crab = gfx.image.new(180, 180)
    gfx.pushContext(crab)
        font:drawText("C",4,2)
        gfx.setColor(gfx.kColorBlack)
        gfx.drawRect(0, 0, 18,18)
    gfx.popContext()
    images:setImage(7, crab)

    local crabHit = gfx.image.new(18, 18, gfx.kColorBlack)
    gfx.pushContext(crabHit)
        gfx.setImageDrawMode( gfx.kDrawModeFillWhite );
        font:drawText("C",4,2)
    gfx.popContext()
    images:setImage(8, crabHit)

    return images
end
