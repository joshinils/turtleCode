os.loadAPI("dig.lua")

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
        if turtle.getFuelLevel() == 0 then
            error("could not move forward, probably out of fuel!")
        end
        return false
    end
    return true
end

function turtleUp()
    refuel()
    if not turtle.up() then
        if turtle.getFuelLevel() == 0 then
            error("could not move up, probably out of fuel!")
        end
        return false
    end
    return true
end

function turtleDown()
    refuel()
    if not turtle.down() then
        if turtle.getFuelLevel() == 0 then
            error("could not move down, probably out of fuel!")
        end
        return false
    end
    return true
end
