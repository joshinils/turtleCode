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
        error("could not move, probably out of fuel!")
    end
end
