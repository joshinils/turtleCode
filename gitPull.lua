print("pulling new files")

shell.run("rom/programs/delete.lua","treppe.lua")
shell.run("rom/programs/http/wget.lua","https://raw.githubusercontent.com/joshinils/turtleCode/master/treppe.lua")
shell.run("rom/programs/delete.lua","startup.lua")
shell.run("rom/programs/http/wget.lua","https://raw.githubusercontent.com/joshinils/turtleCode/master/startup.lua")

shell.run("rom/programs/delete.lua","dig.lua")
shell.run("rom/programs/http/wget.lua","https://raw.githubusercontent.com/joshinils/turtleCode/master/dig.lua")

shell.run("rom/programs/delete.lua","wheatFarmer.lua")
shell.run("rom/programs/http/wget.lua","https://raw.githubusercontent.com/joshinils/turtleCode/master/wheatFarmer.lua")

print("Your branch is up to date with 'origin/master'.")
