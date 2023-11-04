-- Function to run "execute_routes.lua" in the background
function runExecuteRoutesInBackground()
  shell.openTab("MESYS/execute_routes.lua")
  print("Executing Routes in Background.")
  sleep(2)
end

-- Main program
while true do
  runExecuteRoutesInBackground()
  term.clear()
  term.setCursorPos(1, 1)
  print("Select a script to run:")
  print("1. Create Route")
  print("2. Edit/Delete Route")
  print("0. Exit")
  print("Enter the number of your choice:")
  local choice = tonumber(read())

  if choice == 0 then
    print("Exiting Script Selector.")
    break
  elseif choice == 1 then
    shell.run("MESYS/create_route.lua")
  elseif choice == 2 then
    shell.run("MESYS/edit_delete_route.lua")
  else
    print("Invalid selection. Please enter a valid script number or '0' to exit.")
    sleep(2)
  end
end
