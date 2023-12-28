-- Ore Scanner Script with Dynamic Options
local geoScanner = peripheral.wrap("back")
-- Function to display available ores
function displayOres()
    print("Available Ores:")
    print("1. Coal")
    print("2. Iron")
    print("3. Gold")
    print("4. Diamond")
    print("0. Exit")
    print("Enter the number of the ore you want to scan for or type the item name:")
end

-- Function to perform continuous scanning for a specific ore
function scanForOre(oreName)
    while true do
        local success, data, errorMessage = geoScanner.scan(16) -- Adjust the radius as needed

        if success then
            for _, blockInfo in ipairs(data) do
                if blockInfo.name == oreName then
                    print("Ore found at: X=" .. blockInfo.x .. " Y=" .. blockInfo.y .. " Z=" .. blockInfo.z)
                end
            end
        else
            print("Scan failed: " .. errorMessage)
        end

        local cooldown = geoScanner.getScanCooldown()
        print("Next scan in " .. cooldown .. " seconds.")
        sleep(cooldown)
    end
end

-- Main program
local geoScanner = peripheral.wrap("top") -- Adjust the side as needed
local oreOptions = {
    "minecraft:coal_ore",
    "minecraft:iron_ore",
    "minecraft:gold_ore",
    "minecraft:diamond_ore"
    -- Add more ores as needed
}

while true do
    displayOres()
    local userChoice = read()

    if userChoice == "0" then
        print("Exiting program.")
        break
    elseif tonumber(userChoice) then
        local choice = tonumber(userChoice)

        if choice > 0 and choice <= #oreOptions then
            local selectedOre = oreOptions[choice]
            print("Selected ore: " .. selectedOre)
            scanForOre(selectedOre)
        else
            print("Invalid choice. Please try again.")
        end
    else
        local customOre = userChoice
        print("Selected custom ore: " .. customOre)
        scanForOre(customOre)
    end
end
