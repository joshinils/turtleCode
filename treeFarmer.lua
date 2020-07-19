os.loadAPI("funcs.lua")

success, data = turtle.inspectDown()
if success ~= true or data.name ~= "minecraft:chest" then
    error("invalid starting position! place me on a chest")
end

function plantSapling()
    saplingSlot = 0
    for slotNum = 1, 16 do --find slot with seeds
        data = turtle.getItemDetail(slotNum)
        if data and data.name == "minecraft:oak_sapling" then
            saplingSlot = slotNum
            break
        end
    end
    if saplingSlot > 0 then
        turtle.select(saplingSlot)
        turtle.placeDown()
    end
end

function chopTree()
    for i = 1, 9 do
        s, d = inspect()
        if d.name == "minecraft:oak_log" then
            dig.up()
            dig.dig()
            turtle.up()
        else
            break
        end
    end
    while not turtle.inspectDown() do 
        turtle.down()
    end
end

function harvestTree()
    success, data = turtle.inspect()
    if not success then
        plantSapling()
    else
        chopTree()
    end
end

while true do
    -- move to next place with sdomething below
    success, data = turtle.inspectDown()
    if not success then
        success = funcs.turtleForward()
        if not success then
            turtle.turnRight()
            success = turtle.inspect()
            if not success then 
                turtle.turnLeft()
                turtle.turnLeft()
            end
        end
    else --found something below
        if data.name == "minecraft:wall_torch" then
            turtle.turnLeft()
            harvestTree()
            turtle.turnRight()
        end
    end
end
