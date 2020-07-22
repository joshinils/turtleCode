os.loadAPI("funcs.lua")

function refuel()
    if turtle.getFuelLevel() < 10 then
        turtle.select(1)
        turtle.refuel(1)
    end
end

function turtleForward()
    refuel()
    if not turtle.forward() then
        s, d = turtle.inspect()
        if d.name == "minecraft:spruce_leaves" then
            dig.dig()
            turtle.forward()
            return true
        end
        if turtle.getFuelLevel() == 0 then
            error("could not move, probably out of fuel!")
        end
        return false
    end
    return true
end


function plantSapling()
    saplingSlot = 0
    for slotNum = 1, 16 do --find slot with seeds
        data = turtle.getItemDetail(slotNum)
        if data and data.name == "minecraft:spruce_sapling" then
            saplingSlot = slotNum
            break
        end
    end
    if saplingSlot > 0 then
        turtle.select(saplingSlot)
        turtle.place()
    end
end

function chopTree()
    for i = 1, 9 do
        s, d = turtle.inspect()
        if   d.name == "minecraft:spruce_log" 
          or d.name == "minecraft:oak_sapling" then
            dig.up()
            dig.dig()
            funcs.turtleUp()
        else
            break
        end
    end
    while not turtle.inspectDown() do 
        funcs.turtleDown()
    end
end

function harvestTree()
    chopTree()
    plantSapling()
end

function dropDrops()
    turtle.select(1)
    data = turtle.getItemDetail()
    if data and data.name ~= "minecraft:charcoal" then
        turtle.dropDown()
    end
    for slotNum = 2, 16 do
        turtle.select(slotNum)
        data = turtle.getItemDetail(slotNum)
        if data and data.name ~= "minecraft:spruce_sapling" then
            turtle.dropDown()
        end
    end
end

function dropSaplings()
    for slotNum = 1, 16 do
        turtle.select(slotNum)
        data = turtle.getItemDetail(slotNum)
        if data and data.name == "minecraft:spruce_sapling" then
            turtle.dropDown()
        end
    end
    turtle.select(2)
    turtle.suckDown()
end


---------------- begin program ----------------


success, data = turtle.inspectDown()
if success ~= true or data.name ~= "enderstorage:ender_chest" then
    error("invalid starting position! place me on a chest")
end
funcs.pickupFuel()
turtleForward()

while true do
    -- move to next place with something below
    success, data = turtle.inspectDown()
    if not success then
        success = turtleForward()
        if not success then
            turtle.turnRight()
            success = turtle.inspect()
            if success then 
                turtle.turnLeft()
                turtle.turnLeft()
            end
        end
    else --found something below
        if data.name == "minecraft:wall_torch" then
            turtle.turnLeft()
            harvestTree()
            turtle.turnRight()
            turtleForward()
        elseif data.name == "enderstorage:ender_chest" then
            dropDrops()
            turtleForward()
            dropSaplings()
            turtleForward()
            funcs.pickupFuel()
            turtle.turnLeft()
            turtleForward()
        end
    end
end
