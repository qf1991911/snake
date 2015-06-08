
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
	local layer1 = cc.LayerColor:create(cc.c4b(50, 50, 50, 255))
		layer1:setContentSize(display.width, display.height)
		layer1:ignoreAnchorPointForPosition(false)
		layer1:setAnchorPoint(0.5, 0.5)
		layer1:align(display.CENTER, display.width / 2, display.height / 2)
		layer1:addTo(self)

 	local backGroundPicture = display.newSprite("backGroundPicture.png")
		:center()
		:addTo(layer1, 1)

	local gameName = cc.ui.UILabel.new({
		UILabelType = 2,
		text = "Snacks",
		size = 128,
		font = "Matura MT Script Capitals"
		})
		:align(display.CENTER, display.cx, display.cy * 1.6)
		:addTo(layer1, 2)

    local gameStart = cc.ui.UIPushButton.new("Button01.png", {scale9 = true})
    	:setButtonSize(192, 64)
    	:setButtonLabel("normal", cc.ui.UILabel.new({
    		UILabelType = 2,
    		text = "Play",
    		size = 64,
    		font = "Buxton Sketch",
    		color = cc.c3b(255, 255, 255)
    		}))
    	:onButtonClicked(function (event)
    		Scene1 = require("app.scenes.Scene1")
    		display.replaceScene(Scene1:new(), "fade", 0.5, cc.c3b(50, 50, 50))
    		print("PushButton Pressed")
    	end)
    	:align(display.CENTER, display.right * 7 / 8, display.cy * 1.4)
    	:addTo(layer1, 2)




end

function MainScene:onEnter()
end

function MainScene:onExit()
end

return MainScene
