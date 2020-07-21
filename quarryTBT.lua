-- usage
local args = {...}
if #args == 0 then
    print( "Usage:" )
    print( "  quarry <widthRight> " )
    print( "         [depthFront]{0}" )
    print( "         [heightDown]{0}" )
    print( "  first  slot is for fuel," )
    print( "  second slot is for enderFuel," )
    print( "  third  slot is for enderJunk" )
end

chunkWidthRight = 0 -- includes turtles position, going to its right
chunkDepthFront = 0 -- includes turtles position, going to its front
chunkHeightDown = 0 -- includes turtles position, going below it, and one above it

-- parse arguments
if #args > 0 then
    chunkWidthRight = tonumber(args[1])
    if chunkWidthRight <= 0 then
        error("first argument \"chunkWidthRight\" == " .. chunkWidthRight .. " is not greater than 0")
    end
end
if #args > 1 then
    chunkDepthFront = tonumber(args[2])
    if chunkDepthFront < 0 then
        error("first argument \"chunkDepthFront\" == " .. chunkDepthFront .. " may not be negative")
    end
end
if #args > 2 then
    chunkHeightDown = tonumber(args[3])
    if chunkHeightDown < 0 then
        error("first argument \"chunkHeightDown\" == " .. chunkHeightDown .. " may not be negative")
    end
end

os.loadAPI("tableUtil.lua")
-- define slots
fuelSlot = 1
enderFuelSlot = 2
enderJunkSlot = 3

function isEnderChest(slot)
    if slot <= 0 or slot > 16 then 
        error("out of range slot " .. slot) 
    end
    data = turtle.getItemDetail(slot)
    if not data or data.name ~= "enderstorage:ender_chest" then
        error("slot " .. slot .. " is not an ender chest")
    end
end

function makeBelowFree()
    s, d = turtle.inspectDown()
    if s and d and d.name ~= "enderstorage:ender_chest" then
        turtle.digDown()
    elseif d and d.name == "enderstorage:ender_chest" then
        error("found enderchest below when not expecting one there")
    end
end

function refuel()
    -- is a refuel necessary?
    if turtle.getFuelLevel() > 100 then
        return
    end

    -- attempt to refuel
    turtle.refuel(fuelSlot)
    if turtle.getFuelLevel() > 100 then
        return
    end

    -- get more charcoal from enderchest
    dataFuel = turtle.getItemDetail(fuelSlot)
    if dataFuel and dataFuel.name ~= "minecraft:charcoal" then
        -- remove anything in the fuel slot
        isEnderChest(enderJunkSlot)
        turtle.select(enderJunkSlot)
        
        -- make sure below is free
        makeBelowFree()

        turtle.placeDown()
        turtle.select(fuelSlot)
        turtle.dropDown()
        turtle.select(enderJunkSlot)
        turtle.digDown()
    end

    -- get more coal
    if turtle.getItemCount(fuelSlot) == 0 then
        makeBelowFree()
        isEnderChest(enderFuelSlot)
        turtle.select(enderFuelSlot)
        turtle.placeDown()
        turtle.select(fuelSlot)
        turtle.suckDown()
        turtle.select(enderFuelSlot)
        turtle.digDown()
    end
end

function junkDisposal()
    bEnderJunkDeployed = false
    for i = 1, 16 do
        if i == fuelSlot or i == enderFuelSlot or i == enderJunkSlot then
            -- continue
        else
            if turtle.getItemCount(i) > 0 then
                if not bEnderJunkDeployed then
                    bEnderJunkDeployed = true
                    makeBelowFree()
                    isEnderChest(enderJunkSlot)
                    turtle.select(enderJunkSlot)
                    turtle.placeDown()
                end
            end
        end
    end
    if bEnderJunkDeployed then
        turtle.select(enderJunkSlot)
        turtle.digDown()
    end
end

-- startup checks
--isEnderChest(enderFuelSlot)
--isEnderChest(enderJunkSlot)
refuel()
junkDisposal()
