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
    print("Transferring fluids from " .. route.source .. " to " .. route.destination)
    local p1 = peripheral.wrap(route.source)
    local p2 = peripheral.wrap(route.destination)

    transferFluids(p1, p2, route.fluid, route.amount)
  end
end

-- Function to transfer fluids between two tanks without feedback
function transferFluids(fromTank, toTank, fluidName, amount)
  local fluidsToTransfer = {}

  for tank, fluidInfo in pairs(fromTank.listFluids()) do
    if fluidInfo.name == fluidName and fluidInfo.amount >= amount then
      fluidsToTransfer[fluidInfo.name] = {
        tank = tank,
        amount = amount
      }
      break
    end
  end

  if not next(fluidsToTransfer) then
    return false
  end

  for _, fluidInfo in pairs(fluidsToTransfer) do
    fromTank.pushFluid(peripheral.getName(toTank), fluidInfo.tank, fluidInfo.amount)
  end

  return true
end

-- Main loop
while true do
  -- Main program
  executeRoutes()
end
