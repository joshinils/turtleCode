print("pulling new files")

shell.run("rom/programs/delete.lua","treppe.lua")
shell.run("rom/programs/http/wget.lua","https://raw.githubusercontent.com/joshinils/turtleCode/master/treppe.lua")

print("Your branch is up to date with 'origin/master'.")
