-- Function to edit or delete a route
function editDeleteRoute(routingTable, source, destination, item, amount, delete)
  local updatedRoutingTable = {}

  -- Find and edit or delete the specified route
  for i, route in ipairs(routingTable) do
    if not (route.source == source and route.destination == destination and route.item == item and route.amount == amount) then
      table.insert(updatedRoutingTable, route)
    end
  end

  -- If the "delete" flag is set, we don't update the routing table
  if not delete then
    table.insert(updatedRoutingTable, {
      source = source,
      destination = destination,
      item = item,
      amount = amount
    })
  end

  return updatedRoutingTable
end

-- Function to display a numbered list of routes
function displayRoutes(routingTable)
  term.clear()
  term.setCursorPos(1, 1)
  print("Select a route to edit or delete:")

  for i, route in ipairs(routingTable) do
    print(i .. ". Source: " .. route.source .. " | Destination: " .. route.destination .. " | Item: " .. route.item .. " | Amount: " .. route.amount)
  end
end

-- Main program
local routingTable = {}

-- Read the routing table from a file
if fs.exists("routing_table") then
  local file = fs.open("routing_table", "r")
  local contents = file.readAll()
  routingTable = textutils.unserialize(contents)
  file.close()
end

-- Display the list of routes
displayRoutes(routingTable)

-- Get the user's selection
local selectedRoute = tonumber(read())
if selectedRoute and selectedRoute >= 1 and selectedRoute <= #routingTable then
  -- Select the route to edit or delete
  local routeToEditDelete = routingTable[selectedRoute]

  -- Specify whether you want to edit (false) or delete (true)
  local delete = false

  term.clear()
  term.setCursorPos(1, 1)
  print("Enter the item you want to edit or delete:")
  local item = read()
  print("Enter the amount you want to edit or delete:")
  local amount = tonumber(read())

  -- Edit or delete the selected route
  routingTable = editDeleteRoute(routingTable, routeToEditDelete.source, routeToEditDelete.destination, item, amount, delete)

  -- Save the updated routing table to a file
  local file = fs.open("routing_table", "w")
  file.write(textutils.serialize(routingTable))
  file.close()

  print("Route updated.")
  sleep(2)
end
