-- Function to read and execute registered routes
function executeRoutes()
  local routingTable = {}

  -- Read the routing table from a file
  if fs.exists("routing_table") then
    local file = fs.open("routing_table", "r")
    local contents = file.readAll()
    routingTable = textutils.unserialize(contents)
    file.close()
  end

  -- Loop through the routing table and execute routes
  for _, route in pairs(routingTable) do
    print("Transferring items from " .. route.source .. " to " .. route.destination)
    local p1 = peripheral.wrap(route.source)
    local p2 = peripheral.wrap(route.destination)

    transferItems(p1,p2 , route.item, route.amount)
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
while true do
-- Main program
executeRoutes()
end
