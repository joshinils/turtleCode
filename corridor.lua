corridorHeight = 10
corridorWidth = 10

-- first argument is not the name, buit the first actual argument
if #arg > 0 then
    corridorHeight = tonumber(arg[1])
    corridorWidth = tonumber(arg[1])
end
if #arg > 1 then
   corridorHeight = tonumber(arg[2])
end

term.write("Removing " ..
 arg[1] .. "x" .. arg[2] ..
 " corridor array")

function moveForward()
    blockInFront, q = turtle.inspect()
    while blockInFront do
        turtle.dig()
        blockInFront, q = turtle.inspect()
    end
    turtle.forward()
end

for i=1,tonumber(corridorWidth) do
    for j = 1, tonumber(corridorHeight)-1 do
        turtle.digUp()
        turtle.digDown()
        moveForward()
        turtle.digUp()
        turtle.digDown()
    end
    if(i%2 == 0) then
        turtle.turnLeft()
    else
        turtle.turnRight()
    end
    if(i < tonumber(corridorWidth)) then
        moveForward()
        turtle.digUp()
        turtle.digDown()
        if(i%2 == 0) then
            turtle.turnLeft()
        else
            turtle.turnRight()
        end
    end
    if turtle.getFuelLevel() == 0 then
        turtle.refuel()
    end
end
print("")
print("Done.")
