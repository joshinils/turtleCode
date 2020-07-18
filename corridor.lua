os.loadAPI("dig.lua")
for i=1,100 do
    for j = 1, 100 do
        dig.up()
        dig.dig()
        dig.down()
        turtle.forward()
    end
    if(i%2 == 0) then
        turtle.turnLeft()
    else
        turtle.turnRight()
    end
    turtle.dig()
    turtle.forward()
    if(i%2 == 0) then
        turtle.turnLeft()
    else
        turtle.turnRight()
    end
    if turtle.getFuelLevel() == 0 then
        turtle.select(0)
        turtle.refuel()
    end
end
