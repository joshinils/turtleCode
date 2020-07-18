print("pulling new files")

print("\n")

shell.run("rom/programs/delete.lua","treppe.lua")
shell.run("rom/programs/http/wget.lua","https://raw.githubusercontent.com/joshinils/turtleCode/master/treppe.lua")

print("\n")
shell.run("rom/programs/ls.lua")

