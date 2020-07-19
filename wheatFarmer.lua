os.loadAPI("funcs.lua")

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
    if saplingSlot > 0 then
        turtle.select(saplingSlot)
        turtle.placeDown()
    end
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
        funcs.turtleForward()
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

while true do
    funcs.pickupFuel()
    funcs.turtleForward()

    harvestRow()
    turtle.turnRight()
    funcs.turtleForward()
    harvest()
    turtle.turnRight()

    harvestRow()
    turtle.turnLeft()
    funcs.turtleForward()
    harvest()
    turtle.turnLeft()

    harvestRow()
    turtle.turnRight()
    funcs.turtleForward()
    harvest()
    turtle.turnRight()

    harvestRow()
    funcs.turtleForward()
    dropCrops()

    turtle.turnRight()
    funcs.turtleForward()
    funcs.turtleForward()
    funcs.turtleForward()
    turtle.turnRight()
end
