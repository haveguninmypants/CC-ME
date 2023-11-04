-- Function to create a route and save it to a file
function createRoute(source, destination, item, amount)
  local routingTable = {}

  -- Check if the routing table file already exists
  if fs.exists("routing_table") then
    local file = fs.open("routing_table", "r")
    local contents = file.readAll()
    routingTable = textutils.unserialize(contents)
    file.close()
  end

  table.insert(routingTable, {
    source = source,
    destination = destination,
    item = item,
    amount = amount
  })

  -- Save the updated routing table to a file
  local file = fs.open("routing_table", "w")
  file.write(textutils.serialize(routingTable))
  file.close()
end

-- Function to select a source and destination inventory
function selectInventory()
  term.clear()
  term.setCursorPos(1, 1)
  print("Select Source Inventory:")
  local source = selectOption(peripheral.getNames(), "Select a source inventory:")
  term.clear()
  term.setCursorPos(1, 1)
  print("Select Destination Inventory:")
  local destination = selectOption(peripheral.getNames(), "Select a destination inventory:")
  return source, destination
end

-- Function to display a menu and get the user's selection
function selectOption(options, prompt)
  while true do
    print(prompt)
    for i, option in ipairs(options) do
      print(i .. ". " .. option)
    end
    print("Enter the number of your choice:")
    local choice = tonumber(read())
    if choice and choice >= 1 and choice <= #options then
      return options[choice]
    end
  end
end

-- Main program
local source, destination

-- Select source and destination inventories
source, destination = selectInventory()

term.clear()
term.setCursorPos(1, 1)
print("Enter the item you want to transfer:")
local item = read()
print("Enter the amount you want to transfer:")
local amount = tonumber(read())

createRoute(source, destination, item, amount)
