local gfx <const> = playdate.graphics
local geo <const> = playdate.geometry

local returnState = gameState

local overlay = gfx.image.new(400,240, gfx.kColorWhite)
local overlaySprite = gfx.sprite.new(overlay)
overlaySprite:setCenter(0,0)

local instrTxt = gfx.image.new(400,10000, gfx.kColorWhite)
gfx.pushContext(instrTxt)
    gfx.setColor(gfx.kColorBlack)
    gfx.drawText([[
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam scelerisque, lacus ac feugiat accumsan, est massa dapibus tortor, et vestibulum dolor ante eget turpis. Curabitur ultrices aliquam felis sed lacinia. Sed feugiat felis eu facilisis dictum. Ut et fringilla ex. Donec congue condimentum neque, vitae condimentum lorem viverra sit amet. Sed at massa nec nibh condimentum volutpat. Suspendisse potenti. Nulla fermentum odio est, eget dictum lectus vestibulum bibendum. Sed vitae risus mollis, tempor velit ut, ornare libero. Aliquam nec tellus posuere, gravida orci suscipit, tincidunt augue. Sed semper, purus in hendrerit interdum, leo orci vehicula massa, ut pretium orci nibh ac odio. Sed ac pharetra odio, sed tincidunt velit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum non turpis at purus congue placerat et et mauris. Mauris volutpat efficitur odio.

Nunc non tellus porttitor, luctus elit et, dictum nisi. Proin pellentesque libero ac sollicitudin rutrum. Aenean et risus ac libero blandit porta. Mauris risus sem, ornare a ex nec, blandit malesuada risus. Praesent vitae nunc leo. Morbi non rhoncus nisl. Cras tristique urna ex, et hendrerit nisl sollicitudin feugiat. Aliquam in lorem nunc. Vestibulum felis lectus, venenatis sit amet diam quis, luctus luctus eros. Proin eget sapien aliquam, congue mi non, luctus urna. Nunc risus dui, imperdiet eu elit vel, feugiat lacinia lorem.

Nulla vitae neque elit. Curabitur eget odio eu leo pulvinar maximus. Sed vitae sollicitudin magna. Nunc mi purus, luctus quis tristique eget, auctor a sem. Duis lacinia faucibus ligula, at dapibus arcu egestas eu. Nulla eu sem cursus, ultrices lacus sed, ultrices massa. Vestibulum et quam in lacus tincidunt pulvinar nec eu ex. Nam varius eget erat vitae posuere. Vivamus vel lacus vehicula, egestas metus sed, suscipit elit. Suspendisse mollis ligula tortor, at eleifend arcu molestie cursus. In eu venenatis velit, non ultricies eros. Duis eu libero feugiat, varius quam fermentum, lacinia nulla. Aliquam lobortis sodales enim, vitae laoreet tellus. Duis ac nisi semper, vestibulum purus non, finibus tellus. Nam quis tristique leo, sed egestas tellus.

Aenean cursus blandit molestie. Proin molestie metus at eros laoreet, a consequat erat convallis. Donec sit amet lobortis diam, sit amet ultrices neque. Nullam eu leo faucibus, suscipit dolor sit amet, pellentesque ex. Nulla convallis ut nisl et faucibus. Mauris ut hendrerit orci. Donec sed leo ac erat tempor rhoncus a in diam. Duis nec nulla turpis. Ut non suscipit ex, et maximus diam. Nullam nunc sapien, pulvinar sed commodo ac, posuere in ligula. Fusce accumsan nisl vitae mauris auctor congue. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.

Nunc in varius eros, pharetra ultricies mi. Curabitur at turpis sed leo dapibus dapibus. Aenean luctus, diam sit amet porttitor pharetra, dui neque facilisis tortor, vel volutpat massa magna id dolor. Nam vel varius tellus. Etiam mattis massa at scelerisque interdum. Praesent nec malesuada enim. Nam vel nisl a nisl hendrerit malesuada non eu justo. Phasellus fermentum ipsum enim, eget maximus sapien consequat vel. Integer blandit quam vitae accumsan ultrices. Quisque eu cursus est, id posuere quam. ]], 10, 10, 380, 10000)
gfx.popContext()
local instrSprite = gfx.sprite.new(instrTxt)
instrSprite:setCenter(0,0)
function instructionsInit()
    overlaySprite:add()
    instrSprite:add()
    instrSprite:moveTo(0,0)
    returnState = gameState
    gameState = "instructions"
end

function instructionsUpdate()
    if playdate.buttonJustPressed(playdate.kButtonB) then
        instrSprite:remove()
        overlaySprite:remove()
        gameState = returnState
    end
    instrSprite:moveTo(0, instrSprite.y - playdate.getCrankChange())
end
