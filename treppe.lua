while true do
    while turtle.detect() do
        turtle.dig()
    end
    while turtle.detectUp() do
        turtle.digUp()
    end
    while turtle.detectDown() do
        turtle.digDown()
    end
    
    turtle.forward()

    while turtle.detect() do
        turtle.dig()
    end
    while turtle.detectUp() do
        turtle.digUp()
    end
    while turtle.detectDown() do
        turtle.digDown()
    end

    turtle.down()
end
