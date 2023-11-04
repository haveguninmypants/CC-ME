-- Function to read and execute registered routes
function executeRoutes()
  local routingTable = {}

  -- Specify the absolute path to the routing table file in the root directory
  local routingTablePath = "/routing_table"

  -- Read the routing table from the file
  if fs.exists(routingTablePath) then
    local file = fs.open(routingTablePath, "r")
    local contents = file.readAll()
    routingTable = textutils.unserialize(contents)
    file.close()
  end

  -- Loop through the routing table and execute routes
  for _, route in pairs(routingTable) do
    print("Transferring items from " .. route.source .. " to " .. route.destination)
    transferItems(route.source, route.destination, route.item, route.amount)
  end
end

-- Function to transfer items between two inventories without feedback
function transferItems(fromInventory, toInventory, itemName, amount)
  local itemsToTransfer = {}

  for slot, item in pairs(fromInventory.list()) do
    if item.name == itemName and item.count >= amount then
      itemsToTransfer[item.name] = {
        slot = slot,
        amount = amount
      }
      break
    end
  end

  if not next(itemsToTransfer) then
    return false
  end

  for _, itemInfo in pairs(itemsToTransfer) do
    fromInventory.pushItems(peripheral.getName(toInventory), itemInfo.slot, itemInfo.amount)
  end

  return true
end

-- Main program
while true do
  executeRoutes()

  -- Schedule the next execution in the background after a specified delay (e.g., 30 seconds)
  os.queueEvent("executeRoutes")
  os.pullEvent("executeRoutes")
end
