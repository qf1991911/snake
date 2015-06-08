local Scene1= class("Scene1", function ()
    return display.newScene("Scene1")
end)

function Scene1:ctor()
	local layer2 = cc.LayerColor:create(cc.c4b(100, 100, 100, 255))
		layer2:setContentSize(display.width, display.height)
		layer2:ignoreAnchorPointForPosition(false)
		layer2:setAnchorPoint(0.5, 0.5)
		layer2:align(display.CENTER, display.cx, display.cy)
		layer2:addTo(self)

	local num1 = display.sizeInPixels.width
	local num2 = display.sizeInPixels.height

	local spriteBorder = {}
		for i=1, display.width*3/64 do
			spriteBorder[i] = {}
			for j=1, display.height/16 do
				if ((i == 1 or i == 40) or (j == 1 or j == 40)) then
					spriteBorder[i][j] = display.newSprite("Border.png")
						:align(display.CENTER, i*16-8, j*16-8)
						:addTo(layer2)
				end 
			end
		end

	sorce = 0
	local sorceLabel = cc.ui.UILabel.new({
		UILableType = 2,
		text = sorce,
		size = 64,
		font = "Buxton Sketch"
		})
		:align(display.CENTER, display.right - 160, display.cy)
		:addTo(layer2)
		sorceLabel:setString("Sorce:" .. sorce)

	function newGame()
		local newGame = cc.ui.UIPushButton.new("Button02.png", {scale9 = true})
			:setButtonSize(240, 64)
			:setButtonLabel("normal", cc.ui.UILabel.new({
				UILabelType = 2,
				text = "Game Over",
				size = 48,
				font = "Buxton Sketch"
			}))
			:onButtonClicked(function(event) 
				MainScene = require("app.scenes.MainScene")
	    		display.replaceScene(MainScene:new(), "fade", 0.5, cc.c3b(50, 50, 50))
			end)
			:align(display.CENTER, display.cx, display.cy) 
			:addTo(layer2)
	end

	local n = 5
	local spriteSnake = {}
		for i=1, n do
			spriteSnake[i] = display.newSprite("snake.png")
				:align(display.CENTER, display.cx/3 - i*16 - 8, display.cy - 8)
				:addTo(layer2)
		end

	local lastsnakePosX, lastsnakePosY = spriteSnake[n]:getPosition()  
	function layer2:snakeMove(x, y)
		for i=n, 2, -1 do
			spriteSnake[i]:setPosition(spriteSnake[i-1]:getPosition())
		end
		local snakePosX1, snakePosY1 = spriteSnake[1]:getPosition()
		spriteSnake[1]:setPosition(snakePosX1 + 16*x, snakePosY1 + 16*y)
	end

	self:setKeypadEnabled(true)
	self:addNodeEventListener(cc.KEYPAD_EVENT, function(event)
		key = tonumber(event.key)
	end)

	function gameOver()
		local check = false
		local snakePosX1, snakePosY1 = spriteSnake[1]:getPosition()
		if (snakePosX1 == 8 or snakePosX1 == 632) or (snakePosY1 == 8 or snakePosY1 == 632) then
		 	check = true
		end 
		local snakeHead = cc.p(spriteSnake[1]:getPosition())
		for i=4, n do
			local snakeBody = cc.p(spriteSnake[i]:getPosition())
			if cc.pGetDistance(snakeBody, snakeHead) <= 8 then
				check = true
			end
		end
		return check
	end

	function randomsnake()
		math.randomseed(os.time())
		local xRandom = 1
		local yRandom = 1
		local check = true
		xRandom = math.random(2, 39)
		yRandom = math.random(2, 39)
		point = display.newSprite("point.png")
			:align(display.CENTER, xRandom*16-8, yRandom*16-8)
			:addTo(layer2)
	end	

	randomsnake()

	function snakeAdd()
		local check = false
		local snakeHead = cc.p(spriteSnake[1]:getPosition())
		local randomPoint = cc.p(point:getPosition())
		if cc.pGetDistance(randomPoint, snakeHead) <= 8 then
			check = true
		end
		return check
	end

	key = 26
	local function snakeCheck()
		local x1, y1 = spriteSnake[1]:getPosition()
		local x2, y2 = spriteSnake[2]:getPosition()
		if snakeAdd() then
			n = n + 1
			sorce = sorce + 1
			spriteSnake[n] = display.newSprite("snake.png")
				:align(display.CENTER, lastsnakePosX, lastsnakePosY )
				:addTo(layer2)
			local xRandom = math.random(2, 39)
			local yRandom = math.random(2, 39)
			point:setPosition(xRandom*16-8, yRandom*16-8)
			sorceLabel:setString("Sorce:" .. sorce)
		end
		if gameOver() then
			newGame()
			return
		end
		if (key == 28) then
			if (x1 ~= x2) or (y2 - y1 ~= 16) then
				layer2:snakeMove(0, 1)
			else
				layer2:snakeMove(0, -1)
			end
		elseif key == 29 then
			if (x1 ~= x2) or (y1 - y2 ~= 16) then
				layer2:snakeMove(0, -1)
			else
				layer2:snakeMove(0, 1)
			end
		elseif key == 26 then
			if (y1 ~= y2) or (x1 - x2 ~= 16) then
				layer2:snakeMove(-1, 0)
			else
				layer2:snakeMove(1, 0)
			end	
		elseif key == 27 then
			if (y1 ~= y2) or (x2 - x1 ~= 16) then
				layer2:snakeMove(1, 0)
			else
				layer2:snakeMove(-1, 0)
			end
		end
	end

	local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")
	scheduler.scheduleGlobal(snakeCheck, 0.05)


	-- local x = 0
	-- local y = 1
 -- 	local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")
 -- 		self:schedule(function ()
 -- 			layer2:snakeMove(x, y)
 -- 		end, 0.33)
	-- local upButton = cc.ui.UIPushButton.new("up.png", {scale9 = true})
	-- 	:align(display.CENTER, display.width / 2, 160)
	-- 	:addTo(layer2)
	-- 	:onButtonClicked(function (event)
	-- 		x = 0
	-- 		y = 1
	-- 	end)
	-- local downButton = cc.ui.UIPushButton.new("down.png", {scale9 = true})
	-- 	:align(display.CENTER, display.width / 2, 80)
	-- 	:addTo(layer2)
	-- 	:onButtonClicked(function (event)
	-- 		x = 0
	-- 		y = -1
	-- 	end)
	-- local leftButton = cc.ui.UIPushButton.new("left.png", {scale9 = true})
	-- 	:align(display.CENTER, display.width / 2 - 40, 120)
	-- 	:addTo(layer2)
	-- 	:onButtonClicked(function (event)
	-- 		x = -1
	-- 		y = 0
	-- 	end)
	-- local rightButton = cc.ui.UIPushButton.new("right.png", {scale9 = true})
	-- 	:align(display.CENTER, display.width / 2 + 40, 120)
	-- 	:addTo(layer2)
	-- 	:onButtonClicked(function (event)
	-- 		x = 1
	-- 		y = 0
	-- 	end)

end

function Scene1:onEnter()
end

function Scene1:onExit()
end

return Scene1