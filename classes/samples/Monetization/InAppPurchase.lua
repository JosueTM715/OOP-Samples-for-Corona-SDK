require "classes.constants.screen"

InAppPurchase={}

function InAppPurchase:new()
    local this = display.newGroup()
    local public = this
    local private = {}
    local widget = require("widget")
    local store = require("plugin.google.iap.v3")
    local background = display.newImageRect("img/backgroundMonetization.png", 360, 570)
    local eyes = display.newImageRect("img/eyes.png", 255, 180)
    local buttonSmallCoffee = widget.newButton({
        id = "buttonSmallCoffee",
        x = screen.centerX - 108,
        y = screen.centerY + 122,
        width = 101,
        height = 198,
        defaultFile = "img/buttonCoffeeSmallDefault.png",
        overFile = "img/buttonCoffeeSmallPressed.png",
        onRelease = function(event)
            if event.phase == "ended" then
                private.onButtonSmallCoffee(event)
            end
        end
    })
    local buttonStrongCoffee = widget.newButton({
        id = "buttonStrongCoffee",
        x = screen.centerX-1,
        y = screen.centerY + 122,
        width = 101,
        height = 198,
        defaultFile = "img/buttonCoffeeStrongDefault.png",
        overFile = "img/buttonCoffeeStrongPressed.png",
        onRelease = function(event)
            if event.phase == "ended" then
                private.onButtonStrongCoffee(event)
            end
        end
    })
    local buttonNightCoffee = widget.newButton({
        id = "buttonNightCoffee",
        x = screen.centerX + 105,
        y = screen.centerY + 122,
        width = 101,
        height = 198,
        defaultFile = "img/buttonCoffeeNightDefault.png",
        overFile = "img/buttonCoffeeNightPressed.png",
        onRelease = function(event)
            if event.phase == "ended" then
                private.onButtonAllNightCoffee(event)
            end
        end
    })
    local googleIAPv3 = false
    local platform = system.getInfo("platformName")
    local currentProductList = nil


    function private.InAppPurchase()

        background.x = screen.centerX
        background.y = screen.centerY

        eyes.x = screen.centerX
        eyes.y = screen.centerY-86


        this:insert(background)
        this:insert(eyes)
        this:insert(buttonSmallCoffee)
        this:insert(buttonStrongCoffee)
        this:insert(buttonNightCoffee)

        store.init( "google", private.transactionCallback )
    end

    function private.transactionCallback(event)
        local productID = event.transaction.productIdentifier

        if event.transaction.state == "purchased" then
            print("Product Purchased: ", productID)
            if productID == "com.yourcompany.coffeesmall" then
                timer.performWithDelay(1000, function() store.consumePurchase( "com.yourcompany.coffeesmall", private.transactionCallback) end )
            elseif productID == "com.yourcompany.coffeestrong" then
                timer.performWithDelay(1000, function() store.consumePurchase( "com.yourcompany.coffeestrong", private.transactionCallback) end )
            elseif productID == "com.yourcompany.coffeeallnight" then
                timer.performWithDelay(1000, function() store.consumePurchase( "com.yourcompany.coffeeallnight", private.transactionCallback) end )
            end

        elseif  event.transaction.state == "restored" then

        elseif  event.transaction.state == "refunded" then

        elseif event.transaction.state == "cancelled" then

        elseif event.transaction.state == "failed" then

        else

        end

        store.finishTransaction(event.transaction) --Tell the store we are done with the transaction. If you are providing downloadable content, do not call this until the download has completed.
    end

    function private.onButtonSmallCoffee(event)
        store.purchase("com.yourcompany.coffeesmall")
    end

    function private.onButtonStrongCoffee(event)
        store.purchase("com.yourcompany.coffeestrong")
    end

    function private.onButtonAllNightCoffee(event)
        store.purchase("com.yourcompany.coffeeallnight")
    end

    function public:destroy()
        background:removeSelf()
        background = nil

        eyes:removeSelf()
        eyes = nil

        buttonSmallCoffee:removeSelf()
        buttonSmallCoffee = nil

        buttonStrongCoffee:removeSelf()
        buttonStrongCoffee = nil

        buttonNightCoffee:removeSelf()
        buttonNightCoffee = nil

        this:removeSelf()
        this = nil
    end

    private.InAppPurchase()
    return this
end
return InAppPurchase
