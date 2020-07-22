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

shell.run("trace quarryTBT.lua " .. chunkWidthRight .. " " .. chunkDepthFront .. " " .. chunkHeightDown)
