import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"
import "tileImages"

local gfx <const> = playdate.graphics
function tileImages()
    local font = gfx.font.new("fonts/Pedallica/font-pedallica")
    
    local images = gfx.imagetable.new(10)
    
    local empty = gfx.image.new(18, 18, gfx.kColorClear)
    gfx.pushContext(empty)
        gfx.setColor(gfx.kColorBlack)
        gfx.drawRect(0, 0, 18,18)
    gfx.popContext()
    images:setImage(1, empty)
    
    local ship = gfx.image.new(18, 18)
    gfx.pushContext(ship)
        gfx.setColor(gfx.kColorBlack)
        gfx.fillRect(2, 2, 14,14)
        gfx.drawRect(0, 0, 18,18)
    gfx.popContext()
    images:setImage(2, ship)

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
    
    local decoy = gfx.image.new(18, 18)
    gfx.pushContext(decoy)
        font:drawText("D",4,2)
        gfx.setColor(gfx.kColorBlack)
        gfx.drawRect(0, 0, 18,18)
    gfx.popContext()
    images:setImage(5, decoy)

    local mermaidHit = gfx.image.new(18, 18, gfx.kColorBlack)
    gfx.pushContext(mermaidHit)
        gfx.setImageDrawMode( gfx.kDrawModeFillWhite );
        font:drawText("M",4,2)
    gfx.popContext()
    images:setImage(6, mermaidHit)

    local crabHit = gfx.image.new(18, 18, gfx.kColorBlack)
    gfx.pushContext(crabHit)
        gfx.setImageDrawMode( gfx.kDrawModeFillWhite );
        font:drawText("C",4,2)
    gfx.popContext()
    images:setImage(7, crabHit)

    local sealHit = gfx.image.new(18, 18, gfx.kColorBlack)
    gfx.pushContext(sealHit)
        gfx.setImageDrawMode( gfx.kDrawModeFillWhite );
        font:drawText("S",4,2)
    gfx.popContext()
    images:setImage(8, sealHit)

    local garbageHit = gfx.image.new(18, 18, gfx.kColorBlack)
    gfx.pushContext(garbageHit)
        gfx.setImageDrawMode( gfx.kDrawModeFillWhite );
        font:drawText("G",4,2)
    gfx.popContext()
    images:setImage(9, garbageHit)

    local blowfishHit = gfx.image.new(18, 18, gfx.kColorBlack)
    gfx.pushContext(blowfishHit)
        gfx.setImageDrawMode( gfx.kDrawModeFillWhite );
        font:drawText("B",4,2)
    gfx.popContext()
    images:setImage(10, blowfishHit)

    return images
end
