function up()
    while turtle.detectUp() do
        turtle.digUp()
    end
end

function down()
    while turtle.detectDown() do
        turtle.digDown()
    end
end

function dig()
    while turtle.detect() do
        turtle.dig()
    end
end
