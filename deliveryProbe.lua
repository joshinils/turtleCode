# direction 1 == up

direction = tonumber(arg[1]) == 1


function grabAll()
    while turtle.suck() do
    end
end

function dropAll()
    while turtle.drop() do
    end
end

function walkStairs()
    blockInFront, q = turtle.inspect()
    if not blockInFront then
        turtle.forward()
    else
        if q.name ~= "minecraft:chest" then
            if direction then
                turtle.up()
            else
                turtle.down()
            end
        else
            direction = not direction
            return false
        end
    end
    return true
end

while true do
    if direction then
        grabAll()        
    else
        dropAll()
    end
    turtle.forward()
    turtle.down()

    while walkStairs() do
        print("Step")
        if turtle.getFuelLevel() == 0 then
            turtle.refuel()
        end
    end
    turtle.up()
    turtle.forward()
    turtle.turnLeft()
    turtle.turnLeft()

end

