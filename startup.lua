shell.run("rom/programs/delete.lua","gitPull.lua")
shell.run("rom/programs/http/wget.lua","https://raw.githubusercontent.com/joshinils/turtleCode/master/gitPull.lua")
shell.run("gitPull.lua")

print("attempting to call startupCustom.lua")
shell.run("startupCustom.lua")
