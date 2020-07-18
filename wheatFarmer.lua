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

turtle.move()
for i=1,16 do
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
    turtle.move()
end
