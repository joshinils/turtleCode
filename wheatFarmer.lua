os.loadAPI("dig.lua")

success, data = turtle.inspectDown()
if success ~= true or data.name ~= "minecraft:chest" then
    error("invalid starting position! place me on a chest")
end

function plantSeed()
    saplingSlot = 0
    for slotNum = 1, 16 do --find slot with seeds
        data = turtle.getItemDetail(slotNum)
        if data and data.name == "minecraft:wheat_seeds" then
            saplingSlot = slotNum
            break
        end
    end
    turtle.select(saplingSlot)
    turtle.placeDown()
end

function harvest()
    success, data = turtle.inspectDown()
    if success then
    -- test if wheat is grown fully
        if data.state.age == 7 then
            dig.down()
            plantSeed()
        end
    else -- no plant below 
        plantSeed()
    end
end

function harvestRow()
    for i=1,15 do
        harvest()
        turtleForward()
    end
end

function dropCrops()
    turtle.select(1)
    data = turtle.getItemDetail()
    if data and data.name == "minecraft:wheat" then
        turtle.dropDown()
    end
    turtle.select(2)
    data = turtle.getItemDetail()
    if data and data.name ~= "minecraft:wheat_seeds" then
        turtle.dropDown()
    end
    for slotNum = 3, 16 do
        turtle.select(slotNum)
        data = turtle.getItemDetail(slotNum)
        if data and data.name == "minecraft:wheat_seeds" then
            turtle.transferTo(2)
        end
        turtle.dropDown()
    end
end

function pickupFuel()
    turtle.select(1)
    turtle.suckDown(turtle.getItemSpace(1))
end

function refuel()
    if turtle.getFuelLevel() < 10 then
        turtle.select(1)
        turtle.refuel(1)
    end
end

function turtleForward()
    refuel()
    if not turtle.forward() then
        error("could not move, probably out of fuel!")
    end
end

while true do
    pickupFuel()
    turtleForward()

    harvestRow()
    turtle.turnRight()
    turtleForward()
    turtle.turnRight()

    harvestRow()
    turtle.turnLeft()
    turtleForward()
    turtle.turnLeft()

    harvestRow()
    turtle.turnRight()
    turtleForward()
    turtle.turnRight()

    harvestRow()
    turtleForward()
    dropCrops()

    turtle.turnRight()
    turtleForward()
    turtleForward()
    turtleForward()
    turtle.turnRight()
end
