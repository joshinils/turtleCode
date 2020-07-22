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
    return
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
os.loadAPI("funcs.lua")

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
    digDown()
    s = turtle.inspectDown()
    if s then return end
    
    -- if below is free dispose of junk
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
                turtle.select(i)
                turtle.dropDown()
            end
        end
    end
    if bEnderJunkDeployed then
        turtle.select(enderJunkSlot)
        turtle.digDown()
    end
end

bannedBlocks = {
    "minecraft:mob_spawner",
    "minecraft:bedrock"
}

-- returns wether forward is now air
function digForward()
    s, d = turtle.inspect()
    if not s then return true end
    for _, blockName in ipairs(bannedBlocks) do
        if d.name == blockName then return false end
    end
    dig.dig()
    return true
end

-- returns wether up is now air
function digUp()
    s, d = turtle.inspectUp()
    if not s then return true end
    for _, blockName in ipairs(bannedBlocks) do
        if d.name == blockName then return false end
    end
    dig.up()
    return true
end

-- returns wether down is now air
function digDown()
    s, d = turtle.inspectDown()
    if not s then return true end
    for _, blockName in ipairs(bannedBlocks) do
        if d.name == blockName then return false end
    end
    dig.down()
    return true
end

function digLayerSingle(above, below)
    if above and above == true then digUp() end
    if below and below == true then digDown() end
end

-- always digs at layer where the turtle is
function digLayer(above, below)
    --print("above" .. tostring(above) .. " below" .. tostring(below))
    above = above == true or false
    below = below == true or false
    --print("above" .. tostring(above) .. " below" .. tostring(below))
    for width = 1, chunkWidthRight do
        for depth = 1, chunkDepthFront do
            print("w" .. width .. " d" .. depth)

            digLayerSingle(above, below)
            if depth < chunkDepthFront then
                if not digForward() then
                    error("cant move forward, something is blocking my way!")
                end
                funcs.turtleForward()
            else
                digLayerSingle(above, below)
            end
        end
        --print("width=" .. width .. " " .. tostring((width % 2) == 0) )

        if width < chunkWidthRight then
            if width % 2 == 0 then
                turtle.turnLeft()
            else
                turtle.turnRight()
            end
            digForward()
            funcs.turtleForward()
            digLayerSingle(above, below)

            if width % 2 == 0 then
                turtle.turnLeft()
            else
                turtle.turnRight()
            end
        else
            if width % 2 == 0 then
                turtle.turnRight()
            else
                turtle.turnLeft()
            end
        end
        junkDisposal()
        refuel()
    end
end

-- startup checks
isEnderChest(enderFuelSlot)
isEnderChest(enderJunkSlot)
refuel()
junkDisposal()


print("HeightDown=" .. chunkHeightDown ..
      " WidthRight=" .. chunkWidthRight ..
      " DepthFront=" .. chunkDepthFront)
remainingHeight = chunkHeightDown
if chunkHeightDown == 1 then
    digLayer()
    return
end
if chunkHeightDown == 2 then
    digLayer(true)
    return
end
for height = 3, chunkHeightDown, 3 do
    print("inner pre  remainingHeight " .. remainingHeight)
    remainingHeight = remainingHeight -3
    print("inner post remainingHeight " .. remainingHeight)
    digLayer(true, true)
end
print("remainingHeight " .. remainingHeight)

